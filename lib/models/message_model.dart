import 'package:flutter/foundation.dart';

class Message {
  final String sender;
  final String preview;
  final String avatarUrl;
  final DateTime timestamp;

  Message({
    required this.sender,
    required this.preview,
    required this.avatarUrl,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class MessageModel extends ChangeNotifier {
  final List<Message> _messages = [
    Message(
      sender: 'Property Manager',
      preview: 'Thank you for your prompt response regarding...',
      avatarUrl: 'https://picsum.photos/seed/PropManager/200',
    ),
    Message(
      sender: 'Maintenance Team',
      preview: 'We\'ve scheduled the repair for your unit on...',
      avatarUrl: 'https://picsum.photos/seed/Maintenance/200',
    ),
    Message(
      sender: 'John from 4B',
      preview: 'Hey neighbor! I was wondering if you could...',
      avatarUrl: 'https://picsum.photos/seed/John4B/200',
    ),
  ];

  List<Message> get messages => List.unmodifiable(_messages);

  void addMessage(Message message) {
    _messages.insert(0, message);
    notifyListeners();
  }
}
