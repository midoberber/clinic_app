import 'package:clinic_app/components/custom_button.dart';
import 'package:clinic_app/modules/utils/widget_utils.dart';
import 'package:clinic_app/pages/auth/signup/height/height_card.dart';
import 'package:flutter/material.dart';
import 'package:gender_selection/gender_selection.dart';

class Height extends StatefulWidget {
  final int weight;
  final Gender gender;
  final int age;

  const Height({Key key, this.weight, this.gender, this.age}) : super(key: key);
  @override
  _HeightState createState() => _HeightState();
}

int height = 170;

class _HeightState extends State<Height> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Select Height',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                Text(
                  '3/3',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
        ),
        InputSummaryCard(
          height: height,
          weight: widget.weight,
          age: widget.age,
          gender: widget.gender,
        ),
        Expanded(child: _buildCards(context)),
        SizedBox(
          height: 10,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  text: 'NEXT',
                  callback: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) =>SelectGoal()
                    //     ));
                  },
                ),
              ),
            ])
      ],
    ));
  }

  Widget _buildCards(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: HeightCard(
            height: height,
            onChanged: (val) => setState(() => height = val),
          ),
        )
      ],
    );
  }
}

class InputSummaryCard extends StatelessWidget {
  final int height;
  final int weight;
  final Gender gender;
  final int age;
  const InputSummaryCard(
      {Key key, this.height, this.weight, this.gender, this.age})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(screenAwareSize(16.0, context)),
      child: SizedBox(
        // height: screenAwareSize(32.0, context),
        child: Row(
          children: <Widget>[
            Expanded(child: _genderText()),
            _divider(),
            Expanded(child: _text("${age}Y")),
            _divider(),
            Expanded(child: _text("${weight}kg")),
            _divider(),
            Expanded(child: _text("${height}cm")),
          ],
        ),
      ),
    );
  }

  Widget _genderText() {
    String genderText =
        gender == null ? '-' : (gender == Gender.Male ? 'Male' : 'Female');
    return _text(genderText);
  }

  Widget _text(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Color.fromRGBO(143, 144, 156, 1.0),
        fontSize: 15.0,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _divider() {
    return Container(
      width: 1.0,
      color: Color.fromRGBO(151, 151, 151, 0.1),
    );
  }
}
