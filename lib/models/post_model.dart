import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class Post {
  final String id;
  final String content;
  final String authorName;
  final DateTime timestamp;
  int comments;
  int reposts;
  int likes;
  int views;

  Post({
    required this.id,
    required this.content,
    required this.authorName,
    required this.timestamp,
    this.comments = 0,
    this.reposts = 0,
    this.likes = 0,
    this.views = 0,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      content: json['content'] as String,
      authorName: json['author_name'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      comments: json['comments'] as int? ?? 0,
      reposts: json['reposts'] as int? ?? 0,
      likes: json['likes'] as int? ?? 0,
      views: json['views'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'author_name': authorName,
      'timestamp': timestamp.toIso8601String(),
      'comments': comments,
      'reposts': reposts,
      'likes': likes,
      'views': views,
    };
  }
}

class PostModel extends ChangeNotifier {
  final List<Post> _posts = [];
  final _supabase = Supabase.instance.client;

  List<Post> get posts => List.unmodifiable(_posts);

  PostModel() {
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    try {
      print('Loading posts from Supabase...');
      final response = await _supabase
          .from('posts')
          .select()
          .order('timestamp', ascending: false);
      print('Received response from Supabase: $response');

      _posts.clear();
      for (final postData in response) {
        _posts.add(Post.fromJson(postData));
      }
      notifyListeners();
    } catch (e, stackTrace) {
      print('Error loading posts: $e');
      print('Stack trace: $stackTrace');
    }
  }

  Future<void> addPost(String content, String authorName) async {
    final uuid = const Uuid().v4();
    final newPost = Post(
      id: uuid,
      content: content,
      authorName: authorName,
      timestamp: DateTime.now().toUtc(),
    );

    try {
      // Add to local list first
      _posts.insert(0, newPost);
      notifyListeners();

      // Then add to Supabase
      await _supabase.from('posts').insert(newPost.toJson());
      print('Post successfully added to Supabase');

      // Reload posts to ensure consistency
      await _loadPosts();
    } catch (e, stackTrace) {
      // If Supabase insert fails, remove from local list
      _posts.removeWhere((post) => post.id == newPost.id);
      notifyListeners();

      print('Error adding post: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  void incrementComments(String postId) {
    final post = _posts.firstWhere((post) => post.id == postId);
    post.comments++;
    notifyListeners();
  }

  void incrementReposts(String postId) {
    final post = _posts.firstWhere((post) => post.id == postId);
    post.reposts++;
    notifyListeners();
  }

  void incrementLikes(String postId) {
    final post = _posts.firstWhere((post) => post.id == postId);
    post.likes++;
    notifyListeners();
  }

  void incrementViews(String postId) {
    final post = _posts.firstWhere((post) => post.id == postId);
    post.views++;
    notifyListeners();
  }
}
