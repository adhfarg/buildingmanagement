import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Post {
  final String username;
  final String handle;
  final String content;
  final String timeAgo;
  int comments;
  int reposts;
  int likes;
  int views;

  Post({
    required this.username,
    required this.handle,
    required this.content,
    required this.timeAgo,
    this.comments = 0,
    this.reposts = 0,
    this.likes = 0,
    this.views = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'handle': handle,
      'content': content,
      'timeAgo': timeAgo,
      'comments': comments,
      'reposts': reposts,
      'likes': likes,
      'views': views,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      username: json['username'] as String,
      handle: json['handle'] as String,
      content: json['content'] as String,
      timeAgo: json['timeAgo'] as String,
      comments: json['comments'] as int,
      reposts: json['reposts'] as int,
      likes: json['likes'] as int,
      views: json['views'] as int,
    );
  }
}

class PostModel extends ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  PostModel() {
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final postsJson = prefs.getString('posts');
      if (postsJson != null) {
        final List<dynamic> decodedList = jsonDecode(postsJson);
        _posts = decodedList.map((item) => Post.fromJson(item)).toList();
      }
      if (_posts.isEmpty) {
        _addInitialPosts();
      }
      notifyListeners();
    } catch (e) {
      print('Error loading posts: $e');
      _addInitialPosts();
      notifyListeners();
    }
  }

  Future<void> _savePosts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final postsJson =
          jsonEncode(_posts.map((post) => post.toJson()).toList());
      await prefs.setString('posts', postsJson);
    } catch (e) {
      print('Error saving posts: $e');
    }
  }

  void _addInitialPosts() {
    _posts = [
      Post(
        username: 'Property Manager',
        handle: '@PropManager',
        content:
            'Reminder: Building maintenance scheduled for tomorrow from 9 AM to 12 PM. Please ensure easy access to common areas. Thank you for your cooperation!',
        timeAgo: '2h',
        comments: 12,
        reposts: 5,
        likes: 32,
        views: 245,
      ),
      Post(
        username: 'John Doe',
        handle: '@JohnD',
        content:
            'Lost keys found near the elevator on the 3rd floor. If they\'re yours, please contact the front desk. Let\'s get them back to their owner!',
        timeAgo: '4h',
        comments: 8,
        reposts: 2,
        likes: 15,
        views: 180,
      ),
      Post(
        username: 'Sarah Smith',
        handle: '@SarahS',
        content:
            'Just a reminder about our community BBQ this Saturday! Don\'t forget to RSVP if you haven\'t already. Looking forward to seeing everyone there!',
        timeAgo: '1d',
        comments: 25,
        reposts: 10,
        likes: 50,
        views: 420,
      ),
    ];
    _savePosts();
  }

  void addPost(String content) {
    _posts.insert(
      0,
      Post(
        username: 'Current User',
        handle: '@CurrentUser',
        content: content,
        timeAgo: 'now',
      ),
    );
    _savePosts();
    notifyListeners();
  }

  void incrementComments(int index) {
    _posts[index].comments++;
    _savePosts();
    notifyListeners();
  }

  void incrementReposts(int index) {
    _posts[index].reposts++;
    _savePosts();
    notifyListeners();
  }

  void incrementLikes(int index) {
    _posts[index].likes++;
    _savePosts();
    notifyListeners();
  }

  void incrementViews(int index) {
    _posts[index].views++;
    _savePosts();
    notifyListeners();
  }
}
