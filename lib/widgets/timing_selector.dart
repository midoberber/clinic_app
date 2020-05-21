import 'package:flutter/material.dart';

class TimingPicker extends StatelessWidget {
  final int selectedDateFilter;
  final Function onSelectionChanged;
  final String specificDateString;
  const TimingPicker(
      {Key key,
      this.selectedDateFilter,
      this.onSelectionChanged,
      this.specificDateString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool isRTL = Localizations.localeOf(context).languageCode == "ar";

    List categories = [
      {"value": 0, "title": "Today"},
      {"value": 1, "title": "This Week"},
      {"value": 2, "title": "This Month"},
      {
        "value": 3,
        "title":
            "Specific Day ${specificDateString == null ? "" : "($specificDateString)"}"
      }
    ];
    
    List<DropdownMenuItem<dynamic>> items =
        new List<DropdownMenuItem<dynamic>>();
    for (var category in categories) {
      items.add(DropdownMenuItem<dynamic>(
        value: category['value'],
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            category["title"],
            style: TextStyle(
                color: Theme.of(context).buttonColor,
                fontSize: (category['value'] == 3 && specificDateString != null)
                    ? 12.0
                    : 16.0),
          ),
        ),
      ));
    }

    return DropdownButtonFormField<dynamic>(
      icon: Icon(Icons.date_range),
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent))),

      hint: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1),
        child: Text(
          "Select a Date",
          style:
              TextStyle(color: Theme.of(context).buttonColor, fontSize: 16.0),
        ),
      ),
      value: selectedDateFilter,
      // isDense: false,
      onChanged: onSelectionChanged,
      items: items,
    );
  }
}

