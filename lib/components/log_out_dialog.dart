import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoutDialog extends StatelessWidget {
  final String alertMessage;

  const LogoutDialog({Key key, this.alertMessage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final store = Provider.of<AppStore>(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: SingleChildScrollView(
        child: Container(
            child: Column(
          children: <Widget>[
            Text(
              alertMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 2,
              color: Color(0xff707070),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton.icon(
                  label: Text("Cancle",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500)),
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: Colors.black,
                ),
                FlatButton.icon(
                  label: Text("Yes",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500)),
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    Navigator.pop(context);
                    // store.setToken(null);
                    // Provider.of<AppStore>(context).logout();
                  },
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
