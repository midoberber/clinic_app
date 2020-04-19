import 'package:chips_choice/chips_choice.dart';
import 'package:clinic_app/components/expanded_widget.dart';
import 'package:clinic_app/components/language_dialoge.dart';
import 'package:clinic_app/doctor/delay_dailog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Open extends StatefulWidget {
  @override
  _OpenState createState() => _OpenState();
}

class _OpenState extends State<Open> {
  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);

  // String selectedValues;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   selectedValues = "Today";
  // }
  int tag = 1;

  List<String> days = [
    'Today',
    'This Week',
    'This Month',
    'Custom Date',
  ];
  final f = new DateFormat('yyyy-MM-dd');
  DateTime birthDay;
  var today = new DateTime.now();
  var month = DateTime.now().add(new Duration(days: 30));
  var week = DateTime.now().add(new Duration(days: 7));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // Text(selectedValues.toString()),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: DropdownButton<String>(
          //     onChanged: (String value) {
          //       setState(() {
          //         selectedValues = value;
          //       });
          //     },
          //     isExpanded: true,
          //     hint: Text('Select Date'),
          //     value: selectedValues,
          //     items: <String>[
          //       "Today",
          //       "This Week",
          //       "ThisMonth",
          //       "Custom Date",
          //     ].map((String value) {
          //       return new DropdownMenuItem<String>(
          //         value: value,
          //         child: new Text(value),
          //       );
          //     }).toList(),
          //   ),
          // ),
          Text(
            "Select date :",
            style: TextStyle(fontSize: 15, color: secondary),
          ),

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
          tag == 0
              ? Text(
                  f.format(DateTime.now()).toString(),
                  style: TextStyle(fontSize: 16, color: secondary),
                )
              : tag == 1
                  ? Text(
                      "From  " +
                          f.format(DateTime.now()).toString() +
                          " To " +
                          f.format(week),
                      style: TextStyle(fontSize: 16, color: secondary),
                    )
                  : tag == 2
                      ? Text(
                          "From  " +
                              f.format(DateTime.now()).toString() +
                              " To " +
                              f.format(month),
                          style: TextStyle(fontSize: 16, color: secondary),
                        )
                      : tag == 3
                          ? FlatButton.icon(
                              onPressed: () async {
                                birthDay = await showDatePicker(
                                    initialDate: birthDay ?? DateTime(2003),
                                    firstDate: DateTime(1970),
                                    lastDate: DateTime(2003),
                                    context: context);
                                setState(() {});
                              },
                              icon: const Icon(Icons.calendar_today),
                              label: Text(
                                birthDay == null
                                    ? "Choose your Custom Date"
                                    : '${birthDay.day.toString()}-${birthDay.month.toString()}-${birthDay.year.toString()}',
                                style:
                                    TextStyle(fontSize: 16, color: secondary),
                              ))
                          : Container(),
          ExpandedWidget(
              itemCount: 10,
              header: ListTile(
                title: Text(
                  "Khairy Mohamed",
                  style: TextStyle(fontSize: 17),
                ),
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/avatar.png"),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.timer,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("6:30",
                        style: TextStyle(
                            color: primary, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Divider(
                    height: 10,
                    color: Colors.black,
                  ),
                  ListTile(
                    title: Text(
                      "First Session",
                      style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        // SizedBox(
                        //   width: 8,
                        // ),
                        Icon(
                          Icons.date_range,
                          color: secondary,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("sun 22/3/2020",
                            style: TextStyle(
                                color: primary,
                                fontSize: 13,
                                letterSpacing: .3)),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.timer,
                          color: secondary,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("from 6:30 to 6:45",
                            style: TextStyle(
                                color: primary,
                                fontSize: 13,
                                letterSpacing: .3)),
                      ],
                    ),
                    trailing: GestureDetector(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.refresh,
                            color: secondary,
                            size: 25,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Delay",
                              style: TextStyle(
                                  color: primary,
                                  fontSize: 17,
                                  letterSpacing: .3)),
                        ],
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => DelayDailog());
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
