import 'package:clinic_app/modules/app/app_theme.dart';
import 'package:clinic_app/modules/utils/datetimeHelpers.dart';
import 'package:flutter/material.dart';

class Session extends StatelessWidget {
  final dynamic session;

  const Session({Key key, this.session}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> timeSegments = session["session_time"].toString().split(":");
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${session["session_index"].toString().toUpperCase()} SESSION",
                  style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.date_range,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('date',
                        style: TextStyle(
                            color: primary, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.timer,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(getTimeFormated(context,TimeOfDay(hour:int.parse(timeSegments[0]) , minute:  int.parse(timeSegments[1])) ),
                        style: TextStyle(
                            color: primary, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.warning),
              SizedBox(
                height: 10,
              ),
              Text(session["session_status"])
            ],
          ),
        ],
      ),
    );
  }
}
