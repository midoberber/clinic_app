import 'package:clinic_app/components/generic_message.dart';
import 'package:clinic_app/widgets/session.dart';
import 'package:flutter/material.dart';

class SessionList extends StatelessWidget {
  final List sessions;
  final List<Widget> last;
  const SessionList({Key key, this.sessions, this.last}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (sessions.length == 0)
      return GenericMessage(
        title: "You Don't Have Sessions Here",
        message: "Tap to Refetch",
        icon: Icons.event_busy,
      );
    return Column(
      children: <Widget>[
        ...sessions
            .map((dynamic item) => Session(
                  session: item,
                ))
            .toList(),
        if (last != null) ...last
      ],
    );
  }
}
