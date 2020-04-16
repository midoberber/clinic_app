import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';

class NewAppointmentModel extends ChangeNotifier {
  void init(BuildContext context) async {
    // GraphQLClient _client =
    GraphQLClient _client = GraphQLProvider.of(context)?.value;
    var result = await _client.query(QueryOptions(documentNode: gql("""
    
    """)));

    var data = result.data[""];

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
 
}
