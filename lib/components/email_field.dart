import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  final fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSave;
  final ValueChanged<String> onFieldSubmitted;
  final TextEditingController controller;

  const EmailField(
      {Key key,
      this.fieldKey,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSave,
      this.onFieldSubmitted,
      this.controller})
      : super(key: key);
  @override
  _EmailFieldState createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        key: widget.fieldKey,
        onSaved: widget.onSave,
        onFieldSubmitted: widget.onFieldSubmitted,
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.hintText,
          helperText: widget.helperText,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          filled: true,
          fillColor: Colors.white,
          focusColor: Colors.white,
        ),
        textAlign: TextAlign.start,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter full name';
          }
          return null;
        },
      ),
    );
  }
}
