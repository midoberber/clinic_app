import 'package:flutter/material.dart';

import 'generic_tag.dart';

class SessionIndexFilter extends StatelessWidget {
  final String selectedIndex;
  final Function onIndexChanges;

  const SessionIndexFilter(
      {Key key, this.selectedIndex, this.onIndexChanges})
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
          isSelected: selectedIndex == null,
          onTap: onIndexChanges,
          icon: Icons.all_inclusive,
        ),
        GenericTag(
          key: Key("first"),
          id: "first",
          name: "First",
          isSelected: selectedIndex == "first",
          onTap: onIndexChanges,
          icon: Icons.filter_1,
        ),
        GenericTag(
          key: Key("second"),
          id: "second",
          name: "Second",
          isSelected: selectedIndex == "second",
          onTap: onIndexChanges,
          icon: Icons.filter_2,
        ),
        GenericTag(
          key: Key("third"),
          id: "third",
          name: "Third",
          isSelected: selectedIndex == "third",
          onTap: onIndexChanges,
          icon: Icons.filter_3,
        ),
         GenericTag(
          key: Key("fourth"),
          id: "fourth",
          name: "Fourth",
          isSelected: selectedIndex == "fourth",
          onTap: onIndexChanges,
          icon: Icons.filter_4,
        )
      ],
    );
  }
}