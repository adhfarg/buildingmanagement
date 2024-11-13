import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';

class PostCreationButtons extends StatefulWidget {
  final Function(List<File>) onImageSelected;
  final Function(String) onGifSelected;
  final Function(String) onEmojiSelected;
  final Function(Map<String, int>) onPollCreated;
  final Function(DateTime) onScheduleSelected;
  final Function(String) onLocationSelected;

  const PostCreationButtons({
    Key? key,
    required this.onImageSelected,
    required this.onGifSelected,
    required this.onEmojiSelected,
    required this.onPollCreated,
    required this.onScheduleSelected,
    required this.onLocationSelected,
  }) : super(key: key);

  @override
  _PostCreationButtonsState createState() => _PostCreationButtonsState();
}

class _PostCreationButtonsState extends State<PostCreationButtons> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage();
      if (images != null && images.isNotEmpty) {
        widget
            .onImageSelected(images.map((xFile) => File(xFile.path)).toList());
      }
    } catch (e) {
      print('Error picking images: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick images. Please try again.')),
      );
    }
  }

  Future<void> _pickGif(BuildContext context) async {
    try {
      final gif = await GiphyPicker.pickGif(
        context: context,
        apiKey: 'mwtfTseYVUSHvp1YaZXF9YMfotgTzhf1',
      );
      if (gif != null && gif.images.original?.url != null) {
        widget.onGifSelected(gif.images.original!.url!);
      }
    } catch (e) {
      print('Error picking GIF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load GIFs. Please try again later.')),
      );
    }
  }

  void _showEmojiPicker(BuildContext context) {
    // Implement emoji picker
    widget.onEmojiSelected('😊'); // Placeholder implementation
  }

  void _showPollCreator(BuildContext context) {
    // Implement poll creation UI and logic here
    final Map<String, int> dummyPoll = {
      'Option 1': 0,
      'Option 2': 0,
      'Option 3': 0,
    };
    widget.onPollCreated(dummyPoll);
  }

  Future<void> _showDateTimePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final DateTime scheduledDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        widget.onScheduleSelected(scheduledDateTime);
      }
    }
  }

  void _showLocationPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Location'),
          content: SizedBox(
            width: 300,
            height: 300,
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(0, 0),
                zoom: 2,
              ),
              onTap: (LatLng position) {
                Navigator.pop(context);
                widget.onLocationSelected(
                    '${position.latitude}, ${position.longitude}');
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.image),
          onPressed: _pickImage,
          color: Colors.grey[600],
        ),
        IconButton(
          icon: const Icon(Icons.gif),
          onPressed: () => _pickGif(context),
          color: Colors.grey[600],
        ),
        IconButton(
          icon: const Icon(Icons.poll),
          onPressed: () => _showPollCreator(context),
          color: Colors.grey[600],
        ),
        IconButton(
          icon: const Icon(Icons.emoji_emotions),
          onPressed: () => _showEmojiPicker(context),
          color: Colors.grey[600],
        ),
        IconButton(
          icon: const Icon(Icons.schedule),
          onPressed: () => _showDateTimePicker(context),
          color: Colors.grey[600],
        ),
        IconButton(
          icon: const Icon(Icons.location_on),
          onPressed: () => _showLocationPicker(context),
          color: Colors.grey[600],
        ),
      ],
    );
  }
}
