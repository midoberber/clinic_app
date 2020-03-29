import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:clinic_app/components/gender_chooser.dart';
import 'package:clinic_app/components/generic_image_picker.dart';
import 'package:clinic_app/components/generic_text_box.dart';
import 'package:clinic_app/modules/users/user_info_model.dart';
import 'package:clinic_app/modules/utils/sys.dart';
import 'package:toast/toast.dart';
import 'package:clinic_app/modules/app/app_model.dart';
import 'package:clinic_app/modules/utils/file_uploader.dart';
import 'dart:io';
import 'package:clinic_app/modules/utils/extentions.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({
    Key key,
  }) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserInfoModel(),
      child: Consumer<UserInfoModel>(
        builder: (context, provider, child) => Scaffold(
          // appBar: AppBar(
          //   title: Text("Your Profile Info"),
          // ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Your Profile Info",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: GenericImagePicker(
                        redius: 70,
                        caption: "Pick Profile Photo",
                        defaultImage: "assets/images/avatar.png",
                        imgType: DefaultImageType.local,
                        onFileChanged: (file) {
                          if (file != null) {
                            provider.avatar = file.path;
                          }
                        },
                      ),
                    ),
                    GenericTextField(
                      controller: nameController,
                      maxLength: 30,
                      labelText: "Your Full Name",
                      icon: Icon(Icons.person),
                    ),

                    GenericTextField(
                      controller: bioController,
                      maxLength: 100,
                      helperText: "Write some words about yourself",
                      labelText: "Your Bio",
                      icon: Icon(Icons.person),
                    ),
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
                    GenderChooser(
                      selectedValue: provider.gender, // get val from store ..
                      onRadioChanged: (value) {
                        // set value in the store ..
                        provider.gender = value;
                      },
                    ),
                    Mutation(
                      options: MutationOptions(
                          documentNode: gql("updateInfo"),
                          onCompleted: (result) {
                            Toast.show(
                                "You Successfully Updated Your Info", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                            Provider.of<AppStateModel>(context, listen: false)
                                .completeInfo(
                                    nameController.text,
                                    result.data["update_user"]["returning"][0]
                                        ["avatar"] ) ;
                          }),
                      builder: (
                        RunMutation runMutation,
                        QueryResult result,
                      ) {
                        if (result.exception != null) {
                          Toast.show(
                              "Cann't Update Your Info , Please Try again .",
                              context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
                        }

                        return result.loading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: RaisedButton(
                                  child: Text(
                                    "Save Your Info",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    String id = Provider.of<AppStateModel>(
                                            context,
                                            listen: false)
                                        .userEntity
                                        .id;
                                    String compressedFile =
                                        await compressImage(provider.avatar);

                                    await FileUploader.uploadFile(
                                        "user/$id.png",
                                        File(compressedFile),
                                        compressedFile.getContentType());
                                    String media =
                                        "https://shaghaph.fra1.digitaloceanspaces.com/user/$id${compressedFile.split('/').last.split(".").last}";

                                    runMutation({
                                      "id": id,
                                      "avatar": media,
                                      "birth": provider.birthDate.toString(),
                                      "bio": bioController.text,
                                      "name": nameController.text,
                                      "gender":
                                          provider.gender == 0 ? true : false
                                    });
                                  },
                                  color: Colors.blue,
                                ),
                                margin: EdgeInsets.only(top: 20.0),
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
