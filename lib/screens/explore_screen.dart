import 'package:flutter/material.dart';
import '../widgets/custom_navigation_drawer.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

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
            'Explore Building Features',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildFeatureCard(
            'Gym',
            'State-of-the-art equipment available 24/7',
            Icons.fitness_center,
          ),
          _buildFeatureCard(
            'Pool',
            'Olympic-sized pool open from 6 AM to 10 PM',
            Icons.pool,
          ),
          _buildFeatureCard(
            'Rooftop Garden',
            'Relax and enjoy the view from our beautiful rooftop garden',
            Icons.local_florist,
          ),
          _buildFeatureCard(
            'Community Room',
            'Host events or gatherings in our spacious community room',
            Icons.group,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(String title, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, size: 48),
        title: Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // TODO: Navigate to feature details
        },
      ),
    );
  }
}
