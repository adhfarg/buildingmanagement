import 'package:flutter/material.dart';
import '../widgets/custom_navigation_drawer.dart';
import '../widgets/bottom_home_button.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

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
                'Notifications',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildNotificationItem(
                'Maintenance Update',
                'The elevator maintenance is complete. Thank you for your patience.',
                '2 hours ago',
              ),
              _buildNotificationItem(
                'Community Event',
                'Don\'t forget about the rooftop BBQ this Saturday!',
                '1 day ago',
              ),
              _buildNotificationItem(
                'Package Delivery',
                'You have a package waiting at the front desk.',
                '2 days ago',
              ),
            ],
          ),
          const BottomHomeButton(),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(String title, String content, String time) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(content),
        trailing: Text(time, style: TextStyle(color: Colors.grey[600])),
      ),
    );
  }
}
