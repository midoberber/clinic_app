import 'package:clinic_app/components/custom_button.dart';
import 'package:clinic_app/components/email_field.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey),
        title: Text(
          'Forget Password',
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  child: Image.asset(
                    'assets/images/logo_tra.png',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Forget Password !',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                EmailField(
                  hintText: "Enter your email address",
                  controller: emailController,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 30),
                        shape: StadiumBorder(),
                        color: Colors.white,
                        child: Text(
                          "Send Reset Link",
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).accentColor),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            //
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'A link will be emailed to your email address to reset your password',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
