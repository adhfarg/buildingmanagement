import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Building Features'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildFeatureButton(
            context,
            'Gym',
            'State-of-the-art equipment available 24/7',
            Icons.fitness_center,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GymScreen()),
            ),
          ),
          const SizedBox(height: 12),
          _buildFeatureButton(
            context,
            'Pool',
            'Olympic-sized pool open from 6 AM to 10 PM',
            Icons.pool,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PoolScreen()),
            ),
          ),
          const SizedBox(height: 12),
          _buildFeatureButton(
            context,
            'Rooftop Garden',
            'Relax and enjoy the view from our beautiful rooftop garden',
            Icons.local_florist,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RooftopGardenScreen()),
            ),
          ),
          const SizedBox(height: 12),
          _buildFeatureButton(
            context,
            'Community Room',
            'Host events or gatherings in our spacious community room',
            Icons.people,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CommunityRoomScreen()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureButton(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      color: Colors.grey[900],
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(icon, size: 32, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.white,
        ),
      ),
    );
  }
}

// Gym Screen
class GymScreen extends StatelessWidget {
  const GymScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gym'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Image.network(
            'https://i.pravatar.cc/400?img=1', // Replace with actual gym image
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          const Text(
            'State-of-the-art Fitness Center',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Open 24/7',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoSection('Equipment', [
            'Cardio machines (treadmills, bikes, ellipticals)',
            'Free weights and weight machines',
            'Yoga and stretching area',
            'Personal training available',
          ]),
          const SizedBox(height: 16),
          _buildInfoSection('Rules & Guidelines', [
            'Please wipe down equipment after use',
            'Proper athletic attire required',
            'Return weights to their designated spots',
            'Be mindful of time limits during peak hours',
          ]),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.circle, size: 8),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item)),
                ],
              ),
            )),
      ],
    );
  }
}

// Pool Screen
class PoolScreen extends StatelessWidget {
  const PoolScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pool'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Image.network(
            'https://i.pravatar.cc/400?img=2', // Replace with actual pool image
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          const Text(
            'Olympic-sized Swimming Pool',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Open 6 AM to 10 PM',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoSection('Features', [
            'Olympic-sized lap pool',
            'Heated water year-round',
            'Dedicated lanes for lap swimming',
            'Pool-side lounging area',
          ]),
          const SizedBox(height: 16),
          _buildInfoSection('Rules & Guidelines', [
            'Shower before entering the pool',
            'Proper swimming attire required',
            'No diving in shallow areas',
            'Children under 12 must be supervised',
          ]),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.circle, size: 8),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item)),
                ],
              ),
            )),
      ],
    );
  }
}

// Rooftop Garden Screen
class RooftopGardenScreen extends StatelessWidget {
  const RooftopGardenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rooftop Garden'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Image.network(
            'https://i.pravatar.cc/400?img=3', // Replace with actual garden image
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          const Text(
            'Rooftop Garden Oasis',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Open Daily',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoSection('Amenities', [
            'Comfortable seating areas',
            'Beautiful landscaping',
            'Panoramic city views',
            'BBQ grills available',
          ]),
          const SizedBox(height: 16),
          _buildInfoSection('Guidelines', [
            'Please maintain cleanliness',
            'No loud music after 10 PM',
            'Reserve BBQ grills in advance',
            'Respect plant life and garden areas',
          ]),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.circle, size: 8),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item)),
                ],
              ),
            )),
      ],
    );
  }
}

// Community Room Screen
class CommunityRoomScreen extends StatelessWidget {
  const CommunityRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Room'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Image.network(
            'https://i.pravatar.cc/400?img=4', // Replace with actual room image
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          const Text(
            'Community Room',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Available for Reservations',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoSection('Features', [
            'Spacious gathering area',
            'Full kitchen facilities',
            'Audio/visual equipment',
            'Flexible seating arrangements',
          ]),
          const SizedBox(height: 16),
          _buildInfoSection('Reservation Guidelines', [
            'Book at least 48 hours in advance',
            'Maximum capacity: 50 people',
            'Clean up after your event',
            'Security deposit required',
          ]),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.circle, size: 8),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item)),
                ],
              ),
            )),
      ],
    );
  }
}
