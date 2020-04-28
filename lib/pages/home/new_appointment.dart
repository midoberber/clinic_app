import 'dart:io';
import 'package:clinic_app/modules/appointments/new_appointment_model.dart';
import 'package:clinic_app/modules/utils/datetimeHelpers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NewAppointment extends StatefulWidget {
  @override
  _NewAppointmentState createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  int _currentStep = 0;

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewAppointmentModel()..init(context),
      child: Consumer<NewAppointmentModel>(
        builder: (context, provider, child) => Scaffold(
          backgroundColor: Color(0xfff0f0f0),
          appBar: AppBar(
            title: Text("Reserve New Appointment"),
          ),
          body: SingleChildScrollView(
              child: Container(
            child: Column(
              children: <Widget>[
                Stepper(
                  controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue,
                      VoidCallback onStepCancel}) {
                    return Row(
                      children: <Widget>[
                        Container(
                          child: null,
                        ),
                        Container(
                          child: null,
                        ),
                      ],
                    );
                  },
                  onStepTapped: (index) {
                    setState(() {
                      _currentStep = index;
                    });
                  },
                  currentStep: _currentStep,
                  onStepContinue: () {
                    if (_currentStep >= 4) return;
                    setState(() {
                      _currentStep += 1;
                    });
                  },
                  onStepCancel: () {
                    if (_currentStep <= 0) return;
                    setState(() {
                      _currentStep -= 1;
                    });
                  },
                  steps: <Step>[
                    Step(
                      isActive: true,
                      state: StepState.editing,
                      title: Text(
                        "Define Your Schedule",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      content: SizedBox(
                        child: Container(
                            child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.filter_1),
                              title: InkWell(
                                  onTap: () => provider.selectDate(context),
                                  child: Text(
                                    provider.startDate == null
                                        ? "Select Date"
                                        : ("${getDayName(provider.startDate)} ${provider.startDate.toString().split(' ')[0]}"),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              subtitle: InkWell(
                                onTap: () => provider.selectTime(context),
                                child: Text(
                                  provider.startTime == null
                                      ? "Select Time"
                                      : getTimeFormated(
                                          context, provider.startTime),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.filter_2),
                              title: Text(
                                (provider.startDate == null
                                    ? "--/--/----"
                                    : "${getDayName(provider.startDate.add(Duration(days: 7)))} ${provider.startDate.add(Duration(days: 7)).toString().split(' ')[0]}"),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text((provider.startTime == null
                                  ? "--:--"
                                  : getTimeFormated(
                                      context, provider.startTime))),
                            ),
                            ListTile(
                              leading: Icon(Icons.filter_3),
                              // trailing: Text("Saturday 12-05-2020"),
                              title: Text(
                                (provider.startDate == null
                                    ? "--/--/----"
                                    : "${getDayName(provider.startDate.add(Duration(days: 14)))} ${provider.startDate.add(Duration(days: 14)).toString().split(' ')[0]}"),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text((provider.startTime == null
                                  ? "--:--"
                                  : getTimeFormated(
                                      context, provider.startTime))),
                            ),
                            ListTile(
                              leading: Icon(Icons.filter_4),
                              // trailing: Text("Saturday 12-05-2020"),
                              title: Text(
                                (provider.startDate == null
                                    ? "--/--/----"
                                    : "${getDayName(provider.startDate.add(Duration(days: 21)))} ${provider.startDate.add(Duration(days: 21)).toString().split(' ')[0]}"),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text((provider.startTime == null
                                  ? "--:--"
                                  : getTimeFormated(
                                      context, provider.startTime))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FlatButton(
                                  child: Text("Next"),
                                  onPressed: () {
                                    setState(() {
                                      _currentStep += 1;
                                    });
                                  },
                                )
                              ],
                            )
                          ],
                        )),
                      ),
                    ),
                    Step(
                      isActive: true,
                      state: StepState.complete,
                      title: Text(
                        "Payment Receipt",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      content: SizedBox(
                        child: Column(
                          children: <Widget>[
                            FlatButton.icon(
                              icon: Icon(Icons.add_a_photo),
                              label: Text('Select image for payment receipt'),
                              onPressed: provider.getImage,
                            ),
                            if (provider.invoice != null)
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height: 300,
                                  child: Image.file(File(provider.invoice))),
                            Padding(
                              padding: const EdgeInsets.only(top:28.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  FlatButton(
                                    color: Theme.of(context).primaryColor,
                                    child: Text(
                                      "Submit Appointment",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      provider.save(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
