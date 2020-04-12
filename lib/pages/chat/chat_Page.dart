import 'dart:async';
import 'dart:io';

import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  final ChatUser user = ChatUser(
    name: "Fayed",
    uid: "12346789",
    avatar: "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
  );

  final ChatUser otherUser = ChatUser(
    name: "Mrfatty",
    uid: "25649654",
  );
  List<ChatMessage> messages = [
    ChatMessage(
      text: "Hello",
      user: ChatUser(
        name: "Fayeed",
        uid: "123456789",
      ),
    ),
    ChatMessage(
      text: "Hello",
      user: ChatUser(
        name: "Fayed",
        uid: "12346789",
      ),
    ),
    ChatMessage(
      text: "How are You",
      user: ChatUser(
        name: "Fayeed",
        uid: "123456789",
      ),
    ),
  ];
  var m = List<ChatMessage>();

  var i = 0;

  @override
  void initState() {
    super.initState();
  }

  void systemMessage() {
    Timer(Duration(milliseconds: 300), () {
      if (i < 6) {
        setState(() {
          messages = [...messages, m[i]];
        });
        i++;
      }
      Timer(Duration(milliseconds: 300), () {
        _chatViewKey.currentState.scrollController
          ..animateTo(
            _chatViewKey.currentState.scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF363846),
        title: Text("Name"),
        centerTitle: true,
        elevation: 0.0,
      ),
      backgroundColor: Color(0xFF363846),
      body: DashChat(
        key: _chatViewKey,
        inputDecoration:
            InputDecoration.collapsed(hintText: "Add message here something.."),
        dateFormat: DateFormat('yyyy-MMM-dd'),
        timeFormat: DateFormat('HH:mm'),
        messages: messages,
        user: ChatUser(
          name: "Fayeed",
          uid: "123456789",
        ),
        showUserAvatar: false,
        showAvatarForEveryMessage: false,
        scrollToBottom: false,
        inputMaxLines: 5,
        messageContainerPadding: EdgeInsets.only(left: 5.0, right: 5.0),
        alwaysShowSend: true,
        inputTextStyle: TextStyle(fontSize: 16.0),
        inputContainerStyle: BoxDecoration(
          border: Border.all(width: 0.0),
          color: Colors.white,
        ),
        onQuickReply: (Reply reply) {
          setState(() {
            messages.add(ChatMessage(
                text: reply.value, createdAt: DateTime.now(), user: user));

            // messages = [...messages];
          });
          Timer(Duration(milliseconds: 300), () {
            _chatViewKey.currentState.scrollController
              ..animateTo(
                _chatViewKey
                    .currentState.scrollController.position.maxScrollExtent,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
              );

            if (i == 0) {
              systemMessage();
              Timer(Duration(milliseconds: 600), () {
                systemMessage();
              });
            } else {
              systemMessage();
            }
          });
        },
        trailing: <Widget>[
          IconButton(
              icon: Icon(Icons.photo),
              onPressed: () async {
                File result = await ImagePicker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 80,
                  maxHeight: 400,
                  maxWidth: 400,
                );
                setState(() {
                  messages.add(ChatMessage(
                      user: otherUser, text: "image", image: "${result}"));
                });

                if (result != null) {
                  return null;
                }
              }),
        ],
        onSend: (ChatMessage message) {
          setState(() {
            messages.add(message);
          });
        },
      ),
    );
  }
}
