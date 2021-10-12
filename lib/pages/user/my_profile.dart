import 'package:clinic_app/components/Header.dart';
import 'package:clinic_app/components/drawer.dart';
import 'package:clinic_app/components/flat_appbar.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  Container _buildHeader(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      SizedBox(
        height: 10,
      ),
      Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            // margin: EdgeInsets.only(top: 16.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 96.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Name",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Text("Product Designer"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35.0),
                image: DecorationImage(
                    image: AssetImage("assets/images/avatar.png"),
                    fit: BoxFit.cover)),
            margin: EdgeInsets.only(left: 16.0),
          ),
        ],
      )
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text('My Profile',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
      body: Column(
        children: <Widget>[
          _buildHeader(context),
          new Container(
            // decoration:
            //     new BoxDecoration(color: Colors.white),
            child: new TabBar(
              controller: _controller,
              tabs: [
                new Tab(
                  // icon: const Icon(Icons.home),
                  text: 'Information',
                ),
                new Tab(
                  text: 'Statistics',
                ),
                new Tab(
                  text: 'progress',
                ),
              ],
              labelColor: Theme.of(context).primaryColor,
              indicatorColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.black,
            ),
          ),
          new Expanded(
            // height: 120.0,
            child: new TabBarView(
              controller: _controller,
              children: <Widget>[_information(), _statics(), _progress()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _information() {
    return Column(
      children: <Widget>[
        new Card(
          child: new ListTile(
            leading: const Icon(
              FontAwesomeIcons.weight,
              color: Colors.deepOrange,
            ),
            title: Text("70 Kg", style: TextStyle(fontSize: 18)),
            subtitle: Text("Body Weight Now", style: TextStyle(fontSize: 12)),
          ),
        ),
        Card(
          child: new ListTile(
            leading: const Icon(
              FontAwesomeIcons.ruler,
              color: Colors.deepOrange,
            ),
            title: Text("220 Cm", style: TextStyle(fontSize: 18)),
            subtitle: Text("Body Height ", style: TextStyle(fontSize: 12)),
          ),
        ),
        Card(
          child: new ListTile(
            leading: const Icon(
              FontAwesomeIcons.male,
              color: Colors.deepOrange,
            ),
            title: Text("23 Year", style: TextStyle(fontSize: 18)),
            subtitle: Text("Age", style: TextStyle(fontSize: 12)),
          ),
        ),
      ],
    );
  }

  Widget _progress() {
    return ListView(
      children: <Widget>[
        Text(
          'Achivments',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.grey,
          ),
        ),
        // Container(
        //   margin: EdgeInsets.only(bottom: 40.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: <Widget>[
        //       CircleBadge(
        //         color: Color.fromRGBO(190, 130, 255, 1.0),
        //         title: '1st',
        //         subtitle: 'Workout',
        //       ),
        //       CircleBadge(
        //         color: Color.fromRGBO(75, 142, 255, 1.0),
        //         title: '1000',
        //         subtitle: 'kCal',
        //       ),
        //       CircleBadge(
        //         color: Color.fromRGBO(255, 255, 255, 1.0),
        //         title: '6000',
        //         subtitle: 'kCal',
        //       ),
        //     ],
        //   ),
        // ),
        Text(
          'You\'ve burned',
          style: TextStyle(
            color: Colors.grey[400],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '480 kCal',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey[500],
                ),
              ),
              Text(
                '6000 kCal',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        // Container(
        //   child: RoundedProgressBar(
        //     height: 25.0,
        //     style: RoundedProgressBarStyle(
        //       borderWidth: 0,
        //       widthShadow: 0,
        //     ),
        //     margin: EdgeInsets.only(
        //       top: 10.0,
        //       bottom: 16.0,
        //     ),
        //     borderRadius: BorderRadius.circular(24),
        //     percent: 28.0,
        //   ),
        // ),
      ],
    );
  }

  Widget _statics() {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Weight Progress',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.grey,
          ),
        ),
        // Container(
        //   height: 180.0,
        //   width: MediaQuery.of(context).size.width - 40.0,
        //   margin: EdgeInsets.only(bottom: 30.0),
        //   child: BezierChart(
        //     bezierChartScale: BezierChartScale.CUSTOM,
        //     xAxisCustomValues: const [0, 3, 6, 9],
        //     series: const [
        //       BezierLine(
        //         lineColor: Color.fromRGBO(241, 227, 255, 1.0),
        //         lineStrokeWidth: 8.0,
        //         data: const [
        //           DataPoint<double>(value: 45, xAxis: 0),
        //           DataPoint<double>(value: 80, xAxis: 3),
        //           DataPoint<double>(value: 55, xAxis: 6),
        //           DataPoint<double>(value: 100, xAxis: 9)
        //         ],
        //       ),
        //     ],
        //     config: BezierChartConfig(
        //       xAxisTextStyle: TextStyle(color: Colors.blueGrey),
        //       startYAxisFromNonZeroValue: true,
        //       backgroundColor: Colors.white,
        //     ),
        //   ),
        // ),
        Container(
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.60 - 5.0,
                height: 100.0,
                margin: EdgeInsets.only(right: 15.0),
                padding: EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(231, 241, 255, 1.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 45.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Weight',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.blueGrey[200],
                            ),
                          ),
                          Text(
                            '56 Kg',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Gaind',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.blueGrey[200],
                            ),
                          ),
                          Text(
                            '13 Kg',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.30 - 10.0,
                height: 100.0,
                padding: EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(241, 227, 255, 1.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Goal',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blueGrey[200],
                      ),
                    ),
                    Text(
                      'Add +',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color.fromRGBO(190, 129, 255, 1.0),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 45.0,
            horizontal: 30.0,
          ),
          child: Text(
            'Track your weight every morning before your breakfast',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.blueGrey,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(25.0),
          width: MediaQuery.of(context).size.width - 40.0,
          margin: EdgeInsets.only(bottom: 30.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(241, 227, 255, 1.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Text(
            'Enter today\'s weight',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(190, 130, 255, 1.0),
              fontSize: 20.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}
