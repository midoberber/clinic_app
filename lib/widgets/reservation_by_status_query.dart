import 'package:clinic_app/components/generic_message.dart';
import 'package:clinic_app/modules/app/app_model.dart';
import 'package:clinic_app/modules/graphql/reservations_queries.dart';
import 'package:clinic_app/widgets/sessions_list.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class ReservationByStatusQuery extends StatefulWidget {
  final String status;
  final bool isForDoctor;

  const ReservationByStatusQuery(
      {Key key, this.status = "pending", this.isForDoctor = false})
      : super(key: key);

  @override
  _ReservationByStatusQueryState createState() =>
      _ReservationByStatusQueryState();
}

class _ReservationByStatusQueryState extends State<ReservationByStatusQuery> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          documentNode: gql(getPatientReservationByStatus),
          pollInterval: 10,
          variables: {
            "patientId": Provider.of<AppStateModel>(context, listen: false)
                .userEntity
                .id,
            "reservateionStatus": widget.status
          }),
      builder: (result, {fetchMore, refetch}) {
        if (result.loading)
          return Scaffold(body: Center(child: CircularProgressIndicator()));
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
        print("$reservations");
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(4),
            child: ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                if (isExpanded) {
                  setState(() {
                    _selectedIndex = -1;
                  });
                } else {
                  setState(() {
                    _selectedIndex = index;
                  });
                }
              },
              children: reservations.map<ExpansionPanel>((dynamic item) {
                return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(item["created_at"]),
                    );
                  },
                  body: SessionList(
                    sessions: item["reservation_sessions"],
                    last: widget.status == "pending"
                        ? [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: Image.network(item["payment_image"])),

                            // in case you are the doctor ...
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RaisedButton(
                                    color: Colors.red,
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      // cancel this reservation ...
                                    },
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  RaisedButton(
                                    color: Colors.blueAccent,
                                    child: Text(
                                      "Accept",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      // cancel this reservation ...
                                    },
                                  )
                                ],
                              ),
                            )
                          ]
                        : null,
                  ),
                  isExpanded: (reservations.indexOf(item) == _selectedIndex),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
