import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:clinic_app/modules/app/app_entity.dart';
import 'package:clinic_app/modules/app/app_model.dart';
import 'package:http/http.dart' as http;
import 'package:clinic_app/modules/auth/user_entity.dart';
import 'package:toast/toast.dart';

class LoginModel extends ChangeNotifier {
  String _countryCode;
  String get countryCode => _countryCode;

  set countryCode(String code) {
    _countryCode = code;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  _removeTrailingZero(String phone) {
    if (phone.startsWith('0')) {
      return _removeTrailingZero(phone.substring(1));
    }
    return phone;
  }

  void login(BuildContext context, String phone, String password,
      {String pushToken = ""}) async {
    _loading = true;
    notifyListeners();
    String lphone = "$_countryCode${_removeTrailingZero(phone)}";
    print(lphone);
    http.post('http://sha5af.com:3000/login?pushToken=$pushToken',
        body: json.encode({"phone": lphone, "password": password}),
        headers: {
          'content-type': 'application/json'
        }).then((http.Response response) {
      dynamic responseDecoded = json.decode(response.body);
      if (response.statusCode == 200) {
        try {
          var user = new UserEntity(
              displayName: "",
              id: responseDecoded["id"],
              photoUrl:
                  "https://shaghaph.fra1.digitaloceanspaces.com/assets/profile.png");

          var appData = AppData(
              isCompleted: responseDecoded["isCompleted"],
              token: responseDecoded["token"],
              languageCode: Localizations.localeOf(context).languageCode,
              isWheelEnabled: false);
          _loading = false;
          notifyListeners();

          Provider.of<AppStateModel>(context, listen: false)
              .authenticate(appData, user  );

          Navigator.pop(context);
        } catch (e) {
          print(e);
          Toast.show("Something Wrong happend ...", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

          _loading = false;
          notifyListeners();
        }
      } else {
        print(responseDecoded);
        Toast.show(responseDecoded["error"], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        _loading = false;
        notifyListeners();
      }
    });
  }
}
