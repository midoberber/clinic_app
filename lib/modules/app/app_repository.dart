import 'package:clinic_app/modules/app/app_entity.dart';
import 'package:clinic_app/modules/auth/user_entity.dart';

import 'app_storage.dart';

class AppRepository {
  final KeyValueStorage store;

  AppRepository(this.store);
   UserEntity loadUser() {
    return store.getUser();
  }

  AppData loadAppData() {
    return store.getAppData();
  }
}
