import 'package:clinic_app/modules/app/app_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NotActivated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Icon(
              FontAwesomeIcons.envelopeOpenText,
              size: 100,
              color: Theme.of(context).accentColor,
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'We sent an email with an activation link , click the Link and Tap Continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            FlatButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30),
                shape: StadiumBorder(),
                color: Colors.white,
                child: Text(
                  "Continue",
                  style: TextStyle(
                      fontSize: 15, color: Theme.of(context).accentColor),
                ),
                onPressed: Provider.of<AppStateModel>(context, listen: false)
                    .verifyEmail),
          ],
        ),
      )),
    );
  }
}
