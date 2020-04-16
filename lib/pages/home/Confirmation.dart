import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Confirmation extends StatefulWidget {
  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  int _activeMeterIndex;
  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Divider(
            height: 10,
            color: Colors.black,
          ),
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, int) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "First Session",
                              style: TextStyle(
                                  color: primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.date_range,
                              color: secondary,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("22/3/2020",
                                style: TextStyle(
                                    color: primary,
                                    fontSize: 13,
                                    letterSpacing: .3)),
                            SizedBox(
                              width: 25,
                            ),
                            Icon(
                              Icons.timer,
                              color: secondary,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("6:30",
                                style: TextStyle(
                                    color: primary,
                                    fontSize: 13,
                                    letterSpacing: .3)),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: Text(
              "payment receipt",
              style: TextStyle(
                  color: primary, fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: new Color(0xFFFFFFFF),
              borderRadius: new BorderRadius.circular(8.0),
            ),
            width: double.maxFinite,
            height: 200,
            child: Image.asset("assets/images/avatar.png"),
          )
        ],
      ),
    );
  }
}
