import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import '../widgets/post.dart';
import '../widgets/custom_navigation_drawer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _postController = TextEditingController();
  bool _isLoading = false;

  final List<Map<String, String>> _activeResidents = [
    {'name': 'Noah A.', 'avatar': 'N'},
    {'name': 'Ramee Y.', 'avatar': 'R'},
    {'name': 'Alex T.', 'avatar': 'A'},
    {'name': 'Emma R.', 'avatar': 'E'},
    {'name': 'Jasmine Y.', 'avatar': 'J'},
  ];

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  Future<String> _getUserName() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user != null) {
        final profileData = await Supabase.instance.client
            .from('profiles')
            .select('first_name, last_name')
            .eq('id', user.id)
            .single();

        if (profileData != null) {
          return '${profileData['first_name']} ${profileData['last_name']}';
        }
      }
    } catch (e) {
      print('Error getting user name: $e');
    }
    return 'Anonymous User';
  }

  Future<void> _createPost() async {
    if (_postController.text.trim().isEmpty) return;
    setState(() => _isLoading = true);

    try {
      final userName = await _getUserName();
      await Provider.of<PostModel>(context, listen: false)
          .addPost(_postController.text.trim(), userName);

      _postController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Post created successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating post: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.png',
          height: 150,
          fit: BoxFit.contain,
        ),
        backgroundColor: Colors.black,
        toolbarHeight: 160,
      ),
      drawer: const CustomNavigationDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _postController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "What's happening in the building?",
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    maxLines: null,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _isLoading ? null : _createPost,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('Post'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<PostModel>(
              builder: (context, postModel, child) {
                return ListView.builder(
                  itemCount: postModel.posts.length,
                  itemBuilder: (context, index) {
                    return PostWidget(
                      index: index,
                      post: postModel.posts[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateItem(String emoji, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavIcon(IconData icon) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () {},
      color: Colors.white,
    );
  }
}
