import 'dart:ui' as ui;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';
import 'package:clinic_app/locale/localizations.dart';
import 'package:clinic_app/modules/auth/user_entity.dart';
import 'package:clinic_app/modules/utils/extentions.dart';
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

  bool _isWheelEnabled = false;
  bool get isWheelEnabled => _isWheelEnabled;

  bool _isRegisterdNotification = false;
  AppStateModel({
    @required this.repository,
    AppState state,
  }) : _state = state ?? AppState.uninitialized;

  void load() async {
    _state = AppState.authenticated;

    var user = repository.loadUser();
    AppData data = repository.loadAppData();

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

    if (data.token.isNullOrEmpty()) {
      _state = AppState.unauthenticated;
    }

    if (!(data.isCompleted ?? true)) {
      _state = AppState.not_completed;
    }

    _isWheelEnabled = data.isWheelEnabled;

    notifyListeners();
  }

  void registerFireBase(BuildContext context) async {
    print(_isRegisterdNotification);
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

  void completeInfo(
    String name,
    String photo,
  ) async {
    AppData data = repository.loadAppData();
    await repository.store.setAppData(data.compyWith(isCompleted: true));
    await repository.store
        .setUser(_userEntity.compyWith(displayName: name, photo: photo));

    this.load();
  }

  void authenticate(
    AppData data,
    UserEntity entity,
  ) async {
    // set in the storage ..
    await repository.store.setAppData(data);
    await repository.store.setUser(entity);
    // reload the state ..

    this.load();
  }

  void unauthenticate() async {
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
