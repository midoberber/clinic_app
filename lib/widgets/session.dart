import 'package:clinic_app/modules/app/app_theme.dart';
import 'package:clinic_app/modules/utils/datetimeHelpers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class Session extends StatelessWidget {
  final dynamic session;
  final bool showStatus;
  const Session({Key key, this.session, this.showStatus = false})
      : super(key: key);

  _mapStatusToIcon(String status) {
    switch (status) {
      case "pending":
        return FontAwesomeIcons.calendarWeek;
        break;
      case "done":
        return FontAwesomeIcons.calendarCheck;
      default:
        return FontAwesomeIcons.calendarTimes;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> timeSegments = session["session_time"].toString().split(":");
    return ListTile(
        title: Text(
          getDayName(DateTime.parse(session["session_date"])) +
              " " +
              session["session_date"],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: <Widget>[
            Icon(
              Icons.timer,
              color: secondary,
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
                getTimeFormated(
                    context,
                    TimeOfDay(
                        hour: int.parse(timeSegments[0]),
                        minute: int.parse(timeSegments[1]))),
                style: TextStyle(fontSize: 13, letterSpacing: .3)),
          ],
        ),
        trailing: showStatus
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(_mapStatusToIcon(session["session_status"])),
                  SizedBox(
                    height: 10,
                  ),
                  Text(session["session_status"])
                ],
              )
            : null,
        onTap: () {
          // navigate to the chat if its time is this ..
        });
  }
} 