import 'package:clinic_app/modules/app/app_model.dart';
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

  int _weight = 50;
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

  void next(BuildContext context) async {
    if (controller.page == 2) {
 
       GraphQLClient _client = GraphQLProvider.of(context)?.value;
      var res = await _client
          .mutate(MutationOptions(documentNode: gql("query"), variables: {

            
          }));

      if (res.exception != null) {
        Toast.show("Something Wrong happned , please try again", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        return;
      }
      Provider.of<AppStateModel>(context , listen: false).completeInfo();
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
