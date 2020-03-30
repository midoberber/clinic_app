import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clinic_app/components/bezier_container.dart';
import 'package:clinic_app/components/password.dart';
import 'package:clinic_app/components/phone_field.dart';
import 'package:clinic_app/locale/localizations.dart';
import 'package:clinic_app/modules/auth/login_model.dart';
import 'package:clinic_app/pages/auth/_widgets.dart';
import 'package:clinic_app/pages/auth/signup.dart';

class LoginPage extends StatefulWidget {
  LoginPage( ) : super();

 
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));
            },
            child: Text(
              'Register',
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginModel(),
      child: Consumer<LoginModel>(
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
                        SizedBox(
                          height: 80,
                        ),
                        title(),
                        SizedBox(
                          height: 20,
                        ),
                        Text(AppLocalizations.of(context).login,
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
                          helperText:
                              AppLocalizations.of(context).vldpasswordlength,
                          labelText:
                              AppLocalizations.of(context).vldpasswordrequired,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        provider.loading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : submitButton(
                                context:context,text:
                                "Login",
                                onPress:provider.loading
                                    ? null
                                    : () {
                                        // call the login method .
                                        provider.login(
                                            context,
                                            _phoneController.text,
                                            _passwordController.text);
                                      }),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerRight,
                          child: Text('Forgot Password ?',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                        _divider(),
                        _createAccountLabel(),
                        // _facebookButton(),
                        Expanded(
                          flex: 2,
                          child: SizedBox(),
                        ),
                      ],
                    ),
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
