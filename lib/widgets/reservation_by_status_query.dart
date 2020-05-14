import 'package:clinic_app/components/generic_message.dart';
import 'package:clinic_app/modules/app/app_model.dart';
import 'package:clinic_app/modules/graphql/reservations_queries.dart';
import 'package:clinic_app/widgets/sessions_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../components/circular_user_avatar.dart';
import '../components/generic_text_box.dart';

/// Timing Dropdown  ..
class TimingPicker extends StatelessWidget {
  final int selectedDateFilter;
  final Function onSelectionChanged;
  final String specificDateString;
  const TimingPicker(
      {Key key,
      this.selectedDateFilter,
      this.onSelectionChanged,
      this.specificDateString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool isRTL = Localizations.localeOf(context).languageCode == "ar";

    List categories = [
      {"value": 0, "title": "Upcoming Today"},
      {"value": 1, "title": "This Week"},
      {"value": 2, "title": "This Month"},
      {
        "value": 3,
        "title":
            "Specific Day ${specificDateString == null ? "" : "($specificDateString)"}"
      }
    ];
    List<DropdownMenuItem<dynamic>> items =
        new List<DropdownMenuItem<dynamic>>();
    for (var category in categories) {
      items.add(DropdownMenuItem<dynamic>(
        value: category['value'],
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            category["title"],
            style: TextStyle(
                color: Theme.of(context).buttonColor,
                fontSize: (category['value'] == 3 && specificDateString != null)
                    ? 12.0
                    : 16.0),
          ),
        ),
      ));
    }

    return DropdownButtonFormField<dynamic>(
      icon: Icon(Icons.date_range),
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),

      hint: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
        child: Text(
          "Select a Date",
          style:
              TextStyle(color: Theme.of(context).buttonColor, fontSize: 16.0),
        ),
      ),
      value: selectedDateFilter,
      // isDense: false,
      onChanged: onSelectionChanged,
      items: items,
    );
  }
}

class PatientSelector extends StatefulWidget {
  final String selectedPatient;
  final Function onSelectPatient;
  PatientSelector({
    Key key,
    this.selectedPatient,
    this.onSelectPatient,
  }) : super(key: key);

  @override
  _PatientSelectorState createState() => new _PatientSelectorState();
}

class _PatientSelectorState extends State<PatientSelector> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  _getContent() {
    return Container(
        // height: 500,
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(FontAwesomeIcons.search),
              trailing: Icon(Icons.close),
              title: GenericTextField(
                helperText: "Search in your patient",
              ),
            ),
            Expanded(
                child: Query(
                    options: QueryOptions(
                        documentNode: gql(getPatientReservationByStatus),
                        pollInterval: 5,
                        variables: {
                          "patientId":
                              Provider.of<AppStateModel>(context, listen: false)
                                  .userEntity
                                  .id,
                          "reservateionStatus": widget.status
                        }),
                    builder: (result, {fetchMore, refetch}) {
                      if (result.loading && result.data == null)
                        return Scaffold(
                            body: Center(child: CircularProgressIndicator()));
                      if (result.exception != null) {
                        print(result.exception.toString());
                        return GenericMessage(
                          title: "Something Wrong Happened",
                          message: "Tap to Refetch",
                          icon: Icons.error,
                          onPressed: refetch,
                        );
                      }

                      List reservations = result.data["reservation"];
                      if (reservations.length == 0) {
                        return GenericMessage(
                          title: "You Don't Have any Resrvation here.",
                          message: "Tap to Refetch",
                          icon: Icons.error,
                          onPressed: refetch,
                        );
                      }

                      return Text("sd");
                    })),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }
}

class ReservationByStatusQuery extends StatefulWidget {
  final String status;
  const ReservationByStatusQuery({Key key, this.status = "pending"})
      : super(key: key);

  @override
  _ReservationByStatusQueryState createState() =>
      _ReservationByStatusQueryState();
}

class _ReservationByStatusQueryState extends State<ReservationByStatusQuery> {
  int _selectedIndex = 0;
  String patientId;

  int selectedDateIndex = 0;
  String fromDate;
  String toDate;
  String specificDateStr;

