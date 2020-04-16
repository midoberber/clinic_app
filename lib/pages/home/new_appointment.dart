import 'dart:io';

import 'package:chips_choice/chips_choice.dart';
import 'package:clinic_app/components/custom_button.dart';
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


  _buildAppointMentRow(
      String date, String time, Function onSelectDate, Function onSelectTime) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton.icon(
            onPressed: onSelectDate,
            icon: Icon(Icons.calendar_today),
            label: Text(date)),
        FlatButton.icon(
            onPressed: onSelectTime,
            icon: Icon(FontAwesomeIcons.clock),
            label: Text(time))
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      appBar: AppBar(
        title: Text("Reserve New Appointment"),
        backgroundColor: Color(0xff696b9e),
      ),
      body: ChangeNotifierProvider(
        create: (_) => NewAppointmentModel()..init(context),
        child: Consumer<NewAppointmentModel>(
          builder: (context, provider, child) => SingleChildScrollView(
            child: Container(
                child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.diceOne),
                    title: Text(
                      "First Week",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    // trailing: Text("Saturday 12-05-2020"),
                  ),
                ),
                // first Week

                _buildAppointMentRow(
                    (provider.startDate == null
                        ? "Tab to Choose Date"
                        : "${getDayName(provider.startDate)} ${provider.startDate.toString().split(' ')[0]}"),
                    (provider.startTime == null
                        ? "Tab to Choose Time"
                        : getTimeFormated(
                            context, provider.startTime)),
                    () => provider.selectDate(context),
                    () => provider.selectTime(context)),

                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.diceTwo),
                    title: Text(
                      "Second Week",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                _buildAppointMentRow(
                  (provider.startDate == null
                      ? "--/--/----"
                      : "${getDayName(provider.startDate.add(Duration(days: 7)))} ${provider.startDate.add(Duration(days: 7)).toString().split(' ')[0]}"),
                  (provider.startTime == null
                      ? "--:--"
                      : getTimeFormated(context, provider.startTime)),
                  null,
                  null,
                ),

                // second

                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.diceThree),
                    // trailing: Text("Saturday 12-05-2020"),
                    title: Text(
                      "Third Week",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                _buildAppointMentRow(
                  (provider.startDate == null
                      ? "--/--/----"
                      : "${getDayName(provider.startDate.add(Duration(days: 14)))} ${provider.startDate.add(Duration(days: 14)).toString().split(' ')[0]}"),
                  (provider.startTime == null
                      ? "--:--"
                      : getTimeFormated(context, provider.startTime)),
                  null,
                  null,
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.diceFour),
                    // trailing: Text("Saturday 12-05-2020"),
                    title: Text(
                      "Fourth Week",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                _buildAppointMentRow(
                  (provider.startDate == null
                      ? "--/--/----"
                      : "${getDayName(provider.startDate.add(Duration(days: 21)))} ${provider.startDate.add(Duration(days: 21)).toString().split(' ')[0]}"),
                  (provider.startTime == null
                      ? "--:--"
                      : getTimeFormated(context, provider.startTime)),
                  null,
                  null,
                ),

                // fourth ...

                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.moneyBillAlt),
                    title: Text(
                      "Payment Receipt",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                provider.invoice == null
                    ? FlatButton.icon(
                        icon: Icon(Icons.add_a_photo),
                        label: Text('Select image for payment receipt'),
                        onPressed: provider.getImage,
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Image.file(File(provider.invoice))),
                SizedBox(
                  height: 15,
                ),
                BorderButton(
                  callback: () {
                    provider.save(context);
                  },
                  text: "Submit Appointment",
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
