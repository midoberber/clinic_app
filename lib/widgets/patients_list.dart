import 'package:clinic_app/modules/graphql/patients_queries.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import '../components/generic_message.dart';
import '../components/generic_text_box.dart';
import '../modules/app/app_model.dart';

class PatientSelector extends StatelessWidget {
  final String selectedPatient;
  final Function onSelectPatient;

  final TextEditingController controller = TextEditingController();

  PatientSelector({Key key, this.selectedPatient, this.onSelectPatient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(FontAwesomeIcons.search),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                controller.clear();
              },
            ),
            title: GenericTextField(
              controller: controller,
              hintText: "Search in your patient",
            ),
          ),
          Expanded(
            child: Query(
              options: QueryOptions(
                  documentNode: gql(getDoctorPatientv),
                  pollInterval: 50,
                  variables: {
                    "doctor_id":
                        Provider.of<AppStateModel>(context, listen: false)
                            .userEntity
                            .id,
                  }),
              builder: (result, {fetchMore, refetch}) {
                if (result.loading && result.data == null)
                  return Center(child: CircularProgressIndicator());
                if (result.exception != null) {
                  print(result.exception.toString());
                  return GenericMessage(
                    title: "Something Wrong Happened",
                    message: "Tap to Refetch",
                    icon: Icons.error,
                    onPressed: refetch,
                  );
                }

                List patients = result.data["user"];
                if (patients.length == 0) {
                  return GenericMessage(
                    title: "You Don't Have any Patients yet.",
                    message: "Tap to Refetch",
                    icon: Icons.people_outline,
                    onPressed: refetch,
                  );
                }
                return Column(
                  children: <Widget>[
                    RadioListTile<String>(
                      title: const Text('All Patient'),
                      value: 'all',
                      groupValue: selectedPatient,
                      onChanged: (id) {
                        onSelectPatient(id, "All Patients");
                      },
                    ),
                    ...patients.map((patient) {
                      return RadioListTile<String>(
                        title: Text(patient["display_name"] ?? "Patient X"),
                        value: patient["id"],
                        groupValue: selectedPatient,
                        onChanged: (id) {
                          onSelectPatient(
                              id, patient["display_name"] ?? "Patient X");
                        },
                      );
                    }).toList()
                  ],
                );
                // ?Text("sd");
              },
            ),
          ),
        ],
      ),
    );
  }
}
