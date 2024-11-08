import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import 'post_composer.dart';
import 'post.dart';

class MainFeed extends StatefulWidget {
  final bool showSidebarContent;

  const MainFeed({Key? key, required this.showSidebarContent})
      : super(key: key);

  @override
  State<MainFeed> createState() => _MainFeedState();
}

class _MainFeedState extends State<MainFeed> {
  final List<Map<String, String>> updates = [
    {
      'emoji': '🏋️',
      'title': 'New Gym Equipment',
      'subtitle': 'Arriving next week · Amenities',
    },
    {
      'emoji': '🌿',
      'title': 'Roof Garden Now Open',
      'subtitle': 'Open daily · Community',
    },
    {
      'emoji': '🎉',
      'title': 'Community BBQ',
      'subtitle': 'This Saturday · Events',
    },
    {
      'emoji': '🏊',
      'title': 'Pool Maintenance',
      'subtitle': 'Closed on Monday · Facilities',
    },
    {
      'emoji': '📚',
      'title': 'Book Club Meeting',
      'subtitle': 'Next Wednesday · Social',
    },
  ];

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
  }

  void _startScrolling() {
    Future.delayed(const Duration(seconds: 2), () {
      if (_scrollController.hasClients) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        final minScrollExtent = _scrollController.position.minScrollExtent;

        Future.doWhile(() async {
          await _scrollController.animateTo(
            maxScrollExtent,
            duration: Duration(seconds: updates.length * 5),
            curve: Curves.linear,
          );
          await _scrollController.animateTo(
            minScrollExtent,
            duration: Duration(seconds: updates.length * 5),
            curve: Curves.linear,
          );
          return true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostModel>(
      builder: (context, postModel, child) {
        return Column(
          children: [
            // Building Updates Section with Scrolling Effect
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
                    Container(
                      height: 100,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: updates.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 300,
                            child: _buildUpdateItem(
                              updates[index]['emoji']!,
                              updates[index]['title']!,
                              updates[index]['subtitle']!,
                            ),
                          );
                        },
                      ),
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
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
              mainAxisAlignment: MainAxisAlignment.center,
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
