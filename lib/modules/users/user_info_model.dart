import 'package:flutter/cupertino.dart';

class UserInfoModel extends ChangeNotifier {
  DateTime _birthDate;
  DateTime get birthDate => _birthDate;
  set birthDate(DateTime bDate) {
    _birthDate = bDate;
    notifyListeners();
  }

  int _gender = 0;
  int get gender => _gender;
  set gender(int gend) {
    _gender = gend;
    notifyListeners();
  }

  String _avatar;
  String get avatar => _avatar;
  set avatar(String gend) {
    _avatar = gend;
    notifyListeners();
  }
}
