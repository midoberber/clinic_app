import 'package:clinic_app/components/custom_button.dart';
import 'package:clinic_app/components/password.dart';
import 'package:clinic_app/modules/auth/register_model.dart';
import 'package:clinic_app/pages/auth/signup/pin_put.dart';
import 'package:clinic_app/pages/auth/signup/select_gender_weight_age.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _name;
  String _email;
  String _password;
  String _confirmPass;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPass = TextEditingController();

  bool passwordVisible = true;
  bool confirmPassVisible = true;
  @override
  void initState() {
    passwordVisible = true;
    confirmPassVisible = true;
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterModel(),
      child: Consumer<RegisterModel>(
        builder: (ctx, provider, child) => Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Account Registeration',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                            '1/3',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ),

                    //==================================== From Starts here
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      color: Colors.white,
                      child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //============================================= Name Box

                              _textField(
                                controller: name,
                                labelText: "Name",
                                textValdiation: 'Please enter your name',
                                onChanged: ((String name) {
                                  setState(() {
                                    _name = name;
                                    print(_name);
                                  });
                                }),
                              ),
                              //============================================= Email Box

                              _textField(
                                controller: email,
                                labelText: "Email Address",
                                textValdiation:
                                    'Please enter your email address',
                                onChanged: ((String email) {
                                  setState(() {
                                    _email = email;
                                    print(_email);
                                  });
                                }),
                              ),

                              //============================================= Password Box

                              PasswordField(
                                labelText: "Password",
                                controller: password,
                              ),
                              //============================================= Password Box
                              PasswordField(
                                labelText: "Confirm Password",
                                controller: confirmPass,
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(top: 130, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: Text(
                    'GO BACK',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                provider.loading
                    ? CircularProgressIndicator()
                    : CustomButton(
                        text: 'NEXT',
                        callback: () {
                          if (_formKey.currentState.validate()) {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PinPutPage(),
                              ),
                            );
                          }
                        },
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField(
      {String labelText,
      String textValdiation,
      Function onChanged,
      TextEditingController controller}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.black54,
          ),
          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          // focusedBorder:
          //     OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        textAlign: TextAlign.start,
        validator: (value) {
          if (value.isEmpty) {
            return textValdiation;
          }
          return null;
        },
      ),
    );
  }
}
