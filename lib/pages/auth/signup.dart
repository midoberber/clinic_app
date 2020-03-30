import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clinic_app/components/bezier_container.dart';
import 'package:clinic_app/components/confirmation_code.dart';
import 'package:clinic_app/components/password.dart';
import 'package:clinic_app/components/phone_field.dart';
import 'package:clinic_app/locale/localizations.dart';
import 'package:clinic_app/modules/auth/register_model.dart';

import '_widgets.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController =
      new TextEditingController();

  Widget _loginAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Already have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text(
              'Login',
              style: TextStyle(
                  color: Color(0xff0E3D51),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  // renderContent(RegisterModel provider) {
  //   if (provider.isActivate) {
  //     return Column(
  //       children: <Widget>[
  //      // Spacer(),
  //         submitButton(
  //             context,
  //             "Activate Account",
  //             provider.loading
  //                 ? CircularProgressIndicator()
  //                 : () {
  //                     provider.activate(context, _confirmationCode.text);
  //                   }),
  //       ],
  //     );
  //   } else {
  //     return Column(
  //       children: <Widget>[],
  //     );
  //   }
  // }

  void showSimpleCustomDialog(
    BuildContext context,
  ) {
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Enter Your Activation Code.',
                style: TextStyle(color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Okay',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    color: Colors.red,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel!',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );

    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterModel(),
      child: Consumer<RegisterModel>(
        builder: (context, provider, child) => Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: SizedBox(),
                        ),
                        title(),
                        SizedBox(
                          height: 20,
                        ),
                        Text(AppLocalizations.of(context).register,
                            style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 20,
                        ),
                        PhoneField(
                          controller: _phoneController,
                          onCodeChanged: (code) {
                            provider.countryCode = code.dialCode;
                          },
                        ),
                        PasswordField(
                          controller: _passwordController,
                          labelText: AppLocalizations.of(context).enterPassword,
                        ),
                        PasswordField(
                          controller: _confirmPasswordController,
                          labelText:
                              AppLocalizations.of(context).confirmPassword,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        provider.loading
                            ? CircularProgressIndicator()
                            : submitButton(
                                context: context,
                                text: "Register",
                                onPress: provider.loading
                                    ? null
                                    : () {
                                        // call the login method .
                                        provider.register(
                                            context,
                                            _phoneController.text,
                                            _passwordController.text,
                                            _confirmPasswordController.text);
                                      }),
                        Expanded(
                          flex: 2,
                          child: SizedBox(),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _loginAccountLabel(),
                  ),
                  Positioned(top: 40, left: 0, child: backButton(context)),
                  Positioned(
                      top: -MediaQuery.of(context).size.height * .15,
                      right: -MediaQuery.of(context).size.width * .4,
                      child: BezierContainer())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
