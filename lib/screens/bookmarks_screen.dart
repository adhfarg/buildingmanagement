import 'package:flutter/material.dart';
import '../widgets/custom_navigation_drawer.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

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
            'Bookmarks',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildBookmarkItem(
            'Community Guidelines',
            'Important rules and regulations for all residents',
            Icons.book,
          ),
          _buildBookmarkItem(
            'Maintenance Request Form',
            'Quick access to submit maintenance requests',
            Icons.build,
          ),
          _buildBookmarkItem(
            'Amenity Reservations',
            'Book common areas and amenities',
            Icons.event,
          ),
          _buildBookmarkItem(
            'Emergency Contacts',
            'Important numbers for emergencies',
            Icons.emergency,
          ),
        ],
      ),
    );
  }

  Widget _buildBookmarkItem(String title, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, size: 36),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // TODO: Navigate to bookmarked content
        },
      ),
    );
  }
}
