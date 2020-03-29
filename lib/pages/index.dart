import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Container(
              color: Colors.yellow,
            ),
            Container(
              color: Colors.black,
            ),
            Container(
              color: Colors.green,
            ),
            Container(
              color: Colors.blue,
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
              title: Text('Hubs'),
              icon: Icon(Icons.apps),
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
