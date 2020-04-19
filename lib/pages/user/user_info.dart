import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:clinic_app/components/generic_image_picker.dart';
import 'package:clinic_app/components/generic_text_box.dart';
import 'package:clinic_app/modules/users/user_info_model.dart';
import 'package:intl/intl.dart';

class UserInfo extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoModel>(
      builder: (context, provider, child) => Container(
        // color: Colors.white,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Center(
                child: GenericImagePicker(
                  redius: 70,
                  caption: "Pick Profile Photo",
                  defaultImage: provider.avatar == null
                      ? "assets/images/avatar.png"
                      : provider.avatar,
                  imgType: provider.avatar == null
                      ? DefaultImageType.local
                      : DefaultImageType.network,
                  onFileChanged: (file) {
                    if (file != null) {
                      provider.avatar = file.path;
                    }
                  },
                ),
              ),
              GenericTextField(
                controller: provider.nameController,
                maxLength: 30,
                labelText: "Your Full Name",
                icon: Icon(Icons.person),
              ),
              GenericTextField(
                controller: provider.phoneController,
                maxLength: 11,
                labelText: "Your Phone",
                icon: Icon(Icons.phone),
              ),
              GenericTextField(
                controller: provider.titleController,
                maxLength: 30,
                labelText: "Your Job Title",
                icon: Icon(FontAwesomeIcons.shoppingBag),
              ),
              GenericTextField(
                controller: provider.addressController,
                maxLength: 100,
                labelText: "Your Address",
                icon: Icon(Icons.map),
              ),

              // DateTimeField(
              //   format: format,
              //   decoration: InputDecoration(
              //     labelText: "Choose your Birthdate",
              //     prefixIcon: Icon(Icons.calendar_today),
              //   ),
              //   onShowPicker: (context, currentValue) {
              //     return showDatePicker(
              //         context: context,
              //         firstDate: DateTime(1970),
              //         initialDate: currentValue ?? DateTime.now(),
              //         lastDate: DateTime(2003));
              //   },
              // ),

              // SizedBox(height: 30),
              ListTile(
                  onTap: () async {
                    provider.birthDate = await showDatePicker(
                        // builder: (_, d) => Text("Date"),
                        initialDate: provider.birthDate ?? DateTime(2003),
                        firstDate: DateTime(1970),
                        lastDate: DateTime(2003),
                        context: context);
                  },
                  leading: const Icon(Icons.calendar_today),
                  title: Text(provider.birthDate == null
                      ? "Choose your Birthdate"
                      : '${provider.birthDate.day.toString()}-${provider.birthDate.month.toString()}-${provider.birthDate.year.toString()}')),
            ],
          ),
        ),
      ),
    );
  }
}
