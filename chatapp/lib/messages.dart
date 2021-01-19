import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/UserMessage.dart';

class UserMessages extends StatelessWidget {
 List<UserMessage> messages;
  var user_chatted_with;
  UserMessages(this.messages, this.user_chatted_with);

  @override
  Widget build(BuildContext context) {
    if (messages != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: messages
            .map(
              (element) => Column(children: [
                Container(
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: user_chatted_with == element.sender
                            ? Colors.white
                            : Colors.yellow),
                    child: Card(
                      child: Text(element.text),
                    )),
                  Text(convertTimestamp(element.timestamp))
              ]),
            )
            .toList(),
      );
    } else {
      return new CircularProgressIndicator();
    }
  }
}

String convertTimestamp(String timestampsss) {
    var parsedDate = DateTime.parse(timestampsss);
    var format = DateFormat('HH:mm');
    String time = format.format(parsedDate);
    return time;
    // int timestamp = int.parse(timestampsss);
    // var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp);
    // var format = DateFormat('HH:mm');
    // String time = format.format(date);
    // return time;
}
