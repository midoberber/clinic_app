import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:clinic_app/components/Loading.dart';
import 'package:clinic_app/modules/app/app_model.dart';
import 'package:clinic_app/pages/chat/chat_view.dart';

import 'package:clinic_app/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppStateModel>(context, listen: false)
          .registerFireBaseMessaging(context);
    });
    if (isLoading == true) {
      return Loading();
    } else {
      return Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              Home(),
              ChatView(),
              Scaffold(
                body: Container(
                  color: Colors.green,
                ),
              ),
              Scaffold(
                body: Container(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              title: Text('Home'),
              icon: Icon(Icons.home),
              activeColor: Color(0xff0E3D51),
            ),
            BottomNavyBarItem(
                title: Text('Chats'),
                icon: Icon(Icons.chat),
                activeColor: Color(0xff0E3D51)),
            BottomNavyBarItem(
                title: Text('Job Offers'),
                icon: Icon(Icons.build),
                activeColor: Color(0xff0E3D51)),
            BottomNavyBarItem(
                title: Text('Notifications'),
                icon: Icon(Icons.notifications),
                activeColor: Color(0xff0E3D51)),
          ],
        ),
      );
    }
  }
}
