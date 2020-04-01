import 'dart:io';

import 'package:chips_choice/chips_choice.dart';
import 'package:clinic_app/components/custom_button.dart';
import 'package:flutter/material.dart';
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
    "7am - 10am",
    "11am - 2pm",
    "3pm - 6pm",
    "7pm-10pm",
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(
                            "First Session",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Selct Day :",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
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
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Selct Hour :",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
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
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 15,
            ),
            _image == null
                ? FlatButton.icon(
                    icon: Icon(Icons.add_a_photo),
                    label: Text('select image to payment receipt'),
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
          text: "Save",
        ),
      ),
    );
  }
}
