class UserMessage {
  final String text;
  final String sender;
  final String reciver;
  final String timestamp;

  UserMessage({this.text, this.sender, this.reciver, this.timestamp});

    factory UserMessage.fromJson(Map<String, dynamic> json) {

    return UserMessage(
      text: json['text'],
      sender: json['sender'],
      reciver: json['reciver'],
      timestamp: json['createdAt'],
    );
  }
  @override
  String toString() {
    // TODO: implement toString
    String tostring = "UserMessage: text:$text sender:$sender reciver: $reciver timstamp: $timestamp";
    return tostring;
  }
}