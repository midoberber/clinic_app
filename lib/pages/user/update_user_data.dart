import 'package:clinic_app/components/custom_button.dart';
import 'package:clinic_app/modules/users/user_info_model.dart';
import 'package:clinic_app/pages/user/height_page.dart';
import 'package:clinic_app/pages/user/select_gender_weight_age.dart';
import 'package:clinic_app/pages/user/user_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateUserData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserInfoModel(),
      child: Consumer<UserInfoModel>(
        builder: (_, model, __) => Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      model.currentPage == 0
                          ? 'Personal Info'
                          : model.currentPage == 1
                              ? "Gender and Weight"
                              : "Your Height",
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    '${model.currentPage + 1}/3',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              )),
          body: PageView(
            controller: model.controller,
            children: <Widget>[
              UserInfo(),
              SelectGenderWeight(),
              Height(),
            ],
          ),
          bottomNavigationBar: Container(
              // padding: EdgeInsets.only(top: 130, bottom: 20),
              child: Row(
            mainAxisAlignment: model.currentPage != 0
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
            children: <Widget>[
              if (model.currentPage != 0)
                FlatButton.icon(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    model.previous();
                  },
                  label: Text(
                    'GO BACK',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              CustomButton(
                text: 'NEXT',
                callback: () {
                  model.next(context);
                },
              )
            ],
          )),
        ),
      ),
    );
  }
}
