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
    String profilePicUrl =
        'https://ui-avatars.com/api/?name=${Uri.encodeComponent(post.username)}&background=random&color=fff';

    return Card(
      color: Colors.grey[850],
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profilePicUrl),
                  radius: 20,
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
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${post.handle} · ${post.timeAgo}',
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
            const SizedBox(height: 8),
            Text(
              post.content,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
            const SizedBox(height: 12),
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
                  icon: const Icon(Icons.share_outlined, size: 18),
                  onPressed: () {},
                  color: Colors.grey[600],
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(
            count,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
