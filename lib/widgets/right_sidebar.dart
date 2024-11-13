import 'package:flutter/material.dart';

class RightSidebar extends StatelessWidget {
  const RightSidebar({Key? key}) : super(key: key);

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
            _buildUpdateItem(
              '🏋️',
              'New Gym Equipment',
              'Arriving next week · Amenities',
              Colors.blue,
            ),
            _buildUpdateItem(
              '🌿',
              'Roof Garden Now Open',
              'Open daily · Community',
              Colors.green,
            ),
            _buildUpdateItem(
              '🍖',
              'Community BBQ',
              'This Saturday · Events',
              Colors.orange,
            ),
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
              children: [
                _buildActiveResidentChip('Sarah M.', Colors.purple),
                _buildActiveResidentChip('Alex T.', Colors.blue),
                _buildActiveResidentChip('Emma R.', Colors.green),
                _buildActiveResidentChip('John D.', Colors.orange),
                _buildActiveResidentChip('Lisa K.', Colors.pink),
              ],
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
}
