import 'package:clinic_app/components/drawer.dart';
import 'package:clinic_app/pages/chat/chat_Page.dart';
import 'package:clinic_app/pages/chat/chating.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF363846),
        elevation: 0.0,
        title: Text(
          'Chats',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Color(0xFF363846),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFF565973), width: 1.0),
                  ),
                ),
                child: ListTile(
                  leading: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                          image: AssetImage("assets/images/avatar.png"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  title: Row(
                    children: <Widget>[
                      Text(
                        "Ahmed",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "1 hr",
                        style: TextStyle(
                          color: Colors.white30,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    "Hello",
                    style: TextStyle(
                      color: Colors.white30,
                    ),
                  ),
                  trailing: Container(
                    width: 42.0,
                    height: 42.0,
                    decoration: BoxDecoration(
                      color: Color(0xFF414350),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: IconButton(
                      color: Color(0xFF5791FB),
                      icon: Icon(Icons.call),
                      onPressed: () {},
                    ),
                  ),
                )),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ChatPage())),
          );
        },
      ),
    );
  }
}
