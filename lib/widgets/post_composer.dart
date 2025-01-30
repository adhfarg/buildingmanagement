import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import 'post_creation_buttons.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';

class PostComposer extends StatefulWidget {
  const PostComposer({Key? key}) : super(key: key);

  @override
  _PostComposerState createState() => _PostComposerState();
}

class _PostComposerState extends State<PostComposer> {
  final _contentController = TextEditingController();
  bool _isComposing = false;
  bool _isLoading = false;
  List<File> _selectedImages = [];
  GiphyGif? _selectedGif;
  String? _selectedEmoji;
  Map<String, int>? _poll;
  DateTime? _scheduledTime;
  String? _location;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<String> _getUserName() async {
    try {
      print('Fetching current user...');
      final user = Supabase.instance.client.auth.currentUser;
      if (user != null) {
        print('User found, fetching profile data...');
        final profileData = await Supabase.instance.client
            .from('profiles')
            .select('first_name, last_name')
            .eq('id', user.id)
            .single();

        print('Profile data retrieved: $profileData');
        if (profileData != null) {
          final name =
              '${profileData['first_name']} ${profileData['last_name']}';
          print('Returning user name: $name');
          return name;
        }
      }
    } catch (e) {
      print('Error getting user name: $e');
    }
    return 'Anonymous User';
  }

  Future<void> _handleSubmitted() async {
    final content = _contentController.text.trim();
    if (content.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      final userName = await _getUserName();
      await Provider.of<PostModel>(context, listen: false)
          .addPost(content, userName);

      _contentController.clear();
      setState(() {
        _isComposing = false;
        _selectedImages = [];
        _selectedGif = null;
        _selectedEmoji = null;
        _poll = null;
        _scheduledTime = null;
        _location = null;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Post created successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('Error creating post: $e');
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
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _contentController,
              maxLines: 3,
              minLines: 1,
              decoration: const InputDecoration(
                hintText: 'What\'s happening in the building?',
                border: InputBorder.none,
              ),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.trim().isNotEmpty;
                });
              },
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed:
                      _isComposing && !_isLoading ? _handleSubmitted : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
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
          ],
        ),
      ),
    );
  }
}
