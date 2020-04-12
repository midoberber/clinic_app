import 'dart:io';

import 'package:chips_choice/chips_choice.dart';
import 'package:clinic_app/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class NewAppointment extends StatefulWidget {
  @override
  _NewAppointmentState createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  String dropdownValue;
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
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      appBar: AppBar(
        title: Text("Reserve New Appointment"),
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.chevronLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xff696b9e),
      ),
      body: SingleChildScrollView(
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
                trailing:Text("12-18/5"),
              ),
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
            Container(
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.diceTwo),
                trailing:Text("12-18/5"),

                title: Text(
                  "Second Week",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                // trailing: IconButton(icon: Icon(Icons.settings , color: Colors.grey[400], size: 22,), onPressed: (){}, ),
              ),
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

            Container(
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.diceThree),
                trailing:Text("12-18/5"),

                title: Text(
                  "Third Week",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                // trailing: IconButton(icon: Icon(Icons.settings , color: Colors.grey[400], size: 22,), onPressed: (){}, ),
              ),
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
            Container(
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.diceFour),
                trailing:Text("12-18/5"),

                title: Text(
                  "Fourth Week",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                // trailing: IconButton(icon: Icon(Icons.settings , color: Colors.grey[400], size: 22,), onPressed: (){}, ),
              ),
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
                // trailing: IconButton(icon: Icon(Icons.settings , color: Colors.grey[400], size: 22,), onPressed: (){}, ),
              ),
            ),
            _image == null
                ? FlatButton.icon(
                    icon: Icon(Icons.add_a_photo),
                    label: Text('Select image for payment receipt'),
                    onPressed: getImage,
                  )
                : Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Image.file(_image)),
            SizedBox(
              height: 15,
            ),
          ],
        )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BorderButton(
          callback: () {},
          text: "Submit Appointment",
        ),
      ),
    );
  }
}
