import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import 'post_creation_buttons.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'dart:io';

class PostComposer extends StatefulWidget {
  const PostComposer({Key? key}) : super(key: key);

  @override
  State<PostComposer> createState() => _PostComposerState();
}

class _PostComposerState extends State<PostComposer> {
  final TextEditingController _controller = TextEditingController();
  List<File> _selectedImages = [];
  GiphyGif? _selectedGif;
  String? _selectedEmoji;
  Map<String, int>? _poll;
  DateTime? _scheduledTime;
  String? _location;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitPost() {
    if (_controller.text.isNotEmpty ||
        _selectedGif != null ||
        _selectedImages.isNotEmpty) {
      final post = Post(
        username: 'Current User',
        handle: '@CurrentUser',
        content: _controller.text,
        timeAgo: 'now',
        gifUrl: _selectedGif?.images.original?.url,
        images: _selectedImages.map((file) => file.path).toList(),
        poll: _poll,
        scheduledTime: _scheduledTime,
        location: _location,
        comments: 0,
        reposts: 0,
        likes: 0,
        views: 0,
      );

      context.read<PostModel>().addPost(post);

      // Reset state
      setState(() {
        _controller.clear();
        _selectedImages = [];
        _selectedGif = null;
        _selectedEmoji = null;
        _poll = null;
        _scheduledTime = null;
        _location = null;
      });
    }
  }

  Widget _buildAttachmentPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_selectedImages.isNotEmpty)
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _selectedImages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          _selectedImages[index],
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedImages.removeAt(index);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.close,
                                size: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        if (_selectedGif != null)
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    _selectedGif!.images.original!.url!,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedGif = null;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, size: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        if (_poll != null)
          Card(
            color: Colors.grey[800],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._poll!.keys.map((option) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Icon(Icons.radio_button_unchecked,
                              color: Colors.white),
                          SizedBox(width: 8),
                          Text(option, style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    );
                  }).toList(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _poll = null;
                      });
                    },
                    child: Text('Remove Poll',
                        style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
          ),
        if (_scheduledTime != null)
          Chip(
            backgroundColor: Colors.grey[800],
            avatar: Icon(Icons.schedule, size: 16, color: Colors.white),
            label: Text(
              'Scheduled for: ${_scheduledTime!.toString().split('.').first}',
              style: TextStyle(color: Colors.white),
            ),
            onDeleted: () => setState(() => _scheduledTime = null),
            deleteIconColor: Colors.white,
          ),
        if (_location != null)
          Chip(
            backgroundColor: Colors.grey[800],
            avatar: Icon(Icons.location_on, size: 16, color: Colors.white),
            label: Text(_location!, style: TextStyle(color: Colors.white)),
            onDeleted: () => setState(() => _location = null),
            deleteIconColor: Colors.white,
          ),
      ],
    );
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
            _buildAttachmentPreview(),
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
                    onPollCreated: () =>
                        setState(() => _poll = {'Option 1': 0, 'Option 2': 0}),
                    onScheduleSelected: () async {
                      final DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (date != null) {
                        final TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          setState(() {
                            _scheduledTime = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              time.hour,
                              time.minute,
                            );
                          });
                        }
                      }
                    },
                    onLocationSelected: () =>
                        setState(() => _location = 'Current Location'),
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitPost,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
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
