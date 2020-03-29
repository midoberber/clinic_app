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
      this.controller});

  final fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSave;
  final ValueChanged<String> onFieldSubmitted;
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() {
    return _PasswordField();
  }
}

class _PasswordField extends State<PasswordField> {
  bool _obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      key: widget.fieldKey,
      obscureText: _obsecureText,
      controller: widget.controller,
      maxLength: 12,
      onSaved: widget.onSave,
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
          prefixIcon: Icon(
            Icons.lock,
          ),
          hintText: widget.hintText,
          labelText: widget.labelText,
          helperText: widget.helperText,
          suffixIcon: new GestureDetector(
            onTap: () {
              setState(() {
                _obsecureText = !_obsecureText;
              });
            },
            child: new Icon(
                _obsecureText ? Icons.visibility : Icons.visibility_off),
          )),
    );
  }
}
