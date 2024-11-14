import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' as foundation;

class PostCreationButtons extends StatelessWidget {
  final Function(List<File>) onImageSelected;
  final Function(GiphyGif) onGifSelected;
  final Function(String) onEmojiSelected;
  final Function() onPollCreated;
  final Function() onScheduleSelected;
  final Function() onLocationSelected;

  const PostCreationButtons({
    Key? key,
    required this.onImageSelected,
    required this.onGifSelected,
    required this.onEmojiSelected,
    required this.onPollCreated,
    required this.onScheduleSelected,
    required this.onLocationSelected,
  }) : super(key: key);

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    try {
      final List<XFile>? images = await picker.pickMultiImage();
      if (images != null && images.isNotEmpty) {
        onImageSelected(images.map((xFile) => File(xFile.path)).toList());
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick images')),
      );
    }
  }

  Future<void> _pickGif(BuildContext context) async {
    try {
      final gif = await GiphyPicker.pickGif(
        context: context,
        apiKey: 'mwtfTseYVUSHvp1YaZXF9YMfotgTzhf1',
        fullScreenDialog: true,
        showPreviewPage: true,
        sticker: false,
      );

      if (gif != null) {
        final gifUrl = gif.images.original?.url;
        if (gifUrl != null) {
          onGifSelected(gif);
        }
      }
    } catch (e) {
      print('Error picking GIF: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load GIFs')),
        );
      }
    }
  }

  void _showEmojiPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 250,
          child: EmojiPicker(
            onEmojiSelected: (Category? category, Emoji emoji) {
              Navigator.pop(context);
              onEmojiSelected(emoji.emoji);
            },
            config: Config(
              columns: 7,
              emojiSizeMax: 32 *
                  (foundation.defaultTargetPlatform == TargetPlatform.iOS
                      ? 1.30
                      : 1.0),
              verticalSpacing: 0,
              horizontalSpacing: 0,
              gridPadding: EdgeInsets.zero,
              initCategory: Category.RECENT,
              bgColor: Theme.of(context).scaffoldBackgroundColor,
              indicatorColor: Theme.of(context).primaryColor,
              iconColor: Colors.grey,
              iconColorSelected: Theme.of(context).primaryColor,
              backspaceColor: Theme.of(context).primaryColor,
              skinToneDialogBgColor: Colors.white,
              skinToneIndicatorColor: Colors.grey,
              enableSkinTones: true,
              recentTabBehavior: RecentTabBehavior.RECENT,
              recentsLimit: 28,
              noRecents: const Text(
                'No Recents',
                style: TextStyle(fontSize: 20, color: Colors.black26),
                textAlign: TextAlign.center,
              ),
              loadingIndicator: const SizedBox.shrink(),
              tabIndicatorAnimDuration: kTabScrollDuration,
              categoryIcons: const CategoryIcons(),
              buttonMode: ButtonMode.MATERIAL,
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
          onPressed: () => _pickImage(context),
          color: Colors.grey[600],
        ),
        IconButton(
          icon: const Icon(Icons.gif),
          onPressed: () => _pickGif(context),
          color: Colors.grey[600],
        ),
        IconButton(
          icon: const Icon(Icons.emoji_emotions),
          onPressed: () => _showEmojiPicker(context),
          color: Colors.grey[600],
        ),
        IconButton(
          icon: const Icon(Icons.poll),
          onPressed: onPollCreated,
          color: Colors.grey[600],
        ),
        IconButton(
          icon: const Icon(Icons.schedule),
          onPressed: onScheduleSelected,
          color: Colors.grey[600],
        ),
        IconButton(
          icon: const Icon(Icons.location_on),
          onPressed: onLocationSelected,
          color: Colors.grey[600],
        ),
      ],
    );
  }
}
