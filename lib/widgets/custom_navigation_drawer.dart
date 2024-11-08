import 'package:flutter/material.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.black),
            child: Center(
              child: Image.asset(
                'assets/logo.png',
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.home,
            title: 'Home',
            route: '/',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.search,
            title: 'Explore',
            route: '/explore',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.notifications,
            title: 'Notifications',
            route: '/notifications',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.mail,
            title: 'Messages',
            route: '/messages',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.bookmark,
            title: 'Bookmarks',
            route: '/bookmarks',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.group,
            title: 'Communities',
            route: '/communities',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.person,
            title: 'Profile',
            route: '/profile',
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context); // Close the drawer
        if (ModalRoute.of(context)?.settings.name != route) {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }
}
