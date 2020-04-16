import 'package:clinic_app/components/generic_message.dart';
import 'package:clinic_app/widgets/session.dart';
import 'package:flutter/material.dart';

class SessionList extends StatelessWidget {
  final List sessions;

  const SessionList({Key key, this.sessions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (sessions.length == 0)
      return GenericMessage(
        title: "",
        message: "",
        icon: Icons.event_busy,
      );
    return ListView.builder(
        itemCount: sessions.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Session(
              session: sessions[index],
            ),
            onTap: () {
              // switch state and navigate if and only if is opened or archieved...
            },
          );
        });
  }
}
