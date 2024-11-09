import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import 'post_composer.dart';
import 'post.dart';
import 'dart:async';
import 'dart:math';

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

  final List<String> allResidents = [
    'Sarah M.',
    'Alex T.',
    'Emma R.',
    'Adam F.',
    'Hussien A.',
    'Diana F.',
    'Amy G.',
    'Nagwa G.',
    'Magda L.',
    'Jasmine Y.',
    'Noah A.',
    'Ramee Y.',
  ];

  late ScrollController _scrollController;
  late Timer _residentRotationTimer;
  List<String> _currentResidents = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _shuffleAndSetResidents();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });

    _residentRotationTimer =
        Timer.periodic(const Duration(seconds: 6), (timer) {
      _shuffleAndSetResidents();
    });
  }

  void _shuffleAndSetResidents() {
    setState(() {
      List<String> shuffled = List.from(allResidents)..shuffle();
      _currentResidents =
          shuffled.take(5).toList(); // Changed from take(3) to take(5)
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
    _residentRotationTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostModel>(
      builder: (context, postModel, child) {
        return Column(
          children: [
            const PostComposer(),
            const SizedBox(height: 12),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 70,
                    child: Card(
                      color: Colors.grey[900],
                      margin: const EdgeInsets.only(left: 16, right: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Building Updates',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              height: 80,
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
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildNavIcon(
                                    context, Icons.search, '/explore'),
                                _buildNavIcon(context, Icons.notifications,
                                    '/notifications'),
                                _buildNavIcon(context, Icons.mail, '/messages'),
                                _buildNavIcon(
                                    context, Icons.bookmark, '/bookmarks'),
                                _buildNavIcon(
                                    context, Icons.group, '/communities'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 30,
                    child: Card(
                      color: Colors.grey[900],
                      margin: const EdgeInsets.only(left: 8, right: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Active Residents',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Container(
                                  width: 4,
                                  height: 4,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Center(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: _currentResidents
                                      .map(_buildActiveResidentChip)
                                      .toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.grey),
            ...List.generate(
              postModel.posts.length,
              (index) => PostWidget(
                index: index,
                post: postModel.posts[index],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUpdateItem(String emoji, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.deepPurple,
            radius: 16,
            child: Text(emoji, style: TextStyle(fontSize: 12)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
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
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildNavIcon(BuildContext context, IconData icon, String route) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
