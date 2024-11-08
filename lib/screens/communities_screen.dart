import 'package:flutter/material.dart';
import '../widgets/custom_navigation_drawer.dart';

class CommunitiesScreen extends StatelessWidget {
  const CommunitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.png',
          height: 150,
          fit: BoxFit.contain,
        ),
        backgroundColor: Colors.black,
        toolbarHeight: 160,
      ),
      drawer: const CustomNavigationDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Communities',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildCommunityItem(
            'Fitness Enthusiasts',
            'Join fellow residents for workouts and fitness tips',
            Icons.fitness_center,
            Colors.blue,
          ),
          _buildCommunityItem(
            'Book Club',
            'Monthly meetings to discuss our latest read',
            Icons.book,
            Colors.green,
          ),
          _buildCommunityItem(
            'Pet Owners',
            'Connect with other pet owners in the building',
            Icons.pets,
            Colors.orange,
          ),
          _buildCommunityItem(
            'Gardening Group',
            'Share tips and help maintain our rooftop garden',
            Icons.local_florist,
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityItem(
      String title, String description, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: ElevatedButton(
          onPressed: () {
            // TODO: Join community functionality
          },
          child: const Text('Join'),
        ),
      ),
    );
  }
}
