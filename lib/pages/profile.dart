import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileOnePage extends StatefulWidget {
  @override
  _ProfileOnePageState createState() => _ProfileOnePageState();
}

class _ProfileOnePageState extends State<ProfileOnePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
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
                    image: AssetImage("assets/images/users.png"),
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
      appBar: AppBar(
        title: Text("My Profile"),
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
                )
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
              children: <Widget>[
                _information(),
                _statics(),
              ],
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
        Container(
          height: 180.0,
          width: MediaQuery.of(context).size.width - 40.0,
          margin: EdgeInsets.only(bottom: 30.0),
          child: BezierChart(
            bezierChartScale: BezierChartScale.CUSTOM,
            xAxisCustomValues: const [0, 3, 6, 9],
            series: const [
              BezierLine(
                lineColor: Color.fromRGBO(241, 227, 255, 1.0),
                lineStrokeWidth: 8.0,
                data: const [
                  DataPoint<double>(value: 45, xAxis: 0),
                  DataPoint<double>(value: 80, xAxis: 3),
                  DataPoint<double>(value: 55, xAxis: 6),
                  DataPoint<double>(value: 100, xAxis: 9)
                ],
              ),
            ],
            config: BezierChartConfig(
              xAxisTextStyle: TextStyle(color: Colors.blueGrey),
              startYAxisFromNonZeroValue: true,
              backgroundColor: Colors.white,
            ),
          ),
        ),
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
                      '50 Kg',
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
        // Container(
        //   padding: EdgeInsets.all(25.0),
        //   width: MediaQuery.of(context).size.width - 40.0,
        //   margin: EdgeInsets.only(bottom: 30.0),
        //   decoration: BoxDecoration(
        //     color: Color.fromRGBO(241, 227, 255, 1.0),
        //     borderRadius: BorderRadius.circular(15.0),
        //   ),
        //   child: Text(
        //     'Enter today\'s weight',
        //     textAlign: TextAlign.center,
        //     style: TextStyle(
        //       color: Color.fromRGBO(190, 130, 255, 1.0),
        //       fontSize: 20.0,
        //       fontWeight: FontWeight.w900,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
