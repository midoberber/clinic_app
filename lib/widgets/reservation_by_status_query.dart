import 'package:clinic_app/components/generic_message.dart';
import 'package:clinic_app/modules/app/app_model.dart';
import 'package:clinic_app/modules/graphql/reservations_queries.dart';
import 'package:clinic_app/widgets/patients_list.dart';
import 'package:clinic_app/widgets/session_status_filter.dart';
import 'package:clinic_app/widgets/sessions_list.dart';
import 'package:clinic_app/widgets/timing_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../components/circular_user_avatar.dart';
import 'session_index_filter.dart';

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
  String patientName = "All Patients";

  String sessionStatus;
  String sessionIndex;

  int selectedDateIndex = 0;

  String fromDate;
  String toDate;

  _showDialog() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => PatientSelector(
              selectedPatient: patientId,
              onSelectPatient: (id, name) {
                setState(() {
                  patientId = id;
                  patientName = name;
                });
                Navigator.pop(context);
              },
            ));
  }

  dynamic getCurrentFilterObj(bool isDoctor) {
    Map<String, dynamic> filter;

    if (selectedDateIndex == 0 || selectedDateIndex == 3) {
      filter = Map<String, dynamic>.from({
        "forDoctor": isDoctor,
        "sessionFilter": {
          "session_date": {"_eq": fromDate},
        },
        "filter": Map<String, dynamic>.from({
          // "reservation_status": {"_eq": widget.status},
          "reservation_sessions": Map<String, dynamic>.from({
            "session_status": {"_eq": sessionStatus},
            "session_date": {"_eq": fromDate}
          })
        })
      });
    } else {
      filter = Map<String, dynamic>.from({
        "forDoctor": isDoctor,
        "sessionFilter": {
          "_and": {
            "session_date": {"_eq": fromDate},
            "session_date": {"_eq": toDate}
          },
        },
        "filter": Map<String, dynamic>.from({
          "reservation_sessions": Map<String, dynamic>.from({
            "_and": {
              "session_date": {"_eq": fromDate},
              "session_date": {"_eq": toDate}
            },
          })
        })
      });
    }

    if (patientId != null) {
      filter["filter"]["patient_id"] =
          Map<String, dynamic>.from({"_eq": patientId});
    }

    if (sessionStatus != null) {
      if (sessionStatus == "pending" && widget.status == "archieve") {
        filter["filter"]["reservation_sessions"]["_and"] =
            Map<String, dynamic>.from({
          "session_status": {"_eq": sessionStatus},
          "session_date": {"_lte": fromDate},
        });
      } else {
        if (widget.status == "accepted") {
          sessionStatus = "pending";
        }
        filter["filter"]["reservation_sessions"]["session_status"] =
            Map<String, dynamic>.from({"_eq": sessionStatus});
      }
    }

    if (sessionIndex != null) {
      filter["filter"]["reservation_sessions"]["session_index"] =
          Map<String, dynamic>.from({"_eq": sessionIndex});
    }

    if (widget.status == "archieve") {
      filter["filter"]["_or"] = Map<String, dynamic>.from({
        "reservation_status": {"_eq": "declined"},
        "reservation_status": {"_eq": "archived"},
        "reservation_status": {"_eq": "accepted"}
      });
      // apply session status and _lte today ...
    } else {
      filter["filter"]["reservation_status"] =
          Map<String, dynamic>.from({"_eq": widget.status});
    }

    String doctorId = Provider.of<AppStateModel>(context).doctorId;
    filter["filter"]["doctor_id"] =
        Map<String, dynamic>.from({"_eq": doctorId});

    return filter;
  }

  @override
  Widget build(BuildContext context) {
    bool isDoctor = Provider.of<AppStateModel>(context).userEntity.isDoctor;

    var f = getCurrentFilterObj(isDoctor);
    return Column(
      children: <Widget>[
        if (isDoctor)
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) - 20,
                    child: TimingPicker(
                      selectedDateFilter: selectedDateIndex,
                      specificDateString: fromDate,
                      onSelectionChanged: (ss) async {
                        if (ss == 3) {
                          var dat = await showDatePicker(
                              initialDate: DateTime.now(),
                              firstDate:
                                  DateTime.now().subtract(Duration(days: 1)),
                              lastDate: DateTime.now().add(Duration(days: 400)),
                              context: context);
                          if (dat == null) {
                            return;
                          } else {
                            setState(() {
                              fromDate = "${dat.year}-${dat.month}-${dat.day}";
                              toDate = dat.toString();
                              selectedDateIndex = ss;
                              // specificDateStr =
                              //     "${dat.year}-${dat.month}-${dat.day}";
                            });
                            return;
                          }
                        }

                        if (ss == 1) {
                          // Next week
                          var frm = DateTime.now();
                          var tod = DateTime.now().add(Duration(days: 6));
                          setState(() {
                            selectedDateIndex = ss;
                            fromDate = "${frm.year}-${frm.month}-${frm.day}";
                            toDate = "${tod.year}-${tod.month}-${tod.day}";
                          });
                        }

                        if (ss == 2) {
                          // this month
                          var frm = DateTime.now();
                          setState(() {
                            selectedDateIndex = ss;
                            fromDate = "${frm.year}-${frm.month}-${frm.day}";
                            toDate = "${frm.year}-${frm.month}-31";
                          });
                        }
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
                    title: Text(patientName,
                        style: TextStyle(
                            color: Theme.of(context).buttonColor,
                            fontSize: 16.0)),
                  ),
                )
              ],
            ),
          ),
        if (isDoctor && widget.status == "archieve")
          Container(
            height: 30,
            child: SessionStatusFilter(
              selectedStatus: sessionStatus,
              onStatusChanges: (status) {
                setState(() {
                  sessionStatus = status;
                });
              },
            ),
          ),
        if (widget.status == "accepted")
          Container(
            height: 30,
            child: SessionIndexFilter(
              selectedIndex: sessionIndex,
              onIndexChanges: (status) {
                setState(() {
                  sessionIndex = status;
                });
              },
            ),
          ),
        Expanded(
          child: Query(
            options: QueryOptions(
                documentNode: gql(getReservations),
                pollInterval: 5,
                variables: f),
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
                  icon: Icons.hourglass_empty,
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
                          return isDoctor
                              ? ListTile(
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex =
                                          reservations.indexOf(item);
                                    });
                                  },
                                  leading: CircularUserAvatar(
                                    url: item["reservation_patient"]["avatar"],
                                  ),
                                  title: Text(item["reservation_patient"]
                                      ["display_name"]),
                                  subtitle: Text(
                                      "Reservation # ${reservations.indexOf(item) + 1}"),
                                )
                              : ListTile(
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex =
                                          reservations.indexOf(item);
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
