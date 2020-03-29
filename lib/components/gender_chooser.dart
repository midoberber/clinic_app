
import 'package:flutter/material.dart';
import 'package:clinic_app/locale/localizations.dart';

class GenderChooser extends StatefulWidget {
  final ValueChanged<int> onRadioChanged;
  final int selectedValue;

  const GenderChooser({Key key, this.onRadioChanged, this.selectedValue})
      : super(key: key);

  @override
  _GenderChooserState createState() => _GenderChooserState();
}

class _GenderChooserState extends State<GenderChooser> {
  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Radio(
          value: 0,
          groupValue: widget.selectedValue,
          onChanged: widget.onRadioChanged,
        ),
        new Text(
          AppLocalizations.of(context).male,
          style: new TextStyle(fontSize: 16.0),
        ),
        new Radio(
          value: 1,
          groupValue: widget.selectedValue,
          onChanged: widget.onRadioChanged,
        ),
        new Text(
          AppLocalizations.of(context).female,
          style: new TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
