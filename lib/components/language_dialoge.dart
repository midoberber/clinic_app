import 'package:flutter/material.dart';

typedef void MyFormCallback(String result);

class MyForm extends StatefulWidget {
  final MyFormCallback onSubmit;

  MyForm({this.onSubmit});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  String value = "Arabic";

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
            'Choose Language',
            style: TextStyle(
              color: Colors.deepOrange,
            ),
          ),
        ),
        children: <Widget>[
          RadioListTile(
            activeColor: Colors.deepOrange,
            groupValue: value,
            title: Text(
              "Arabic",
              style: TextStyle(color: Colors.black),
            ),
            onChanged: (value) => setState(() => this.value = value),
            value: "Arabic",
          ),
          RadioListTile(
            activeColor: Colors.deepOrange,
            groupValue: value,
            title: Text("English"),
            onChanged: (value) => setState(() => this.value = value),
            value: "English",
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onSubmit(value);
            },
            child: new Text("Done"),
          )
        ],
      ),
    );
  }
}
