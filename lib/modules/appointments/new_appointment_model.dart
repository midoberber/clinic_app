import 'dart:io';

import 'package:clinic_app/modules/app/app_model.dart';
import 'package:clinic_app/modules/graphql/reservations_queries.dart';
import 'package:clinic_app/modules/utils/datetimeHelpers.dart';
import 'package:clinic_app/modules/utils/file_uploader.dart';
import 'package:clinic_app/modules/utils/sys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:clinic_app/modules/utils/extentions.dart';

class NewAppointmentModel extends ChangeNotifier {
  void init(BuildContext context) async {
    // GraphQLClient _client =
    // GraphQLClient _client = GraphQLProvider.of(context)?.value;
    // var result = await _client.query(QueryOptions(documentNode: gql("""
    // """)));
    // var data = result.data[""];
    // _minFrom
  }

  String _invoice;
  String get invoice => _invoice;
  set invoice(String gend) {
    _invoice = gend;
    notifyListeners();
  }

  DateTime _startDate;
  DateTime get startDate => _startDate;
  set startDate(DateTime bDate) {
    _startDate = bDate;
    notifyListeners();
  }

  TimeOfDay _startTime;
  TimeOfDay get startTime => _startTime;
  set startTime(TimeOfDay bDate) {
    _startTime = bDate;
    notifyListeners();
  }

  TimeOfDay _secondSessionTime;
  TimeOfDay get secondSessionTime => _secondSessionTime;
  set secondSessionTime(TimeOfDay bDate) {
    _secondSessionTime = bDate;
    notifyListeners();
  }

  TimeOfDay _thirdSessionTime;
  TimeOfDay get thirdSessionTime => _thirdSessionTime;
  set thirdSessionTime(TimeOfDay bDate) {
    _thirdSessionTime = bDate;
    notifyListeners();
  }

  TimeOfDay _fourthSessionTime;
  TimeOfDay get fourthSessionTime => _fourthSessionTime;
  set fourthSessionTime(TimeOfDay bDate) {
    _fourthSessionTime = bDate;
    notifyListeners();
  }

  Future getImage() async {
    var img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      _invoice = img.path;
      notifyListeners();
    }
  }

  TimeOfDay _minFrom;
  TimeOfDay _minTo;

  Future<Null> selectDate(BuildContext context) async {
    var dd = await showDatePicker(
        // builder: (_, d) => Text("Date"),
        initialDate: DateTime.now().add(Duration(days: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 30)),
        context: context);
    if (dd != null) {
      _startDate = dd;
      notifyListeners();
    }
  }

  Future<Null> selectTime(BuildContext context) async {
    TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 12, minute: 0),
    );
    // set all session times .. .
    if (selectedTime != null) {
      _startTime = selectedTime;
      _secondSessionTime = selectedTime;
      _thirdSessionTime = selectedTime;
      _fourthSessionTime = selectedTime;
      notifyListeners();
    }
  }

  

  void save(BuildContext context) async {
    if (_invoice == null) {
      Toast.show("Please Add Reservation Payment Invoice .", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    String compressedFile = await compressImage(_invoice);
    String upFile = "";
    if (compressedFile != null) {
      await FileUploader.uploadFile(
          "invoices/${compressedFile.split('/').last}",
          File(compressedFile),
          compressedFile.getContentType());
      upFile =
          "https://clinic.fra1.digitaloceanspaces.com/invoices/${compressedFile.split('/').last}";
 
      await File(compressedFile).delete();
    } else {
      Toast.show("Some Media Cann't be Processed .", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }

    GraphQLClient _client = GraphQLProvider.of(context)?.value;

    var appModel =Provider.of<AppStateModel>(context,listen: false);
    var res = await _client.mutate(
        MutationOptions(documentNode: gql(createReservation), variables: {
      "patient_id": appModel.userEntity.id,
      "payment_image": upFile,
      "doctor_id": appModel.doctorId,
      "reservation_sessions": {
        "data": [
          {
            "session_index": "first",
            "session_date": _startDate.toString(),
            "session_time": getTimeFormated(context , _startTime)
          },
          {
            "session_index": "second",
            "session_date": _startDate.add(Duration(days: 7)).toString(),
            "session_time": getTimeFormated(context , _startTime)
          },
          {
            "session_index": "third",
            "session_date": _startDate.add(Duration(days: 14)).toString(),
            "session_time": getTimeFormated(context , _startTime)
          },
          {
            "session_index": "fourth",
            "session_date": _startDate.add(Duration(days: 21)).toString(),
            "session_time": getTimeFormated(context , _startTime)
          },
        ],
      }
    }));

    if (res.exception != null) {
      print(res.exception.toString());
      Toast.show("Something Wrong happned , please try again", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }

    Toast.show("Your Reservation is Submited Successfully.", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    Navigator.pop(context);
  }
}
