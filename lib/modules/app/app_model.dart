import 'dart:convert';
import 'dart:ui' as ui;
import 'package:clinic_app/modules/graphql/user_queries.dart';
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
import '../auth/user_entity.dart';
import 'app_entity.dart';
import 'app_repository.dart';

class AppStateModel extends ChangeNotifier {
  final String doctorId = "5f620038-c83b-4a05-b8d3-dffe21a420e9";

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

  bool _loading;
  bool get loading => _loading;

  bool _isRegisterdNotification = false;

  AppStateModel({
    @required this.repository,
    AppState state,
  }) : _state = state ?? AppState.uninitialized;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();

  Future signInWithGoogle(
    BuildContext context,
  ) async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      String code = Localizations.localeOf(context).languageCode;

      await _processOauthLogin(
          context, code, user.displayName, user.email, user.photoUrl);
    } catch (e) {
      _state = AppState.unauthenticated;
      notifyListeners();
    }
  }

  Future signInWithFacebook(BuildContext context) async {
    final result = await _facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture.width(200).height(200),email&access_token=${token}');
        final profile = json.decode(graphResponse.body);
        // send to the oauth server api ..
        String code = Localizations.localeOf(context).languageCode;
        await _processOauthLogin(context, code, profile["name"],
            profile["email"], profile["picture"]["data"]["url"]);
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
      _loading = true;
      notifyListeners();
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final FirebaseUser user = result.user;
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);

      String code = Localizations.localeOf(context).languageCode;
      _loading = false;
      notifyListeners();
      await _processOauthLogin(context, code, "", email, "");
    } catch (e) {
      Toast.show(e.message.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  Future handleSignUp(BuildContext context, email, password) async {
    try {
      _loading = true;
      notifyListeners();

      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final FirebaseUser user = result.user;

      if (!user.isEmailVerified) {
        // navigate to the verify your email
        await user.sendEmailVerification();
      }
      String code = Localizations.localeOf(context).languageCode;
      _loading = false;
      notifyListeners();

      Navigator.pop(context);
      await _processOauthLogin(context, code, "", email, "",
          authType: "register");
    } catch (e) {
      Toast.show(e.message.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  Future<void> resetPassword(BuildContext context, String email) async {
    try {
      _loading = true;
      notifyListeners();
      await _auth.sendPasswordResetEmail(email: email);
      _loading = false;
      notifyListeners();

      Navigator.pop(context);
    } catch (e) {
      Toast.show(e.message.toString(), context,
          duration: 3, gravity: Toast.BOTTOM);
      print("Email Error");
    }
  }

  Future<void> _processOauthLogin(BuildContext context, String languageCode,
      String name, String email, String avatar,
      {String authType = "login"}) async {
    try {
      // auth the app .
      GraphQLClient _client = GraphQLProvider.of(context)?.value;

      var result = await _client.query(QueryOptions(
          documentNode: gql(getUseByEmail), variables: {"email": email}));

      if (result.hasException) {
        throw "Can't Retrieve user ";
      }

      if (authType != "login" && result.data["user"].length == 0) {
        // register new user ...

        var newResult = await _client.mutate(MutationOptions(
            documentNode: gql(insertUser),
            variables: {"email": email, "name": name, "avatar": avatar}));

        if (newResult.hasException) {
          throw "Can't Create user ";
        }

        var newUser = newResult.data["user"]["returning"][0];

        setUserDataAndAuthenticate(
            name: newUser["display_name"],
            avatar: newUser["avatar"],
            isDoctor: newUser["isDoctor"],
            isCompleted: newUser["isCompleted"],
            languageCode: languageCode,
            id: newUser["id"]);

        return;
      }
      var user = result.data["user"][0];

      setUserDataAndAuthenticate(
          name: user["display_name"],
          avatar: user["avatar"],
          isDoctor: user["isDoctor"],
          isCompleted: user["isCompleted"],
          languageCode: languageCode,
          id: user["id"]);
    } catch (e) {
      Toast.show("Something Wrong happened", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      unauthenticate();
    }
  }

  void setUserDataAndAuthenticate(
      {String name,
      String avatar,
      bool isDoctor,
      String id,
      bool isCompleted,
      String languageCode}) {
    var user = new UserEntity(
        displayName: name, id: id, photoUrl: avatar, isDoctor: isDoctor);

    var appData = AppData(
      isCompleted: isCompleted,
      languageCode: languageCode,
    );
    authenticate(appData, user);
  }

  void load() async {
    _state = AppState.uninitialized;
    notifyListeners();
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

    _state = AppState.authenticated;

    notifyListeners();
  }

  void registerFireBaseMessaging(BuildContext context) async {
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
      QueryResult userUpdate = await _client.mutate(MutationOptions(
          documentNode: gql(updateUserToken),
          variables: {"token": token, "user": userEntity.id}));
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
    await currentUser.reload();
    this.load();
  }

  void authenticate(
    AppData data,
    UserEntity entity,
  ) async {
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
