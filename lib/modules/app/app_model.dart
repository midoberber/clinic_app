import 'dart:convert';
import 'dart:ui' as ui;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';
import 'package:clinic_app/locale/localizations.dart';
import 'package:clinic_app/modules/auth/user_entity.dart';
import 'package:clinic_app/modules/utils/extentions.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'app_entity.dart';
import 'app_repository.dart';

class AppStateModel extends ChangeNotifier {
  final AppRepository repository;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  SpecificLocalizationDelegate _specificLocalizationDelegate =
      new SpecificLocalizationDelegate(Locale(ui.window.locale.languageCode));
  SpecificLocalizationDelegate get specificLocalizationDelegate =>
      _specificLocalizationDelegate;

  AppState _state = AppState.uninitialized;
  AppState get state => _state;
  set state(AppState state) {
    _state = state;
    notifyListeners();
  }

  UserEntity _userEntity;
  UserEntity get userEntity => _userEntity;

  bool _isRegisterdNotification = false;
  
  AppStateModel({
    @required this.repository,
    AppState state,
  }) : _state = state ?? AppState.uninitialized;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();

  // final Face
  Future signInWithGoogle(
    BuildContext context,
  ) async {
    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    // authResult.user.getIdToken();
    // Checking if email and name is null

    _processOauthLogin(context, user.displayName, user.email, user.photoUrl);

    // send them to the backend ..

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
  }

  Future signInWithFacebook(BuildContext context) async {
    _facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;

    final result = await _facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture.width(200).height(200),email&access_token=${token}');
        final profile = json.decode(graphResponse.body);
        // send to the oauth server api ..
        _processOauthLogin(context, profile["name"], profile["email"],
            profile["picture"]["data"]["url"]);
        break;
      case FacebookLoginStatus.cancelledByUser:
        Toast.show("Canceled Login", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        break;
      case FacebookLoginStatus.error:
        Toast.show("Something Wrong happend, Cann't login", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        break;
    }
  }

  Future handleSignInEmail(
      BuildContext context, String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final FirebaseUser user = result.user;
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);

      print('signInEmail succeeded: $user');
      _processOauthLogin(context, "", email, "");
    } catch (e) {
      Toast.show("Invalid Email or Password", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  Future handleSignUp(BuildContext context, email, password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final FirebaseUser user = result.user;

      if (!user.isEmailVerified) {
        // navigate to the verify your email
        await user.sendEmailVerification();
      }
      Navigator.pop(context);

      _processOauthLogin(context, "", email, "");
    } catch (e) {
      Toast.show(e.message.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  _processOauthLogin(
      BuildContext context, String name, String email, String avatar) async {
    // update the user in the database ...
    print("Enter authenticate .. ");
    var response = await http.post('http://206.189.238.178:3000/authenticate',
        body: json.encode({
          "email": email,
          "name": name,
          "avatar": avatar,
        }),
        headers: {'content-type': 'application/json'});
    // returns a JWT and meta data
    print(response.body);
    print(response.statusCode);
    dynamic responseDecoded = json.decode(response.body);

    var user = new UserEntity(
        displayName: name, id: responseDecoded["id"], photoUrl: avatar);

    var appData = AppData(
        isCompleted: responseDecoded["isCompleted"],
        token: responseDecoded["token"],
        languageCode: Localizations.localeOf(context).languageCode,
        isWheelEnabled: false);
    // auth the app .
    authenticate(appData, user);
    // app complete its cycle ..
  }

  void load() async {
    _state = AppState.uninitialized;
    // await _auth.signOut();
    // await unauthenticate();
    var user = repository.loadUser();
    AppData data = repository.loadAppData();

    final FirebaseUser currentUser = await _auth.currentUser();

    if (currentUser != null && !currentUser.isEmailVerified) {
      _state = AppState.notVerified;
      notifyListeners();
      return;
    }

    if (data == null || user == null) {
      _state = AppState.unauthenticated;
      notifyListeners();
      return;
    }

    _userEntity = user;
    if (!data.languageCode.isNullOrEmpty()) {
      _specificLocalizationDelegate =
          new SpecificLocalizationDelegate(Locale(data.languageCode));
    }

    if (!(data.isCompleted ?? true)) {
      _state = AppState.notCompleted;
      notifyListeners();
      return;
    }

    if (data.token.isNullOrEmpty()) {
      _state = AppState.unauthenticated;
    }
 
    _state = AppState.authenticated;

    notifyListeners();
  }

  void registerFireBaseMessaging(BuildContext context) async {
    // print(_isRegisterdNotification);
    if (!_isRegisterdNotification) {
      GraphQLClient _client = GraphQLProvider.of(context)?.value;
      if (_client == null) {
        return;
      }
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          _showMessage(context, message);
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          // _navigateToItemDetail(message);
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
          // _navigateToItemDetail(message);
        },
      );

      _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true),
      );

      _firebaseMessaging.subscribeToTopic("public");

      _firebaseMessaging.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {
        print("Settings registered: $settings");
      });

      String token = await _firebaseMessaging.getToken();
      // MUTATE USER WITH GRAPHQL ..
      QueryResult userUpdate =
          await _client.mutate(MutationOptions(documentNode: gql("""
            mutation updateToken(\$token: String! , \$user:uuid!) {
              update_user(_set: {token: \$token}, where: {id: {_eq: \$user}}) {
                affected_rows
              }
            }
        """), variables: {"token": token, "user": userEntity.id}));
      _isRegisterdNotification = true;
    }
  }

  void _showMessage(BuildContext context, Map<String, dynamic> data) {
    final snackBar = SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      content: Container(
          height: 120,
          child: Column(
            children: <Widget>[
              Text(data["notification"]["title"]),
            ],
          )),
      action: SnackBarAction(
        label: 'View',
        onPressed: () {
          // call navigation mapper ..
        },
      ),
      duration: Duration(seconds: 10),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void completeInfo() async {
    AppData data = repository.loadAppData();
    await repository.store.setAppData(data.compyWith(isCompleted: true));
    this.load();
  }

  void verifyEmail() async {
    final FirebaseUser currentUser = await _auth.currentUser();
    if (currentUser != null && currentUser.isEmailVerified) {
      _state = AppState.notCompleted;
    }
    notifyListeners();
  }

  void authenticate(
    AppData data,
    UserEntity entity,
  ) async {
    // set in the storage ..
    await repository.store.setAppData(data);
    await repository.store.setUser(entity);
    this.load();
  }

  void unauthenticate() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    await _facebookLogin.logOut();

    await repository.store.setAppData(null);
    await repository.store.setUser(null);
    // reload the state ..
    this.load();
  }

  void onLocaleChange(Locale locale) {
    _specificLocalizationDelegate = new SpecificLocalizationDelegate(locale);
    notifyListeners();
  }
}
