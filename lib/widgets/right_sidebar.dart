import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class RightSidebar extends StatefulWidget {
  const RightSidebar({Key? key}) : super(key: key);

  @override
  _RightSidebarState createState() => _RightSidebarState();
}

class _RightSidebarState extends State<RightSidebar> {
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

  late Timer _residentRotationTimer;
  List<String> _currentResidents = [];

  @override
  void initState() {
    super.initState();
    _shuffleAndSetResidents();

    _residentRotationTimer =
        Timer.periodic(const Duration(seconds: 6), (timer) {
      _shuffleAndSetResidents();
    });
  }

  @override
  void dispose() {
    _residentRotationTimer.cancel();
    super.dispose();
  }

  void _shuffleAndSetResidents() {
    setState(() {
      List<String> shuffled = List.from(allResidents)..shuffle();
      _currentResidents = shuffled.take(5).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBuildingUpdates(),
            const SizedBox(height: 24),
            _buildActiveResidents(),
          ],
        ),
      ),
    );
  }

  Widget _buildBuildingUpdates() {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Building Updates',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...updates.map((update) => _buildUpdateItem(
                  update['emoji']!,
                  update['title']!,
                  update['subtitle']!,
                  _getRandomColor(),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateItem(
      String emoji, String title, String subtitle, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Text(emoji, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveResidents() {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Active Residents',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _currentResidents
                  .map((name) =>
                      _buildActiveResidentChip(name, _getRandomColor()))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveResidentChip(String name, Color color) {
    return Chip(
      avatar: CircleAvatar(
        backgroundColor: color.withOpacity(0.2),
        child: Text(
          name[0],
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
      label: Text(name),
      backgroundColor: Colors.grey[800],
      labelStyle: const TextStyle(color: Colors.white),
    );
  }

  Color _getRandomColor() {
    final List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.teal,
      Colors.amber,
      Colors.indigo,
    ];
    return colors[Random().nextInt(colors.length)];
  }
}
