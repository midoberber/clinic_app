import 'package:flutter/material.dart';

class GenericTag extends StatelessWidget {
  final bool isSelected;
  final dynamic id;
  final String name;
  final IconData icon;
  final Function onTap;
  const GenericTag(
      {Key key, this.id, this.name, this.icon, this.isSelected, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0),
      child: GestureDetector(
          onTap: () {
            if (isSelected) {
              onTap(null);
            } else {
              onTap(id);
            }
          },
          child: Chip(
            backgroundColor: isSelected ? Colors.blueGrey : Colors.grey[200],
            label: Row(
              children: <Widget>[
                Text(name,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.blueGrey))
              ],
            ),
            avatar: Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.grey[200] : Colors.blueGrey,
            ),
          )),
    );
  }
}
