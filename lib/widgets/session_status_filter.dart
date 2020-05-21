import 'package:flutter/material.dart';

import 'generic_tag.dart';

class SessionStatusFilter extends StatelessWidget {
  final String selectedStatus;
  final Function onStatusChanges;

  const SessionStatusFilter(
      {Key key, this.selectedStatus, this.onStatusChanges})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        GenericTag(
          key: Key("all"),
          id: null,
          name: "All",
          isSelected: selectedStatus == null || selectedStatus == "all",
          onTap: onStatusChanges,
          icon: Icons.all_inclusive,
        ),
        GenericTag(
          key: Key("done"),
          id: "done",
          name: "Done",
          isSelected: selectedStatus == "done",
          onTap: onStatusChanges,
          icon: Icons.check,
        ),
        GenericTag(
          key: Key("canceled"),
          id: "canceled",
          name: "Canceled",
          isSelected: selectedStatus == "canceled",
          onTap: onStatusChanges,
          icon: Icons.cancel,
        ),
        GenericTag(
          key: Key("missed"),
          id: "pending",
          name: "Missed",
          isSelected: selectedStatus == "pending",
          onTap: onStatusChanges,
          icon: Icons.call_missed,
        )
      ],
    );
  }
}
