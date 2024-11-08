import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';

class PostWidget extends StatelessWidget {
  final int index;
  final Post post;

  const PostWidget({
    Key? key,
    required this.index,
    required this.post,
  }) : super(key: key);

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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${post.handle} · ${post.timeAgo}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              post.content,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInteractionButton(
                  context,
                  Icons.chat_bubble_outline,
                  post.comments.toString(),
                  () => context.read<PostModel>().incrementComments(index),
                ),
                _buildInteractionButton(
                  context,
                  Icons.repeat,
                  post.reposts.toString(),
                  () => context.read<PostModel>().incrementReposts(index),
                ),
                _buildInteractionButton(
                  context,
                  Icons.favorite_border,
                  post.likes.toString(),
                  () => context.read<PostModel>().incrementLikes(index),
                ),
                _buildInteractionButton(
                  context,
                  Icons.bar_chart,
                  post.views.toString(),
                  () => context.read<PostModel>().incrementViews(index),
                ),
                IconButton(
                  icon: const Icon(Icons.share, size: 18),
                  onPressed: () {},
                  color: Colors.grey[600],
                ),
              ],
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
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(
            count,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
