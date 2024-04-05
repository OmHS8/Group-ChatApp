class Message {
  String content;
  String userName;
  bool isReceived;
  final DateTime time;

  Message ({
    required this.content, required this.userName, required this.isReceived, required this.time
  });
}