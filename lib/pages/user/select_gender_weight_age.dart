import 'package:clinic_app/modules/users/user_info_model.dart';
import 'package:clinic_app/pages/user/weight/weight_card.dart';
import 'package:flutter/material.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:provider/provider.dart';

class SelectGenderWeight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildCards(context);
  }

  Widget _buildCards(BuildContext context) {
    return Consumer<UserInfoModel>(
        builder: (_, model, __) => Column(
              children: <Widget>[
                // CardTitle("Gender"),
                Expanded(
                  child: GenderSelection(
                    selectedGender: model.gender,
                    femaleImage: AssetImage("assets/images/female.png"),
                    maleImage: AssetImage("assets/images/male.png"),
                    selectedGenderIconBackgroundColor: Colors.amber,
                    selectedGenderTextStyle: TextStyle(
                        color: Colors.amber,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                    onChanged: (ge) {
                      model.gender = ge;
                    },
                    size: 100,
                  ),
                ),

                Expanded(
                  child: WeightCard(
                    onChanged: (w) {
                      model.weight = w;
                    },
                    weight: model.weight,
                  ),
                ),
              ],
            ));
  }
}
