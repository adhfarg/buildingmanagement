import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import '../routes/routes.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final int index;

  const PostWidget({
    Key? key,
    required this.post,
    required this.index,
  }) : super(key: key);

  void _handleComment(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Comment'),
        content: TextField(
          decoration: const InputDecoration(
            hintText: 'Write your comment...',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<PostModel>(context, listen: false)
                  .incrementComments(index);
              Navigator.pop(context);
            },
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }

  void _handleRepost(BuildContext context) {
    Provider.of<PostModel>(context, listen: false).incrementReposts(index);
  }

  void _handleLike(BuildContext context) {
    Provider.of<PostModel>(context, listen: false).incrementLikes(index);
  }

  void _handleShare(BuildContext context) {
    Provider.of<PostModel>(context, listen: false).incrementViews(index);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share Post'),
        content: const Text('Sharing options will appear here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[800],
                  child: Text(post.username[0]),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.username,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      post.handle,
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  post.timeAgo,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(post.content),
            const SizedBox(height: 12),
            Consumer<PostModel>(
              builder: (context, postModel, child) {
                final updatedPost = postModel.posts[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInteractionButton(
                      context,
                      Icons.comment_outlined,
                      updatedPost.comments.toString(),
                      () => _handleComment(context),
                    ),
                    _buildInteractionButton(
                      context,
                      Icons.repeat,
                      updatedPost.reposts.toString(),
                      () => _handleRepost(context),
                    ),
                    _buildInteractionButton(
                      context,
                      Icons.favorite_border,
                      updatedPost.likes.toString(),
                      () => _handleLike(context),
                    ),
                    _buildInteractionButton(
                      context,
                      Icons.share,
                      updatedPost.views.toString(),
                      () => _handleShare(context),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractionButton(
    BuildContext context,
    IconData icon,
    String count,
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[500]),
          const SizedBox(width: 4),
          Text(count, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
        ],
      ),
    );
  }
}
