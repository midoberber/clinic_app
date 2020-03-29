import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clinic_app/modules/app/app_entity.dart';
import 'package:clinic_app/modules/app/app_model.dart';
import 'package:http/http.dart' as http;
import 'package:clinic_app/modules/auth/user_entity.dart';
import 'package:clinic_app/pages/auth/activate.dart';
import 'package:toast/toast.dart';

class RegisterModel extends ChangeNotifier {
  String _countryCode;
  String get countryCode => _countryCode;

  set countryCode(String code) {
    _countryCode = code;
    notifyListeners();
  }

  String _phoneNumber;
  String get phoneNumber => _phoneNumber;

  bool _loading = false;
  bool get loading => _loading;

  _removeTrailingZero(String phone) {
    if (phone.startsWith('0')) {
      return _removeTrailingZero(phone.substring(1));
    }
    return phone;
  }

  void register(BuildContext context, String phone, String password,
      String confirmPassword,
      {String pushToken = ""}) async {
    _phoneNumber = "$_countryCode${_removeTrailingZero(phone)}";
    _loading = true;
    notifyListeners();

    http.post('http://sha5af.com:3000/signup?pushToken=$pushToken',
        body: json.encode({
          "phone": _phoneNumber,
          "password": password,
          "confirmPassword": confirmPassword
        }),
        headers: {
          'content-type': 'application/json'
        }).then((http.Response response) {
      if (response.statusCode == 200) {
        try {
          _loading = false;
          notifyListeners();
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (_) => ActivatePage(
                        phone: _phoneNumber,
                      )));
        } catch (e) {
          print(e);
          Toast.show("Something Wrong happend ...", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          _loading = false;
          notifyListeners();
        }
      } else {
        dynamic responseDecoded = json.decode(response.body);

        print(responseDecoded);
        Toast.show(responseDecoded["error"], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        _loading = false;
        notifyListeners();
      }
    });
  }
}
