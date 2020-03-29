import 'dart:convert';

import 'package:clinic_app/modules/app/app_entity.dart';
import 'package:clinic_app/modules/auth/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorage {
  final SharedPreferences store;
  final JsonCodec codec;

  const KeyValueStorage(this.store, [this.codec = json]);

  UserEntity getUser() {
    var usr = store.getString("user");
    return usr == null ? null : UserEntity.fromJson(codec.decode(usr));
  }

  Future<bool> setUser(UserEntity user) {
    if(user == null){
      return store.remove("user");
    }
    String userStr = codec.encode(user?.toJson());
    return store.setString("user", userStr);
  }

  AppData getAppData() {
    var data = store.getString("data");
    return data == null ? new AppData() : AppData.fromJson(codec.decode(data));
  }

  Future<bool> setAppData(AppData appData) {
    if(appData == null){
      return store. remove("data");
    }
    String data = codec.encode(appData?.toJson());
    return store.setString("data", data);
  }

  // Future<bool> setLanguage(String language) {
  //   return store.setString("language", language);
  // }

  // Future<String> getLanguage() async {
  //   return store.getString("language");
  // }

  // Future<bool> setWheelView(bool isWheelToggled) {
  //   return store.setBool("wheel", isWheelToggled);
  // }

  // Future<bool> getWheelView() async {
  //   return store.getBool("wheel");
  // }
}
