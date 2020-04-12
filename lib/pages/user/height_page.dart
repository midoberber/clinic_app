import 'package:clinic_app/modules/users/user_info_model.dart';
import 'package:clinic_app/modules/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:provider/provider.dart';

import 'height/height_card.dart';

class Height extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<UserInfoModel>(builder: (_, model, __) {
      int age = 0;
      if (model.birthDate != null) {
        final date2 = DateTime.now();
        age = date2.difference(model.birthDate).inDays ~/ 365;
      }

      return Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            InputSummaryCard(
              height: model.height,
              weight: model.weight,
              age: age.toInt(),
              gender: model.gender,
            ),
            Expanded(
                child: Column(
              children: <Widget>[
                Expanded(
                  child: HeightCard(
                    height: model.height,
                    onChanged: (val) {
                      model.height = val;
                    },
                  ),
                )
              ],
            )),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    });
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
