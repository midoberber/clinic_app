  import 'package:flutter/material.dart';

List enDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  List arDays = [
    "الأثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
    "الجمعة",
    "السبت",
    "الأحد"
  ];

  String getDayName(DateTime dat) {
    print(dat.weekday);
    return enDays[dat.weekday - 1];
  }

  getTimeFormated(BuildContext context, TimeOfDay time) {
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    if (time != null) {
      String formattedTime =
          localizations.formatTimeOfDay(time, alwaysUse24HourFormat: false);
      return formattedTime;
    }
  }