import 'package:clinic_app/components/drawer.dart';
import 'package:clinic_app/pages/home/Confirmation.dart';
import 'package:clinic_app/pages/home/current_dates.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);

  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff696b9e),
        elevation: 0.0,
        title: Text("Welcome"),
        centerTitle: true,
      ),
      drawer: LightDrawerPage(),
      backgroundColor: Color(0xfff0f0f0),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 145),
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  TabBar(
                    controller: _controller,
                    tabs: [
                      new Tab(
                        // icon: const Icon(Icons.home),
                        text: 'Current dates',
                      ),
                      new Tab(
                        text: 'Confirmation',
                      ),
                      new Tab(
                        text: 'History',
                      ),
                    ],
                    labelColor: Theme.of(context).primaryColor,
                    indicatorColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.black,
                  ),
                  new Expanded(
                    // height: 120.0,
                    child: new TabBarView(
                      controller: _controller,
                      children: <Widget>[
                        CurrentDates(),
                        Confirmation(),
                        Scaffold(
                          body: Center(
                            child: Text("data"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _buildHeader(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      children: <Widget>[
        // SizedBox(width: 20.0),
        Container(
            // width: 80.0,
            // height: 80.0,
            child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                    radius: 35.0,
                    backgroundImage: AssetImage("assets/images/avatar.png")))),
        SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "DR/Mahmoud Shaker",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10.0),
            Text("Dietician and Obesity",
                style: TextStyle(color: Colors.white)),
            SizedBox(height: 5.0),
            Row(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.locationArrow,
                  size: 12.0,
                  color: Colors.white,
                ),
                SizedBox(width: 10.0),
                Text(
                  "Any Where",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
