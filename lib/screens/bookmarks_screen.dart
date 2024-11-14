import 'package:flutter/material.dart';
import '../widgets/custom_navigation_drawer.dart';
import '../widgets/bottom_home_button.dart';
import 'community_guidelines_screen.dart';
import 'maintenance_request_screen.dart';
import 'amenity_reservations_screen.dart';
import 'emergency_contacts_screen.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
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
                'Bookmarks',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildBookmarkItem(
                context,
                'Community Guidelines',
                'Important rules and regulations for all residents',
                Icons.book,
                const CommunityGuidelinesScreen(),
              ),
              _buildBookmarkItem(
                context,
                'Maintenance Request Form',
                'Quick access to submit maintenance requests',
                Icons.build,
                const MaintenanceRequestScreen(),
              ),
              _buildBookmarkItem(
                context,
                'Amenity Reservations',
                'Book common areas and amenities',
                Icons.event,
                const AmenityReservationsScreen(),
              ),
              _buildBookmarkItem(
                context,
                'Emergency Contacts',
                'Important numbers for emergencies',
                Icons.emergency,
                const EmergencyContactsScreen(),
              ),
            ],
          ),
          const BottomHomeButton(),
        ],
      ),
    );
  }

  Widget _buildBookmarkItem(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Widget destinationScreen,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.grey[900],
      child: ListTile(
        leading: Icon(icon, size: 36, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(color: Colors.grey[400]),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
        onTap: () => _navigateToScreen(context, destinationScreen),
      ),
    );
  }
}
