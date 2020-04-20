import 'package:clinic_app/modules/app/app_theme.dart';
import 'package:clinic_app/modules/utils/datetimeHelpers.dart';
import 'package:flutter/material.dart';

class Session extends StatelessWidget {
  final dynamic session;

  const Session({Key key, this.session}) : super(key: key);

  _mapStatusToIcon(String status) {
    switch (status) {
      case "pending":
        return Icons.av_timer;
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> timeSegments = session["session_time"].toString().split(":");
    return ListTile(
        title: Text(
            "${session["session_index"].toString().toUpperCase()} SESSION"),
        subtitle: Row(
          children: <Widget>[
            Icon(
              Icons.date_range,
              color: secondary,
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text(session["session_date"],
                style:
                    TextStyle(color: primary, fontSize: 13, letterSpacing: .3)),
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
                style:
                    TextStyle(color: primary, fontSize: 13, letterSpacing: .3)),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(_mapStatusToIcon(session["session_status"])),
            SizedBox(
              height: 10,
            ),
            Text(session["session_status"])
          ],
        ),
        onTap: () {
          // navigate to the chat if its time is this ..
        });
  }
}
