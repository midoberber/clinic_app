import 'package:flutter/material.dart';

class ExpandedWidget extends StatefulWidget {
  final Widget header;
  final Widget body;
  final int itemCount;
  const ExpandedWidget({Key key, this.header, this.body, this.itemCount})
      : super(key: key);
  @override
  _ExpandedWidgetState createState() => _ExpandedWidgetState();
}

class _ExpandedWidgetState extends State<ExpandedWidget> {
  int _activeMeterIndex;

  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
        shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.itemCount,
          itemBuilder: (BuildContext context, int i) {
            return Card(
              margin: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
              child: new ExpansionPanelList(
                expansionCallback: (int index, bool status) {
                  setState(() {
                    _activeMeterIndex = _activeMeterIndex == i ? null : i;
                  });
                },
                children: [
                  new ExpansionPanel(
                      isExpanded: _activeMeterIndex == i,
                      headerBuilder: (BuildContext context, bool isExpanded) =>
                          widget.header,
                      body: widget.body),
                ],
              ),
            );
          }),
    );
  }
}
