import 'package:flutter/material.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('ResidentHub',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          _buildDrawerItem(icon: Icons.home, title: 'Home'),
          _buildDrawerItem(icon: Icons.search, title: 'Explore'),
          _buildDrawerItem(icon: Icons.notifications, title: 'Notifications'),
          _buildDrawerItem(icon: Icons.mail, title: 'Messages'),
          _buildDrawerItem(icon: Icons.bookmark, title: 'Bookmarks'),
          _buildDrawerItem(icon: Icons.group, title: 'Communities'),
          _buildDrawerItem(icon: Icons.person, title: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String title}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        // Handle navigation
      },
    );
  }
}
