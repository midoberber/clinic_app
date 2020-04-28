import 'package:clinic_app/components/circular_user_avatar.dart';
import 'package:clinic_app/components/drawer.dart';
import 'package:clinic_app/modules/app/app_model.dart';
import 'package:clinic_app/pages/home/new_appointment.dart';
import 'package:clinic_app/widgets/reservation_by_status_query.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);
  final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>(); // ADD THIS LINE

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: LightDrawerPage(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => NewAppointment()));
        },
      ),
      body: NestedScrollView(
          // controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text("Dr / AHMED SHAKER",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text("For Dietician and Obesity",
                      style: TextStyle(color: Colors.white)),
                ),
                pinned: true,
                centerTitle: false,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                leading: GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer(); // CHANGE THIS LINE
                  },
                  child: CircularUserAvatar(
                    url:
                        Provider.of<AppStateModel>(context).userEntity.photoUrl,
                    margin: 6,
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: IconButton(
                      icon: Icon(FontAwesomeIcons.bell),
                      onPressed: () {},
                    ),
                  )
                ],
                bottom: TabBar(
                  tabs: <Tab>[
                    Tab(text: "Ongoing"),
                    Tab(text: "Pending"),
                    Tab(text: "Archieve"),
                  ],
                  controller: _controller,
                ),
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              ReservationByStatusQuery(
                status: "accepted",
              ),
              ReservationByStatusQuery(),
              ReservationByStatusQuery(),
            ],
            controller: _controller,
          )),
    );
  }
}
