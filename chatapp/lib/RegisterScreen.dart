import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'MainScreen.dart';

class RegisterScreen extends StatelessWidget {
  var username;
  var password;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CupertinoTextField(
                placeholder: "UserName",
                clearButtonMode: OverlayVisibilityMode.editing,
                autocorrect: false,
                onChanged: (value) {
                  username = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CupertinoTextField(
                placeholder: "Password",
                clearButtonMode: OverlayVisibilityMode.editing,
                obscureText: true,
                autocorrect: false,
                onChanged: (value) {
                  password = value;
                },
              ),
            ),
            FlatButton.icon(
              onPressed: () async {
                print(username);
                print(password);
                signup(username, password);
                Navigator.pushNamed(context, MainScreen.id);
                // getallusers();
              },
              icon: Icon(Icons.login),
              label: Text("Sign Up"),
            ),
             FlatButton.icon(
              onPressed: () async {
                logout();
              },
              icon: Icon(Icons.logout),
              label: Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}

signup(username, password) async {
    print("signup called");
  var url = "http://10.0.2.2:4000/api/users/signup";
  final http.Response response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );
  print(response.body);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var parse = jsonDecode(response.body);
  await prefs.setString('token', parse["token"]);
  await prefs.setString('user', parse["user"]);
}

logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', "");
  await prefs.setString('user', "");
}