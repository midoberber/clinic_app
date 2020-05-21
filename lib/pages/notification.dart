import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Notification extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, int) => Card(
          child: new ListTile(
            leading: const Icon(
              Icons.notifications,
              color: Colors.deepOrange,
            ),
            title: Text("Title", style: TextStyle(fontSize: 18)),
            subtitle: Text("descrption ", style: TextStyle(fontSize: 12)),
          ),
        ),
      ),
    );
  }
}
