import 'package:chatty/models/message.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService with ChangeNotifier {
  late IO.Socket socket;
  // late BuildContext _context;
  String? _userName;
  final List<Message> _messages = [];

  String? get getUserName => _userName; 

  SocketService() {
    _initSocket();
  }

  List<Message> get getMessages => _messages;

  void _initSocket() {
    socket = IO.io('http://10.0.2.2:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.on('connect', (_) {
      print('Socket connected');
      _authenticatedUser();
    });

    socket.on('message', (data) {
      _handleMessage(data);
    });
  }

  void _authenticatedUser() {
    if (_userName != null) {
      socket.emit('login', {'username': _userName});
    }
  }

  void _handleMessage(dynamic data) {
    print(data);
    final userName = data['username'];
    final content = data['message'];
    print('$userName, $content');
    if (userName != null && content['message'] != null) {
      final message = Message(content: content['message'], userName: userName, time: DateTime.now(), isReceived: true);
      _addMessage(message);
    }
  }

  void _addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  void sendMessage(String message) {
    if (_userName != null) {
      socket.emit('message', {'username' : _userName, 'message': message});
      final sentMessage = Message(content: 'You: $message', userName: _userName!, isReceived: false, time: DateTime.now());
      _addMessage(sentMessage);
    }
  }

  void setUserName(String userName) {
    _userName = userName;
    _authenticatedUser();
  }
}
