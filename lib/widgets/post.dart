import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/post_model.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(post.avatar),
                  onBackgroundImageError: (_, __) => const Icon(Icons.error),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('@${post.username} · ${post.timestamp}',
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(post.content),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPostStat(FontAwesomeIcons.comment, post.comments),
                _buildPostStat(FontAwesomeIcons.retweet, post.reposts),
                _buildPostStat(FontAwesomeIcons.heart, post.likes),
                _buildPostStat(FontAwesomeIcons.chartBar, post.views),
                const Icon(FontAwesomeIcons.share, size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostStat(IconData icon, int count) {
    return Row(
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 4),
        Text(count.toString()),
      ],
    );
  }
}
