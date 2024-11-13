import 'package:flutter/material.dart';
import '../widgets/custom_navigation_drawer.dart';
import '../widgets/bottom_home_button.dart';

class Community {
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  bool isJoined;

  Community({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    this.isJoined = false,
  });
}

class CommunitiesScreen extends StatefulWidget {
  const CommunitiesScreen({Key? key}) : super(key: key);

  @override
  State<CommunitiesScreen> createState() => _CommunitiesScreenState();
}

class _CommunitiesScreenState extends State<CommunitiesScreen> {
  final List<Community> communities = [
    Community(
      name: 'Fitness Enthusiasts',
      description: 'Join fellow residents for workouts and fitness tips',
      icon: Icons.fitness_center,
      color: Colors.blue,
    ),
    Community(
      name: 'Book Club',
      description: 'Monthly meetings to discuss our latest read',
      icon: Icons.book,
      color: Colors.green,
    ),
    Community(
      name: 'Pet Owners',
      description: 'Connect with other pet owners in the building',
      icon: Icons.pets,
      color: Colors.orange,
    ),
    Community(
      name: 'Gardening Group',
      description: 'Share tips and help maintain our rooftop garden',
      icon: Icons.local_florist,
      color: Colors.purple,
    ),
  ];

  void _toggleJoin(int index) {
    setState(() {
      communities[index].isJoined = !communities[index].isJoined;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          communities[index].isJoined
              ? 'Joined ${communities[index].name}'
              : 'Left ${communities[index].name}',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[850],
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

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
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            children: [
              const Text(
                'Communities',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...List.generate(
                communities.length,
                (index) => _buildCommunityItem(index),
              ),
            ],
          ),
          const BottomHomeButton(),
        ],
      ),
    );
  }

  Widget _buildCommunityItem(int index) {
    final community = communities[index];
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: community.color,
          child: Icon(community.icon, color: Colors.white),
        ),
        title: Text(community.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(community.description),
        trailing: ElevatedButton(
          onPressed: () => _toggleJoin(index),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                community.isJoined ? Colors.grey[800] : Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(community.isJoined ? 'Joined' : 'Join'),
        ),
      ),
    );
  }
}
