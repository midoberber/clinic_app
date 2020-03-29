import 'package:flutter/material.dart';

class GenericTextField extends StatefulWidget {
  const GenericTextField(
      {this.fieldKey,
      this.helperText,
      this.labelText,
      this.hintText,
      this.onFieldSubmitted,
      this.onSave,
      this.controller,
      this.maxLength,
      this.onValidate,
      this.icon});

  final fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSave;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<String> onValidate;
  final TextEditingController controller;
  final int maxLength;
  final Icon icon;

  @override
  State<StatefulWidget> createState() {
    return _GenericTextField();
  }
}

class _GenericTextField extends State<GenericTextField> {
  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      key: widget.fieldKey,
      controller: widget.controller,
      maxLength: widget.maxLength,
      onSaved: widget.onSave,
      // autovalidate: true,
      validator: widget.onValidate,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: new InputDecoration(
        prefixIcon: widget.icon,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
      ),
    );
  }
}
