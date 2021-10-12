import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clinic_app/components/language_dialoge.dart';
import 'package:clinic_app/doctor/x_home_doctor.dart';
import 'package:clinic_app/modules/app/app_model.dart';
import 'package:clinic_app/modules/utils/oval-right-clipper.dart';
import 'package:clinic_app/pages/user/update_user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LightDrawerPage extends StatefulWidget {
  @override
  _LightDrawerPageState createState() => _LightDrawerPageState();
}

class _LightDrawerPageState extends State<LightDrawerPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  final Color primary = Colors.white;

  final Color active = Colors.grey.shade800;

  final Color divider = Colors.grey.shade600;

  @override
  Widget build(BuildContext context) {
    return _buildDrawer(context);
  }

  _buildDrawer(BuildContext context) {
    var user = Provider.of<AppStateModel>(context).userEntity;
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.exit_to_app,
                        color: active,
                      ),
                      onPressed: () {
                        _dialog_log_out();
                        // Provider.of<AppStateModel>(context, listen: false)
                        //     .unauthenticate();
                        // Navigator.pop(context);
                        //         showDialog(
                        // context: context,
                        // builder: (context) => LogoutDialog(alertMessage: "Log Out"));
                      },
                    ),
                  ),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Colors.orange, Colors.deepOrange])),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: user.photoUrl.isEmpty
                          ? AssetImage("assets/images/avatar.png")
                          : NetworkImage(user.photoUrl),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    user.displayName,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 30.0),
                  _buildRow(Icons.settings, "Profile Settings", onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                UpdateUserData()));
                  }),
                  _buildDivider(),
                  _buildRow(Icons.language, "Chanage language", onPressed: () {
                    showDialog(
                        context: context, builder: (context) => MyForm());
                  }),
                  _buildDivider(),
                  _buildRow(Icons.security, "Chanage Password", onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) => HomeDoctor()));
                  }),
                  _buildDivider(),
                  _buildRow(Icons.exit_to_app, "Log Out", onPressed: () {
                    _dialog_log_out();
                    // Provider.of<AppStateModel>(context, listen: false)
                    //     .unauthenticate();
                    // Navigator.pop(context);
                  }),
                  _buildDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _dialog_log_out() {
    return AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.INFO,
        body: Center(
          child: Text(
            'Are You Sure ',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        tittle: 'This is Ignored',
        desc: 'This is also Ignored',
        btnOkOnPress: () {
          Provider.of<AppStateModel>(context, listen: false).unauthenticate();
          Navigator.pop(context);
        },
        btnCancelOnPress: () {
          Navigator.pop(context);
        }).show();
  }

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget _buildRow(IconData icon, String title,
      {bool showBadge = false, Function onPressed}) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(children: [
          Icon(
            icon,
            color: active,
          ),
          SizedBox(width: 10.0),
          Text(
            title,
            style: tStyle,
          ),
          Spacer(),
          if (showBadge)
            Material(
              color: Colors.deepOrange,
              elevation: 5.0,
              shadowColor: Colors.red,
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                width: 25,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  "10+",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
        ]),
      ),
    );
  }
}
