import 'package:flutter/material.dart';

class RightSidebar extends StatelessWidget {
  const RightSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildBuildingUpdates(),
            const SizedBox(height: 16),
            _buildActiveResidents(),
          ],
        ),
      ),
    );
  }

  Widget _buildBuildingUpdates() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Building Updates',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildUpdateItem(
                '🏋️', 'New Gym Equipment', 'Arriving next week · Amenities'),
            _buildUpdateItem(
                '🌿', 'Roof Garden Now Open', 'Open daily · Community'),
            _buildUpdateItem('🍖', 'Community BBQ', 'This Saturday · Events'),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateItem(String emoji, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(child: Text(emoji)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle,
                    style: TextStyle(color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveResidents() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Active Residents',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
    );
  }

  Widget _buildActiveResidentChip(String name) {
    return Chip(
      label: Text(name),
      backgroundColor: Colors.grey[800],
    );
  }
}
