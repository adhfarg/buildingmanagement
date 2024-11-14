import 'package:flutter/material.dart';

class CommunityGuidelinesScreen extends StatelessWidget {
  const CommunityGuidelinesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Guidelines'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            'General Conduct',
            'Residents must maintain a respectful and peaceful environment. Noise levels should be kept at a reasonable level, especially between 10 PM and 8 AM.',
          ),
          _buildSection(
            'Common Areas',
            'Common areas are for all residents. Please keep these areas clean and tidy. Remove personal belongings after use.',
          ),
          _buildSection(
            'Waste Management',
            'Properly sort recyclables and waste. Large items must be disposed of according to building protocol.',
          ),
          _buildSection(
            'Pet Policy',
            'Pets must be registered with management. Clean up after your pets. Keep them leashed in common areas.',
          ),
          _buildSection(
            'Parking',
            'Park only in designated spots. Guest parking requires registration at the front desk.',
          ),
          _buildSection(
            'Maintenance',
            'Report maintenance issues promptly. Allow access for scheduled maintenance work.',
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                color: Colors.grey[300],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
