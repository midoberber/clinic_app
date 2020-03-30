import 'package:clinic_app/pages/auth/signup/select_gender_weight_age.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class PinPutPage extends StatefulWidget {
  @override
  _PinPutPageState createState() => _PinPutPageState();
}

class _PinPutPageState extends State<PinPutPage> {
  bool _unFocus = false;

  @override
  void initState() {
    setTimeOut();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Center(
          child: PinPut(
            fieldsCount: 4,
            autoFocus: true,
            unFocusWhen: _unFocus,
            onSubmit: (String pin) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectGenderWeightAge(),
              ),
            ),
            onClear: (String s) => _showSnackBar('Cleared $s', context),
          ),
        ),
      ),
    ));
  }

  void _showSnackBar(String pin, BuildContext context) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 3),
      content: Container(
          height: 80.0,
          child: Center(
            child: Text(
              'Pin Submitted. Value: $pin',
              style: TextStyle(fontSize: 25.0),
            ),
          )),
      backgroundColor: Colors.greenAccent,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void setTimeOut() {
    Stream<void>.periodic(Duration(seconds: 5)).listen((r) {
      setState(() {
        _unFocus = !_unFocus;
      });
    });
  }
}
