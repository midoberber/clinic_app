import 'package:clinic_app/components/expanded_widget.dart';
import 'package:flutter/material.dart';

class ConfirmationDoctor extends StatefulWidget {
  @override
  ConfirmationDoctorState createState() => ConfirmationDoctorState();
}

class ConfirmationDoctorState extends State<ConfirmationDoctor> {
  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);
  @override
  Widget build(BuildContext context) {
    return ExpandedWidget(
        itemCount: 3,
        header: ListTile(
          title: Text(
            "Khairy Mohamed",
            style: TextStyle(fontSize: 17),
          ),
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/images/avatar.png"),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.close,
                    color: secondary,
                    size: 25,
                  ),
                  Text("Close",
                      style: TextStyle(
                          color: secondary, fontSize: 13, letterSpacing: .3)),
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.done,
                    color: primary,
                    size: 25,
                  ),
                  Text("Done",
                      style: TextStyle(
                          color: primary, fontSize: 13, letterSpacing: .3)),
                ],
              ),
            ],
          ),
        ),
        body: Column(
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
                              SizedBox(
                                width: 30,
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
                                width: 10,
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
                            height: 8,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 15,
                              ),
                              Text("Time session ",
                                  style: TextStyle(
                                      color: primary,
                                      fontSize: 17,
                                      letterSpacing: .3)),
                              SizedBox(
                                width: 20,
                              ),
                              Text("< 15 >",
                                  style: TextStyle(
                                      color: secondary,
                                      fontSize: 15,
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
        ));
  }
}
