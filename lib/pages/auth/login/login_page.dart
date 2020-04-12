// import 'dart:convert';

// import 'package:clinic_app/components/custom_button.dart';
// import 'package:clinic_app/components/email_field.dart';
// import 'package:clinic_app/components/password.dart';
// import 'package:clinic_app/modules/users/firbase_auth.dart';
// import 'package:clinic_app/pages/auth/signup/select_gender_weight_age.dart';
// import 'package:clinic_app/pages/auth/signup/signup_page.dart';
// import 'package:clinic_app/pages/home/home.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import '../login/forgot_password.dart';
// import 'package:provider/provider.dart';
// import 'package:clinic_app/modules/auth/login_model.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   // String _email;
//   // String _password;
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _email = TextEditingController();
//   TextEditingController _password = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => LoginModel(),
//       child: Consumer<LoginModel>(
//         builder: (ctx, provider, child) => Scaffold(
//           backgroundColor: Color(0xfff0f0f0),
//           body: SafeArea(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     height: MediaQuery.of(context).size.height * 0.22,
//                     // padding: EdgeInsets.all(10),
//                     child: Image.asset(
//                       'assets/images/medicine.png',
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Column(
//                     children: <Widget>[
//                       Container(
//                         width: double.infinity,
//                         height: MediaQuery.of(context).size.height * 0.40,
//                         decoration: new BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.bottomCenter,
//                             end: Alignment.topCenter,
//                             colors: <Color>[
//                               Theme.of(context).primaryColor,
//                               HexColor("#DC3790")
//                             ],
//                           ),
// //                    color: Theme.of(context).primaryColor,
//                           boxShadow: [
//                             new BoxShadow(blurRadius: 5.0, color: Colors.grey)
//                           ],
//                           borderRadius: new BorderRadius.vertical(
//                               bottom: new Radius.elliptical(
//                                   MediaQuery.of(context).size.width, 100.0)),
//                         ),
//                         child: SingleChildScrollView(
//                           child: Container(
//                             padding: EdgeInsets.only(left: 30, right: 30),
//                             child: Form(
//                               key: _formKey,
//                               child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     //============================================= Name Box

//                                     EmailField(
//                                       hintText: "Email",
//                                       controller: _email,
//                                     ),
//                                     //============================================= Password Box

//                                     PasswordField(
//                                       labelText: "Password",
//                                       controller: _password,
//                                     ),

//                                     FittedBox(
//                                       child: Container(
//                                         padding: EdgeInsets.only(
//                                             top: 20, bottom: 20),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             FlatButton(
//                                               child: Text(
//                                                 'Forgot Password?',
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 16,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                               onPressed: () {
//                                                 Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         ForgotPasswordPage(),
//                                                   ),
//                                                 );
//                                               },
//                                             ),
//                                             provider.loading
//                                                 ? Center(
//                                                     child:
//                                                         CircularProgressIndicator(),
//                                                   )
//                                                 : BorderButton(
//                                                     text: 'LOG IN',
//                                                     callback: () {
//                                                       if (_formKey.currentState
//                                                           .validate()) {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder: (BuildContext
//                                                                         context) =>
//                                                                     Home()));

//                                                         _loginNow();
//                                                       }
//                                                     },
//                                                   )
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   ]),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.05,
//                   ),
//                   Column(
//                     children: <Widget>[
//                       FittedBox(
//                         child: Container(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: <Widget>[
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: FlatButton.icon(
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius:
//                                           new BorderRadius.circular(18.0),
//                                       side: BorderSide(color: Colors.white)),
//                                   color: Colors.white,
//                                   label: Text(
//                                     "Log in with Facebook",
//                                     style: TextStyle(
//                                         fontSize: 12, color: Colors.black),
//                                   ),
//                                   icon: Icon(
//                                     FontAwesomeIcons.facebookSquare,
//                                     color: Colors.blue,
//                                   ),
//                                   onPressed: () {},
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: FlatButton.icon(
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius:
//                                           new BorderRadius.circular(18.0),
//                                       side: BorderSide(color: Colors.white)),
//                                   color: Colors.white,
//                                   label: Text(
//                                     "Log in with Google",
//                                     style: TextStyle(
//                                         fontSize: 12, color: Colors.black),
//                                   ),
//                                   icon: Icon(
//                                     FontAwesomeIcons.gofore,
//                                     color: Colors.blue,
//                                   ),
//                                   onPressed: () {
//                                     _googleSignUp().whenComplete(() {
//                                       Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                           builder: (context) {
//                                             return SelectGenderWeightAge();
//                                           },
//                                         ),
//                                       );
//                                     });
//                                   },
//                                 ),
//                               ),
//                               // InkWell(
//                               //   onTap: () {
//                               //     // authService.googleSignIn().then((user) {
//                               //     //   if (user?.uid != null) {
//                               //     //     Navigator.pop(context);
//                               //     //   }
//                               //     // });
//                               //   },
//                               //   child: Image.asset(
//                               //     'assets/images/google.png',
//                               //     width: 150,
//                               //     height: 60,
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
// //                    padding: EdgeInsets.all(10),
// //                      height: MediaQuery.of(context).size.height * 0.25,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: <Widget>[
//                             Divider(
//                               height: 5,
//                               color: Colors.black54,
//                             ),
//                             Container(
//                                 margin: EdgeInsets.only(top: 10),
//                                 child: Text('Don\'t have an account?')),
//                             Container(
//                               margin: EdgeInsets.only(top: 10),
//                               child: FlatButton(
//                                 child: Text(
//                                   'SIGN UP',
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black54),
//                                 ),
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => SignUpPage(),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // String getNotificationUrl =
//   //     'http://54.255.239.59/customer_api/Account/sign_in';

//   _loginNow() async {
//     // await http.post(getNotificationUrl, headers: {
//     //   'Content-Type': 'application/x-www-form-urlencoded'
//     // }, body: {
//     //   "api_key": '293df0c34d1d7d71fe036200cb70e871',
//     //   "email": _email,
//     //   "password": _password,
//     //   "fcm_token": 'fcmtoken',
//     //   "device_id": 'device id'
//     // }).then((response) {
//     //   var data = json.decode(response.body);
//     //   // print(data);
//     //   Navigator.pop(context);
//     //   setState(() {
//     //     print('Result => ${data['message']}');
//     //   });
//     // });
//   }
//   Future<void> _googleSignUp() async {
//     try {
//       final GoogleSignIn _googleSignIn = GoogleSignIn(
//         scopes: ['email'],
//       );
//       final FirebaseAuth _auth = FirebaseAuth.instance;

//       final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final AuthCredential credential = GoogleAuthProvider.getCredential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       final FirebaseUser user =
//           (await _auth.signInWithCredential(credential)).user;
//       print("signed in " + user.displayName);

//       return user;
//     } catch (e) {
//       print(e.message);
//     }
//   }
// }
