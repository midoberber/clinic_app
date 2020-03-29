import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:clinic_app/modules/app/app_entity.dart';
import 'package:clinic_app/modules/app/app_model.dart';
import 'package:http/http.dart' as http;
import 'package:clinic_app/modules/auth/user_entity.dart';
import 'package:toast/toast.dart';

class ActivateModel extends ChangeNotifier {
  ActivateModel(this.phoneNumber);

  final String phoneNumber;

  bool _loading = false;

  bool get loading => _loading;

  void activate(BuildContext context, String code) async {
    _loading = true;
    notifyListeners();

    http.post('http://sha5af.com:3000/activate',
        body: json.encode({
          "phone": phoneNumber,
          "activationCode": code,
        }),
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

          Provider.of<AppStateModel>(context, listen: false)
              .authenticate(appData, user  );
          Navigator.popUntil(
            context,
            ModalRoute.withName('/'),
          );
          // Navigator.pop(context , true);
          // _loading = false;
          // notifyListeners();
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
