import 'package:clinic_app/components/email_field.dart';
import 'package:clinic_app/components/password.dart';
import 'package:clinic_app/modules/app/app_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'activate.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  child: Image.asset(
                    'assets/images/logo_tra.png',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Create new Account',
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              EmailField(
                hintText: "Email",
                controller: email,
              ),
              SizedBox(
                height: 10,
              ),
              PasswordField(
                labelText: "Password",
                controller: password,
              ),
              PasswordField(
                labelText: "Confirm Password",
                controller: confirmPassword,
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
                        "Continue",
                        style: TextStyle(
                            fontSize: 15, color: Theme.of(context).accentColor),
                      ),
                      onPressed: () {
                        if (password.text != confirmPassword.text) {
                          Toast.show(
                              "Password and its Confirmation must be the same. ",
                              context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
                              return;
                        }
                        if (email.text.isNotEmpty && password.text.isNotEmpty) {
                          Provider.of<AppStateModel>(context, listen: false)
                              .handleSignUp(context, email.text, password.text);
                        } else {
                          Toast.show( 
                              "Please Enter your email and password ", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text('Already have account!?')),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: FlatButton(
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
