import 'package:clinic_app/components/flat_appbar.dart';
import 'package:day_selector/day_selector.dart';
import 'package:flutter/material.dart';

class NewAppointment extends StatefulWidget {
  @override
  _NewAppointmentState createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  int _noOfQuestions;
  String _difficulty;
  bool processing;

  @override
  void initState() {
    super.initState();
    _noOfQuestions = 10;
    _difficulty = "easy";
    processing = false;
  }

  DateTime _selectedValue = DateTime.now();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      appBar: AppBar(
        title: Text("New"),
        backgroundColor: Color(0xfff0f0f0),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (BuildContext context, int) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "First Session",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "Select Day:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    DaySelector(
                        value: null,
                        onChange: (value) {},
                        mode: DaySelector.modeFull),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Select Hour :"),
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        runSpacing: 16.0,
                        spacing: 16.0,
                        children: <Widget>[
                          SizedBox(width: 0.0),
                          ActionChip(
                            label: Text("10:10"),
                            labelStyle: TextStyle(color: Colors.white),
                            backgroundColor: _noOfQuestions == 10
                                ? Colors.indigo
                                : Colors.grey.shade600,
                            onPressed: () => _selectNumberOfQuestions(10),
                          ),
                          ActionChip(
                            label: Text("20:20"),
                            labelStyle: TextStyle(color: Colors.white),
                            backgroundColor: _noOfQuestions == 20
                                ? Colors.indigo
                                : Colors.grey.shade600,
                            onPressed: () => _selectNumberOfQuestions(20),
                          ),
                          ActionChip(
                            label: Text("30:30"),
                            labelStyle: TextStyle(color: Colors.white),
                            backgroundColor: _noOfQuestions == 30
                                ? Colors.indigo
                                : Colors.grey.shade600,
                            onPressed: () => _selectNumberOfQuestions(30),
                          ),
                          ActionChip(
                            label: Text("40:40"),
                            labelStyle: TextStyle(color: Colors.white),
                            backgroundColor: _noOfQuestions == 40
                                ? Colors.indigo
                                : Colors.grey.shade600,
                            onPressed: () => _selectNumberOfQuestions(40),
                          ),
                          ActionChip(
                            label: Text("50:50"),
                            labelStyle: TextStyle(color: Colors.white),
                            backgroundColor: _noOfQuestions == 50
                                ? Colors.indigo
                                : Colors.grey.shade600,
                            onPressed: () => _selectNumberOfQuestions(50),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      height: 5,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                );
              },
            ),
          ],
        )),
      ),
    );
  }

  _selectNumberOfQuestions(int i) {
    setState(() {
      _noOfQuestions = i;
    });
  }
}
