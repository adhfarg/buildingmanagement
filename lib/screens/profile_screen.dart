import 'package:flutter/material.dart';
import '../widgets/custom_navigation_drawer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = '';
  String _apartmentNumber = '';
  String _email = '';
  String _phoneNumber = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      setState(() => _isLoading = true);

      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        print('No user found');
        return;
      }

      // Get profile data from profiles table
      final profileData = await Supabase.instance.client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      if (profileData != null) {
        setState(() {
          _userName =
              '${profileData['first_name']} ${profileData['last_name']}';
          _apartmentNumber = profileData['apartment_number'] ?? '';
          _email = user.email ?? 'Not provided';
          _phoneNumber = profileData['phone_number'] ?? 'Not provided';
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading user profile: $e');
      // If profiles table fails, try to get data from user metadata
      final user = Supabase.instance.client.auth.currentUser;
      if (user != null && user.userMetadata != null) {
        setState(() {
          _userName =
              '${user.userMetadata!['first_name'] ?? ''} ${user.userMetadata!['last_name'] ?? ''}'
                  .trim();
          _apartmentNumber = user.userMetadata!['apartment_number'] ?? '';
          _phoneNumber = user.userMetadata!['phone_number'] ?? 'Not provided';
          _email = user.email ?? 'Not provided';
          _isLoading = false;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _navigateToEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          currentName: _userName,
          currentApartment: _apartmentNumber,
          currentEmail: _email,
          currentPhone: _phoneNumber,
        ),
      ),
    );

    if (result == true) {
      // Reload profile data if changes were made
      _loadUserProfile();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          'https://picsum.photos/seed/resident/200'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      _userName.isNotEmpty ? _userName : 'User',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      _apartmentNumber.isNotEmpty
                          ? 'Apartment $_apartmentNumber'
                          : 'No apartment assigned',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildInfoSection('Contact Information'),
                  _buildInfoItem('Email', _email),
                  _buildInfoItem('Phone', _phoneNumber),
                  const SizedBox(height: 16),
                  _buildInfoSection('Preferences'),
                  _buildToggleItem(
                    'Receive Notifications',
                    true,
                    (value) {
                      // TODO: Implement notification toggle
                    },
                  ),
                  _buildToggleItem(
                    'Email Updates',
                    false,
                    (value) {
                      // TODO: Implement email updates toggle
                    },
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                      ),
                      onPressed: _navigateToEditProfile,
                      child: const Text('Edit Profile'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildToggleItem(String label, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white)),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
