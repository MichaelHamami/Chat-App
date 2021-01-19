import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'messages.dart';
import 'models/UserMessage.dart';

class MessageManager extends StatefulWidget {
  var user_auth;
  var user_chatwith;
  MessageManager({this.user_auth, this.user_chatwith});

  @override
  State<StatefulWidget> createState() {
    return _MessageManagerState();
  }
}

class _MessageManagerState extends State<MessageManager> {
    List<UserMessage> allusermessages = new List();
  var logged_user;
  var chatted_with;
  var textmessage;
  @override
  void initState() {
    print("Init State called MessageManager");
    super.initState();
    logged_user = widget.user_auth;
    chatted_with = widget.user_chatwith;
    print(logged_user);
    print(chatted_with);
      getAllMessagesOfChat(logged_user, chatted_with).then(
        (value) => setState((){
          allusermessages = value;
          print(allusermessages);
          print(value);
        }));
  }

  @override
  void didUpdateWidget(MessageManager oldWidget) {
    print("didUpdateWidget called MessageManager");
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print("build called");
    if(allusermessages == null)
    {

    }
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              iconSize: 30,
              color: Colors.black,
              onPressed: () {},
            ),
            Text(
              chatted_with.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            // Spacer(),
            Icon(Icons.account_circle, size: 100)
          ],
        ),
        Container(
          child: allusermessages != null ? UserMessages(allusermessages, chatted_with): CircularProgressIndicator()
        ),
        Spacer(),
        Container(
            margin: EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Flexible(
                    child: CupertinoTextField(
                      placeholder: "Typ something...",
                      clearButtonMode: OverlayVisibilityMode.editing,
                      autocorrect: false,
                      onChanged: (value) {
                        textmessage = value;
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.upload_file),
                    iconSize: 30,
                    color: Colors.blue,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.mic),
                    iconSize: 30,
                    color: Colors.blue,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    iconSize: 30,
                    color: Colors.yellow,
                    onPressed: () {
                      setState(() {
                        allusermessages.add(UserMessage(
                            text: textmessage,
                            sender: logged_user,
                            reciver: chatted_with,
                            timestamp: new DateTime.now().toString()
                                ));
                      });
                     send_message(textmessage, logged_user, chatted_with);

                    },
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

send_message(text, sender, reciver) async {
  print("send_message called with: text: $text sender:$sender reciver: $reciver");
  var url = "http://10.0.2.2:4000/api/messages/send";
   http.Response response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'text': text,
      'sender': sender,
      'reciver': reciver,
    }),
  );
  var response_body = response.body;
  print("response body of send message is: $response_body");
}

Future<List<UserMessage>> getAllMessagesOfChat(sender, reciver) async {
  print("getAllMessagesOfChat called with sender:$sender and reciver:$reciver");
  var headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };
  // var url = "http://10.0.2.2:4000/api/messages/$sender/$reciver/ordered";
  var uri = Uri.http("10.0.2.2:4000", "/api/messages/$sender/$reciver/ordered");
  var response = await http.get(uri, headers: headers);
  print("response: $response");
  Iterable l = json.decode(response.body);
  List<UserMessage> messages =
      List<UserMessage>.from(l.map((model) => UserMessage.fromJson(model)));
  if (messages == null) {
    print("messages null ");
    return new List<UserMessage>();
  }
  print(messages);
  return messages;
}
