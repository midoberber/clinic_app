import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

class DelayDailog extends StatefulWidget {
  @override
  _DelayDailogState createState() => _DelayDailogState();
}

class _DelayDailogState extends State<DelayDailog> {
  int tag = 1;
  int tag1 = 1;

  List<String> days = [
    'Sunday',
    'Saturday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];
  List<String> hour = [
    "7:15 pm",
    "8:55 pm",
    "9:30 pm",
    "10:00 pm",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SimpleDialog(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Delay Date Session',
            style: TextStyle(
              color: Color(0xFF1BC0C5),
            ),
          ),
        ),
        children: <Widget>[
          ChipsChoice<dynamic>.single(
            value: tag,
            options: ChipsChoiceOption.listFrom<dynamic, String>(
              source: days,
              value: (i, v) => i,
              label: (i, v) => v,
            ),
            onChanged: (val) {
              setState(() => tag = val);
              print(val);
              print(tag);
            },
          ),
          SizedBox(
            height: 5,
          ),
          ChipsChoice<dynamic>.single(
            value: tag1,
            options: ChipsChoiceOption.listFrom<dynamic, String>(
              source: hour,
              value: (i, v) => i,
              label: (i, v) => v,
            ),
            onChanged: (valH) {
              setState(() => tag1 = valH);
              print(valH);
              print(tag);
            },
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: RaisedButton(
              onPressed: () {},
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
              color: const Color(0xFF1BC0C5),
            ),
          ),
        ],
      ),
    );
  }
}
