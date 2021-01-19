import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'ChatScreen.dart';
import 'MainScreen.dart';
import 'RegisterScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RegisterScreen(),
      routes: {
        MainScreen.id: (context) => MainScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}