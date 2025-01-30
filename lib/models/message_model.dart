import 'package:flutter/foundation.dart';

class Message {
  final String id;
  final String content;
  final String senderId;
  final String receiverId;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.content,
    required this.senderId,
    required this.receiverId,
    required this.timestamp,
  });
}

class MessageModel extends ChangeNotifier {
  final List<Message> _messages = [];

  List<Message> get messages => List.unmodifiable(_messages);

  void sendMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  List<Message> getConversation(String userId1, String userId2) {
    return _messages
        .where((message) =>
            (message.senderId == userId1 && message.receiverId == userId2) ||
            (message.senderId == userId2 && message.receiverId == userId1))
        .toList();
  }
}
