import 'package:clinic_app/components/drawer.dart';
import 'package:clinic_app/pages/chat/chat_view.dart';
import 'package:clinic_app/pages/home/Confirmation.dart';
import 'package:clinic_app/pages/home/current_dates.dart';
import 'package:clinic_app/pages/home/history.dart';
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
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => ChatView()));
            },
            icon: Icon(Icons.chat),
          ),
        ],
      ),
      drawer: LightDrawerPage(),
      backgroundColor: Color(0xfff0f0f0),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 60),
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
                        text: 'Ongoing',
                      ),
                      new Tab(
                        text: 'Pending',
                      ),
                      new Tab(
                        text: 'Archiev',
                      ),
                    ],
                    labelColor: Theme.of(context).primaryColor,
                    indicatorColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.black,
                  ),
                  Expanded(
                    // height: 120.0,
                    child: TabBarView(
                      controller: _controller,
                      children: <Widget>[
                        CurrentDates(),
                        Confirmation(),
                        History()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 85,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildHeader(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/avatar.png"),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(width: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Dr / Mahmoud Shaker",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 5.0),
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
        ),
      ],
    );
  }
}
