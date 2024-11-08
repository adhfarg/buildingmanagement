import 'package:flutter/foundation.dart';

class Post {
  final String avatar;
  final String name;
  final String username;
  final String timestamp;
  final String content;
  int comments;
  int reposts;
  int likes;
  int views;

  Post({
    required this.avatar,
    required this.name,
    required this.username,
    required this.timestamp,
    required this.content,
    this.comments = 0,
    this.reposts = 0,
    this.likes = 0,
    this.views = 0,
  });
}

class PostModel extends ChangeNotifier {
  List<Post> _posts = [
    Post(
      avatar: 'https://picsum.photos/seed/PropManager/200',
      name: 'Property Manager',
      username: 'PropManager',
      timestamp: '2h',
      content:
          '🔧 Reminder: Building maintenance scheduled for tomorrow from 9 AM to 12 PM. Please ensure easy access to common areas. Thank you for your cooperation! #BuildingMaintenance',
      comments: 12,
      reposts: 5,
      likes: 32,
      views: 245,
    ),
    Post(
      avatar: 'https://picsum.photos/seed/JohnD/200',
      name: 'John Doe',
      username: 'JohnD',
      timestamp: '4h',
      content:
          '🔑 Lost keys found near the elevator on the 3rd floor. If they\'re yours, please contact the front desk. Let\'s get them back to their owner! #LostAndFound',
      comments: 8,
      reposts: 2,
      likes: 15,
      views: 180,
    ),
    Post(
      avatar: 'https://picsum.photos/seed/SarahS/200',
      name: 'Sarah Smith',
      username: 'SarahS',
      timestamp: '1d',
      content:
          '🎉 Just a reminder about our community BBQ this Saturday! Don\'t forget to RSVP if you haven\'t already. Looking forward to seeing everyone there! #CommunityEvent',
      comments: 25,
      reposts: 10,
      likes: 50,
      views: 420,
    ),
  ];

  List<Post> get posts => _posts;

  void addPost(Post post) {
    _posts.insert(0, post);
    notifyListeners();
  }
}
