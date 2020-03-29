import 'package:flutter/material.dart';
import 'package:clinic_app/modules/app/app_repository.dart';
import 'package:clinic_app/modules/app/app_storage.dart';
import 'package:clinic_app/modules/app/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(clinic_appApp(
    repository: AppRepository(
      KeyValueStorage(
        await SharedPreferences.getInstance(),
      ),
    ),
  ));
}
