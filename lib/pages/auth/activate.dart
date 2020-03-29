import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clinic_app/components/bezier_container.dart';
import 'package:clinic_app/components/confirmation_code.dart';
import 'package:clinic_app/modules/auth/activate_model.dart';
import 'package:clinic_app/pages/auth/_widgets.dart';
 
class ActivatePage extends StatefulWidget {
  ActivatePage({Key key, this.phone}) : super(key: key);

  final String phone;

  @override
  _ActivatePageState createState() => _ActivatePageState();
}

class _ActivatePageState extends State<ActivatePage> {
  TextEditingController _confirmationCode = new TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ActivateModel(widget.phone),
      child: Consumer<ActivateModel>(
        builder: (context, provider, child) => Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  provider.loading ? Center(child: CircularProgressIndicator()): Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
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
                        Text("Enter Activation Code Sent to your Phone",
                            style: TextStyle(fontSize: 16)),
                        SizedBox(
                          height: 20,
                        ),
                        PinCodeTextField(
                          autofocus: false,
                          controller: _confirmationCode,
                          hideCharacter: false,
                          highlight: true,
                          highlightColor: Colors.blue,
                          defaultBorderColor: Colors.black,
                          hasTextBorderColor: Colors.green,
                          maxLength: 4,
                          hasError: false,
                          // maskCharacter: "",
                          onTextChanged: (text) {
                             
                          },
                          onDone: (text) {
                            provider.activate(context, text);
                          },
                          pinCodeTextFieldLayoutType:
                              PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
                          wrapAlignment: WrapAlignment.start,
                          pinBoxDecoration:
                              ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                          pinTextStyle: TextStyle(fontSize: 30.0),
                          pinTextAnimatedSwitcherTransition:
                              ProvidedPinBoxTextAnimation.scalingTransition,
                          pinTextAnimatedSwitcherDuration:
                              Duration(milliseconds: 300),
                        ),
                        SizedBox(
                          height: 20,
                        ),

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
