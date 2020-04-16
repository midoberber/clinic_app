import 'package:clinic_app/components/generic_message.dart';
import 'package:clinic_app/widgets/session.dart';
import 'package:flutter/material.dart';

class SessionList extends StatelessWidget {
  final List sessions;
  final Widget last;
  const SessionList({Key key, this.sessions, this.last}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (sessions.length == 0)
      return GenericMessage(
        title: "You Don't Have Sessions Here",
        message: "Tap to Refetch",
        icon: Icons.event_busy,
      );
    return ListView.builder(
        itemCount: sessions.length + (last == null ? 0 : 1),
        itemBuilder: (BuildContext context, int index) {
          return ((last != null && index == sessions.length)
              ? last
              : GestureDetector(
                  child: Session(
                    session: sessions[index],
                  ),
                  onTap: () {
                    // switch state and navigate if and only if is opened or archieved...
                  },
                ));
        });
  }
}
