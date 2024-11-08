import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import 'post_composer.dart';
import 'post.dart';

class MainFeed extends StatelessWidget {
  final bool showSidebarContent;

  const MainFeed({Key? key, required this.showSidebarContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PostModel>(
      builder: (context, postModel, child) {
        return ListView(
          children: [
            // Building Updates Section
            Card(
              color: Colors.grey[900],
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Building Updates',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildUpdateItem(
                      '🏋️',
                      'New Gym Equipment',
                      'Arriving next week · Amenities',
                    ),
                    _buildUpdateItem(
                      '🌿',
                      'Roof Garden Now Open',
                      'Open daily · Community',
                    ),
                    _buildUpdateItem(
                      '🎉',
                      'Community BBQ',
                      'This Saturday · Events',
                    ),
                  ],
                ),
              ),
            ),
            // Post Composer
            const PostComposer(),
            const Divider(color: Colors.grey),
            // Posts
            ...List.generate(
              postModel.posts.length,
              (index) => PostWidget(
                index: index,
                post: postModel.posts[index],
              ),
            ),
            // Active Residents Section at the bottom
            Card(
              color: Colors.grey[900],
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Active Residents',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildActiveResidentChip('Sarah M.'),
                        _buildActiveResidentChip('Alex T.'),
                        _buildActiveResidentChip('Emma R.'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUpdateItem(String emoji, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.deepPurple,
            child: Text(emoji),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
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
    );
  }

  Widget _buildActiveResidentChip(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(name),
    );
  }
}
