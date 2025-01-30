import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../routes/routes.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey[850],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.person, color: Colors.white, size: 35),
                ),
                const SizedBox(height: 10),
                FutureBuilder<String>(
                  future: _getUserName(),
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? 'Loading...',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.home_outlined,
            title: 'Home',
            onTap: () => Navigator.pushReplacementNamed(context, Routes.home),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.explore_outlined,
            title: 'Explore',
            onTap: () => Navigator.pushNamed(context, Routes.explore),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            onTap: () => Navigator.pushNamed(context, Routes.notifications),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.message_outlined,
            title: 'Messages',
            onTap: () => Navigator.pushNamed(context, Routes.messages),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.person_outline,
            title: 'Profile',
            onTap: () => Navigator.pushNamed(context, Routes.profile),
          ),
          const Divider(color: Colors.grey),
          _buildDrawerItem(
            context,
            icon: Icons.logout,
            title: 'Sign Out',
            onTap: () async {
              await Supabase.instance.client.auth.signOut();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, Routes.login);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }

  Future<String> _getUserName() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user != null) {
        final profileData = await Supabase.instance.client
            .from('profiles')
            .select('first_name, last_name')
            .eq('id', user.id)
            .single();

        if (profileData != null) {
          return '${profileData['first_name']} ${profileData['last_name']}';
        }
      }
    } catch (e) {
      print('Error getting user name: $e');
    }
    return 'Anonymous User';
  }
}
