import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'messages_manager.dart';

class ChatScreen extends StatelessWidget {
  static const String id = "ChatScreen";
  String user;
  String user_auth;

  ChatScreen({this.user,this.user_auth});

  @override
  Widget build(BuildContext context) {
    print("build of Chat screen called with user: $user and user_auth: $user_auth");
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Chat Screen'),
        ),
        body: MessageManager(user_auth:user_auth, user_chatwith: user),
      ),
    );
  }
}