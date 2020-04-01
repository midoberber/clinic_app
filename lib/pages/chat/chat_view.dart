import 'package:clinic_app/components/drawer.dart';
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
      drawer: LightDrawerPage(),
      appBar: AppBar(
        backgroundColor: Color(0xFF363846),
        elevation: 0.0,
        title:  Text(
            'Chats',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        
      ),
      backgroundColor: Color(0xFF363846),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: Color(0xFF565973), width: 1.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 6.0, 16.0, 6.0),
                            child: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/avatar.png"),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "Ahmed",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(width: 6.0),
                                    Text(
                                      "1hr",
                                      style: TextStyle(
                                        color: Colors.white30,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  "Hello",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
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
                              SizedBox(width: 10.0),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => ChatTwoPage()));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
