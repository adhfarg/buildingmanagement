import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';

class PostComposer extends StatefulWidget {
  const PostComposer({Key? key}) : super(key: key);

  @override
  _PostComposerState createState() => _PostComposerState();
}

class _PostComposerState extends State<PostComposer> {
  final TextEditingController _postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _postController,
            decoration: const InputDecoration(
              hintText: "What's happening in the building?",
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              if (_postController.text.isNotEmpty) {
                Provider.of<PostModel>(context, listen: false).addPost(
                  Post(
                    avatar:
                        'https://picsum.photos/seed/${DateTime.now().millisecondsSinceEpoch}/200',
                    name: 'Current User',
                    username: 'currentuser',
                    timestamp: 'Just now',
                    content: _postController.text,
                  ),
                );
                _postController.clear();
              }
            },
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }
}
