import 'package:clinic_app/components/generic_message.dart';
import 'package:clinic_app/modules/app/app_model.dart';
import 'package:clinic_app/modules/graphql/reservations_queries.dart';
import 'package:clinic_app/widgets/sessions_list.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class ReservationByStatusQuery extends StatelessWidget {
  final String status;

  const ReservationByStatusQuery({Key key, this.status = "pending"})
      : super(key: key);
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
            "reservateionStatus": status
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
        var reservation = reservations[0];
        print("$reservation");

        return ListView.builder(
            itemCount: reservations.length, itemBuilder: (_, index) {
              

              // return 
            });

        return SessionList(
          sessions: reservation["reservation_sessions"],
          last: status == "pending"
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Image.network(reservation["payment_image"]))
              : null,
        );
      },
    );
  }
}