  _showDialog() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Please select'),
          actions: <Widget>[
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop('Cancel');
              },
              child: Text('Cancel'),
            ),
            // new CupertinoDialogAction(
            //   isDestructiveAction: true,
            //   onPressed: (){Navigator.of(context).pop('Accept');},
            //   child: new Text('Accept'),
            // ),
          ],
          content: SingleChildScrollView(
            child: Material(
              child: PatientSelector(),
            ),
          ),
        );
      },
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDoctor = Provider.of<AppStateModel>(context).userEntity.isDoctor;
    return Column(
      children: <Widget>[
        if (isDoctor)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) - 20,
                    child: TimingPicker(
                      selectedDateFilter: selectedDateIndex,
                      specificDateString: specificDateStr,
                      onSelectionChanged: (ss) async {
                        if (ss == 3) {
                          // show datepicker dialog ..
                          var dat = await showDatePicker(
                              // builder: (_, d) => Text("Date"),
                              initialDate: DateTime.now(),
                              firstDate:
                                  DateTime.now().subtract(Duration(days: 1)),
                              lastDate: DateTime.now().add(Duration(days: 400)),
                              context: context);
                          if (dat == null) {
                            return;
                          } else {
                            setState(() {
                              fromDate = dat.toString();
                              toDate = dat.toString();
                              selectedDateIndex = ss;
                              specificDateStr =
                                  "${dat.day}/${dat.month}/${dat.year}";
                            });
                            return;
                          }
                        }
                        setState(() {
                          selectedDateIndex = ss;
                          specificDateStr = null;
                        });
                      },
                    )),
                SizedBox(
                  child: Container(
                    color: Colors.black,
                  ),
                  width: 20,
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 2) - 20,
                  child: ListTile(
                    onTap: _showDialog,
                    trailing: Icon(Icons.person),
                    title: Text("All Patients",
                        style: TextStyle(
                            color: Theme.of(context).buttonColor,
                            fontSize: 16.0)),
                  ),
                )
              ],
            ),
          ),
        Expanded(
          child: Query(
            options: QueryOptions(
                documentNode: gql(getPatientReservationByStatus),
                pollInterval: 5,
                variables: {
                  "patientId":
                      Provider.of<AppStateModel>(context, listen: false)
                          .userEntity
                          .id,
                  "reservateionStatus": widget.status
                }),
            builder: (result, {fetchMore, refetch}) {
              if (result.loading && result.data == null)
                return Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              if (result.exception != null) {
                print(result.exception.toString());
                return GenericMessage(
                  title: "Something Wrong Happened",
                  message: "Tap to Refetch",
                  icon: Icons.error,
                  onPressed: refetch,
                );
              }

              List reservations = result.data["reservation"];
              if (reservations.length == 0) {
                return GenericMessage(
                  title: "You Don't Have any Resrvation here.",
                  message: "Tap to Refetch",
                  icon: Icons.error,
                  onPressed: refetch,
                );
              }
              Locale currentLocale = Localizations.localeOf(context);
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    children: reservations.map<ExpansionPanel>((dynamic item) {
                      return ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          var since = timeago.format(
                              DateTime.parse(item["created_at"]),
                              locale: currentLocale.languageCode == "en"
                                  ? 'en'
                                  : 'ar');
                          return ListTile(
                            onTap: () {
                              setState(() {
                                _selectedIndex = reservations.indexOf(item);
                              });
                            },
                            leading: Icon(FontAwesomeIcons.ticketAlt),
                            title: Text(
                                "Reservation # ${reservations.indexOf(item) + 1}"),
                            subtitle: Text("Submited since $since"),
                          );
                        },
                        body: SessionList(
                          sessions: item["reservation_sessions"],
                          showStatus: widget.status != "pending" &&
                              widget.status != "declined",
                          last: widget.status == "pending"
                              ? [
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      child:
                                          Image.network(item["payment_image"])),

                                  // in case you are the doctor ...
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Expanded(
                                          child: RaisedButton(
                                            color: Colors.red,
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              // cancel this reservation ...
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Expanded(
                                          child: RaisedButton(
                                            color: Colors.blueAccent,
                                            child: Text(
                                              "Accept",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              // cancel this reservation ...
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ]
                              : null,
                        ),
                        isExpanded:
                            (reservations.indexOf(item) == _selectedIndex),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
