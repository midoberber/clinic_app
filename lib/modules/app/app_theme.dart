import 'package:clinic_app/components/custom_button.dart';
import 'package:flutter/material.dart';

const gradiantColors = [
  Color(0xff009a86),
  Color(0xff006b7d),
  Color(0xff0E3D51)
];
// 0xff1F3864
class ClinicAppTheme {
  static ThemeData get theme {
    // final themeData = ThemeData.light();
    // final textTheme = themeData.textTheme;
    // final body1 = textTheme.body1.copyWith(decorationColor: Colors.transparent);

    return ThemeData.light().copyWith(
      primaryColor: HexColor("#FF2970"),
      accentColor: HexColor("#FF2970"),
      buttonColor: Color(0xff0E3D51),
      textSelectionColor: Color(0xff39556a),
      toggleableActiveColor: Color(0xff39556a),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0xff0E3D51),
      ),
      // snackBarTheme: SnackBarThemeData(
      //   backgroundColor: themeData.dialogBackgroundColor,
      //   contentTextStyle: body1,
      //   actionTextColor: Color(0xff39556a),
      // ),
      // textTheme: textTheme.copyWith(
      //   body1: body1,
      // ),
    );
  }
}
