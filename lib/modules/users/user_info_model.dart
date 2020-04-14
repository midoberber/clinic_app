import 'package:clinic_app/modules/app/app_model.dart';
import 'package:clinic_app/modules/graphql/user_queries.dart';
import 'package:flutter/cupertino.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class UserInfoModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  PageController controller = PageController(
    initialPage: 0,
  );

  int _currentPage = 0;
  int get currentPage =>
      _currentPage; // controller.hasClients ? controller.page.toInt() : 0;

  DateTime _birthDate;
  DateTime get birthDate => _birthDate;
  set birthDate(DateTime bDate) {
    _birthDate = bDate;
    notifyListeners();
  }

  int _weight = 80;
  int get weight => _weight;
  set weight(int wi) {
    _weight = wi;
    notifyListeners();
  }

  int _height = 150;
  int get height => _height;
  set height(int wi) {
    _height = wi;
    notifyListeners();
  }

  Gender _gender = Gender.Male;
  Gender get gender => _gender;
  set gender(Gender gend) {
    _gender = gend;
    notifyListeners();
  }

  String _avatar;
  String get avatar => _avatar;
  set avatar(String gend) {
    _avatar = gend;
    notifyListeners();
  }

  String _userId;
  bool _isNew;
  void init(BuildContext context, bool isNew) async {
    // INITIALIZE FORM WITH SOME DATA ..
    var userData =
        Provider.of<AppStateModel>(context, listen: false).userEntity;
    _userId = userData.id;
    _isNew = isNew;
    if (isNew) {
      if (userData != null) {
        _avatar = userData.photoUrl;
        nameController.text = userData.displayName;
        notifyListeners();
      }
      return;
    }

    GraphQLClient _client = GraphQLProvider.of(context)?.value;
    var res = await _client.query(
        QueryOptions(documentNode: gql(getMyData), variables: {"id": _userId}));
    print(res.exception.toString());
    if (res.exception == null) {
      var user = res.data["user_by_pk"];
      addressController.text = user["address"];
      nameController.text = user["display_name"];
      phoneController.text = user["phone"];
      titleController.text = user["jop"];
      _avatar = user["avatar"];
      _birthDate = DateTime.parse(user["birthDate"]);
      _weight = user["weight"];
      _height = user["height"];
      _gender = Gender.values[int.parse(user["gender"])];
      notifyListeners();
    }
  }

  void next(BuildContext context) async {
    if (controller.page == 2) {
      GraphQLClient _client = GraphQLProvider.of(context)?.value;
      var res = await _client
          .mutate(MutationOptions(documentNode: gql(updateUser), variables: {
        "user_id": _userId,
        "avatar": _avatar,
        "birthDate": _birthDate.toString(),
        "address": addressController.text,
        "display_name": nameController.text,
        "gender": _gender.toString(),
        "height": _height,
        "phone": phoneController.text,
        "jop": titleController.text,
        "weight": _weight,
        "isCompleted": true
      }));

      if (res.exception != null) {
        print(res.exception.toString());
        Toast.show("Something Wrong happned , please try again", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        return;
      }
      if (_isNew) {
        Provider.of<AppStateModel>(context, listen: false).completeInfo();
      } else {
              Toast.show("Your Data is Updated Successfully.", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.pop(context);
      }
    } else {
      if (controller.page == 0 && nameController.text.isEmpty) {
        Toast.show("You Must Fill Your name", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        return;
      }
      if (controller.page == 0 && birthDate == null) {
        Toast.show("You Must Fill Your Birth Date", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        return;
      }
      controller.nextPage(
          duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
      _currentPage++;
      notifyListeners();
    }
  }

  void previous() {
    if (controller.page != 0) {
      controller.previousPage(
          duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
      _currentPage--;
      notifyListeners();
    }
  }
}
