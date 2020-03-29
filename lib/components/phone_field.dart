import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/locale/localizations.dart';

class PhoneField extends StatefulWidget {
  const PhoneField(
      {this.fieldKey,
      this.helperText,
      this.labelText,
      this.hintText,
      this.onFieldSubmitted,
      this.onSave,
      this.controller,
      this.validator,
      this.onCodeChanged});
  final fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSave;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<CountryCode> onCodeChanged;
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() {
    return _PhoneField();
  }
}

class _PhoneField extends State<PhoneField> {
  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);

    return new TextFormField(
      controller: widget.controller,
      textAlign: TextAlign.left,
      key: widget.fieldKey,
      maxLength: 14,
      // autovalidate: true,
      textDirection: TextDirection.ltr,
      onSaved: widget.onSave,
      validator: (value) {
        if (value.isEmpty) {
          return AppLocalizations.of(context).vldphonerequired;
        }
        return null;
      },
      onFieldSubmitted: widget.onFieldSubmitted,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
      decoration: InputDecoration(
        hintStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
        helperStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
        counterStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        suffixIcon: currentLocale.languageCode == "ar"
            ? CountryCodePicker(
                // if lang is ar
                onChanged: widget.onCodeChanged,
                padding: EdgeInsets.only(bottom: 5),
                textStyle: TextStyle(fontSize: 16, color: Colors.grey),
                initialSelection: 'SA',
                favorite: ['SA', 'EG', 'AUE'],
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
              )
            : null,
        prefixIcon: currentLocale.languageCode == "en"
            ? CountryCodePicker(
                // if lang is english
                onChanged: widget.onCodeChanged,
                padding: EdgeInsets.only(bottom: 5),
                textStyle: TextStyle(fontSize: 16, color: Colors.grey),
                initialSelection: 'SA',
                favorite: ['SA', 'EG', 'AUE'],
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
              )
            : null,
        hintText: AppLocalizations.of(context).phoneNumber,
        // helperText: AppLocalizations.of(context).vldphonelength,
      ),
      keyboardType: TextInputType.phone,
    );
  }
}
