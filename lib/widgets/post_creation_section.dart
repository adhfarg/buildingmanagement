import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import 'post_creation_buttons.dart';
import 'dart:io';

class PostCreationSection extends StatefulWidget {
  const PostCreationSection({super.key});

  @override
  State<PostCreationSection> createState() => _PostCreationSectionState();
}

class _PostCreationSectionState extends State<PostCreationSection> {
  final TextEditingController _postController = TextEditingController();
  List<File> _selectedImages = [];
  String? _selectedGif;
  List<String> _selectedEmojis = [];
  Map<String, int>? _pollData;
  DateTime? _scheduledDateTime;
  String? _selectedLocation;

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  void _handleImageSelected(List<File> images) {
    setState(() {
      _selectedImages.addAll(images);
    });
  }

  void _handleGifSelected(String gifUrl) {
    setState(() {
      _selectedGif = gifUrl;
    });
  }

  void _handleEmojiSelected(String emoji) {
    setState(() {
      _selectedEmojis.add(emoji);
    });
  }

  void _handlePollCreated(Map<String, int> pollData) {
    setState(() {
      _pollData = pollData;
    });
  }

  void _handleScheduleSelected(DateTime dateTime) {
    setState(() {
      _scheduledDateTime = dateTime;
    });
  }

  void _handleLocationSelected(String location) {
    setState(() {
      _selectedLocation = location;
    });
  }

  void _createPost() {
    if (_postController.text.isNotEmpty) {
      // Use the existing addPost method from PostModel
      context.read<PostModel>().addPost(_postController.text);

      // Clear the input fields and reset the state
      _postController.clear();
      setState(() {
        _selectedImages = [];
        _selectedGif = null;
        _selectedEmojis = [];
        _pollData = null;
        _scheduledDateTime = null;
        _selectedLocation = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _postController,
          decoration: const InputDecoration(
            hintText: 'What\'s on your mind?',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(12),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 8),
        PostCreationButtons(
          onImageSelected: _handleImageSelected,
          onGifSelected: _handleGifSelected,
          onEmojiSelected: _handleEmojiSelected,
          onPollCreated: _handlePollCreated,
          onScheduleSelected: _handleScheduleSelected,
          onLocationSelected: _handleLocationSelected,
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _createPost,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
          ),
          child: const Text('Post'),
        ),
        if (_selectedImages.isNotEmpty) ...[
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _selectedImages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Stack(
                    children: [
                      Image.file(
                        _selectedImages[index],
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              _selectedImages.removeAt(index);
                            });
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.black54,
                            padding: const EdgeInsets.all(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
        if (_selectedGif != null) ...[
          const SizedBox(height: 8),
          Stack(
            children: [
              Image.network(
                _selectedGif!,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 4,
                right: 4,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _selectedGif = null;
                    });
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black54,
                    padding: const EdgeInsets.all(4),
                  ),
                ),
              ),
            ],
          ),
        ],
        if (_selectedEmojis.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 4,
            children: _selectedEmojis.map((emoji) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedEmojis.remove(emoji);
                  });
                },
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 24),
                ),
              );
            }).toList(),
          ),
        ],
        if (_pollData != null) ...[
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Poll',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _pollData = null;
                          });
                        },
                      ),
                    ],
                  ),
                  ...(_pollData?.entries ?? [])
                      .map((entry) => Text('${entry.key}: ${entry.value}')),
                ],
              ),
            ),
          ),
        ],
        if (_scheduledDateTime != null) ...[
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.schedule),
              title: Text('Scheduled for: ${_scheduledDateTime.toString()}'),
              trailing: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _scheduledDateTime = null;
                  });
                },
              ),
            ),
          ),
        ],
        if (_selectedLocation != null) ...[
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.location_on),
              title: Text('Location: $_selectedLocation'),
              trailing: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _selectedLocation = null;
                  });
                },
              ),
            ),
          ),
        ],
      ],
    );
  }
}
