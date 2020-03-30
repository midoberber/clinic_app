import 'package:flutter/material.dart';
import 'package:clinic_app/locale/localizations.dart';

class PasswordField extends StatefulWidget {
  const PasswordField(
      {this.fieldKey,
      this.helperText,
      this.labelText,
      this.hintText,
      this.onFieldSubmitted,
      this.onSave,
      this.controller,
      this.onChange});

  final fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSave;
  final ValueChanged<String> onFieldSubmitted;
  final TextEditingController controller;
  final Function onChange;
  @override
  State<StatefulWidget> createState() {
    return _PasswordField();
  }
}

class _PasswordField extends State<PasswordField> {
  bool _obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: new TextFormField(
        key: widget.fieldKey,
        obscureText: _obsecureText,
        controller: widget.controller,
        maxLength: 12,
        onSaved: widget.onSave,
        onChanged: widget.onChange,
        // autovalidate: true,
        validator: (value) {
          if (value.isEmpty) {
            return AppLocalizations.of(context).vldpasswordrequired;
          }
          if (value.length < 6) {
            return AppLocalizations.of(context).vldpasswordlength;
          }
          return null;
        },
        onFieldSubmitted: widget.onFieldSubmitted,

        decoration: new InputDecoration(
            hintText: widget.hintText,
            labelText: widget.labelText,
            helperText: widget.helperText,
            filled: true,
            fillColor: Colors.white,
            focusColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            suffixIcon: new GestureDetector(
              onTap: () {
                setState(() {
                  _obsecureText = !_obsecureText;
                });
              },
              child: new Icon(
                  _obsecureText ? Icons.visibility : Icons.visibility_off),
            )),
      ),
    );
  }
}
