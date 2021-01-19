import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'ChatScreen.dart';
import 'models/User.dart';

class MainScreen extends StatefulWidget {
  static const String id = "MainScreen";
  @override
  _MyAppState createState() => _MyAppState();
}

// MainScreen({key, @required this.users}) : super(key: key);
class _MyAppState extends State<MainScreen> {
  Future<List<User>> users;
  String user_auth;
  
  @override
  void initState() {
    super.initState();
    if (user_auth == null) {
      getUserAuth().then((String s) => setState((){
            user_auth = s;
          users =  getallusers(user_auth);
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Main Screen'),
            ),
            body: Container(
                child: FutureBuilder<List<User>>(
                    future: users,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var user = snapshot.data[index];
                            print(user);
                            return ListTile(
                              title: Text(user.username),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChatScreen(
                                            user: user.username,
                                            user_auth: user_auth),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return new Text("${snapshot.error}");
                      }

                      // By default, show a loading spinner
                      return new CircularProgressIndicator();
                    }))));
  }
}

Future<String> getUserAuth() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var user = prefs.getString("user");
  print("user we logged is:$user");
  return user;
}

Future<List<User>> getallusers(username) async {
  print("getallusers called");
  print("we call it with username: $username");
  // var url = "http://10.0.2.2:4000/api/users/except/$username";
  // http.Response response = await http.get(
  //   url,
  //   headers: <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   },
  // );
  var headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };
  var uri = Uri.http("10.0.2.2:4000", "/api/users/except/$username");
  var response = await http.get(uri, headers: headers);

  Iterable l = json.decode(response.body);
  List<User> users = List<User>.from(l.map((model) => User.fromJson(model)));
  print(users);
  return users;
}
