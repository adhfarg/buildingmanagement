import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import 'post_creation_buttons.dart';
import 'dart:io';

class PostComposer extends StatefulWidget {
  const PostComposer({Key? key}) : super(key: key);

  @override
  State<PostComposer> createState() => _PostComposerState();
}

class _PostComposerState extends State<PostComposer> {
  final TextEditingController _controller = TextEditingController();
  List<File> _selectedImages = [];
  String? _selectedGif;
  String? _selectedEmoji;
  Map<String, int>? _createdPoll;
  DateTime? _scheduledDateTime;
  String? _selectedLocation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitPost() {
    if (_controller.text.isNotEmpty) {
      String content = _controller.text;
      if (_selectedImages.isNotEmpty) {
        content += '\n[${_selectedImages.length} images attached]';
      }
      if (_selectedGif != null) {
        content += '\n[GIF: $_selectedGif]';
      }
      if (_selectedEmoji != null) {
        content += ' $_selectedEmoji';
      }
      if (_createdPoll != null) {
        content += '\n[Poll attached]';
      }
      if (_scheduledDateTime != null) {
        content += '\n[Scheduled for: ${_scheduledDateTime!.toLocal()}]';
      }
      if (_selectedLocation != null) {
        content += '\n[Location: $_selectedLocation]';
      }
      context.read<PostModel>().addPost(content);
      _resetState();
    }
  }

  void _resetState() {
    _controller.clear();
    setState(() {
      _selectedImages = [];
      _selectedGif = null;
      _selectedEmoji = null;
      _createdPoll = null;
      _scheduledDateTime = null;
      _selectedLocation = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage('https://i.pravatar.cc/150?img=1'),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "What's happening in the building?",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: PostCreationButtons(
                    onImageSelected: (images) =>
                        setState(() => _selectedImages = images),
                    onGifSelected: (gif) => setState(() => _selectedGif = gif),
                    onEmojiSelected: (emoji) =>
                        setState(() => _selectedEmoji = emoji),
                    onPollCreated: (poll) =>
                        setState(() => _createdPoll = poll),
                    onScheduleSelected: (dateTime) =>
                        setState(() => _scheduledDateTime = dateTime),
                    onLocationSelected: (location) =>
                        setState(() => _selectedLocation = location),
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitPost,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Post'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
