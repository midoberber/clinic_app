import 'package:clinic_app/components/email_field.dart';
import 'package:clinic_app/components/password.dart';
import 'package:clinic_app/modules/app/app_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'forgot_password.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
                'Welcome, Login to your account',
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
              PasswordField(
                labelText: "Password",
                controller: password,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage(),
                          ),
                        );
                      },
                    ),
                    FlatButton(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 30),
                      shape: StadiumBorder(),
                      color: Colors.white,
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 15, color: Theme.of(context).accentColor),
                      ),
                      onPressed: () {
                        if (email.text.isNotEmpty && password.text.isNotEmpty) {
                          Provider.of<AppStateModel>(context, listen: false)
                              .handleSignInEmail(
                                  context, email.text, password.text);
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
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FlatButton.icon(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7.0, horizontal: 10),
                      shape: StadiumBorder(),
                      color: Colors.white,
                      label: Text(
                        "Continue with Facebook",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      icon: Icon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        Provider.of<AppStateModel>(context, listen: false)
                            .signInWithFacebook(context);

                        // provider.signInWithFacebook(context);
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  FlatButton.icon(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7.0, horizontal: 10),
                      shape: StadiumBorder(),
                      color: Colors.white,
                      label: Text(
                        "Continue with Google",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      icon: Icon(
                        FontAwesomeIcons.google,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {
                        Provider.of<AppStateModel>(context, listen: false)
                            .signInWithGoogle(context);
                      }),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text('Don\'t have an account?')),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: FlatButton(
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ),
                    );
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
