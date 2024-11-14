import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyContactsScreen extends StatelessWidget {
  const EmergencyContactsScreen({Key? key}) : super(key: key);

  Future<void> _makeCall(String number) async {
    final Uri url = Uri.parse('tel:$number');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Contacts'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Colors.red[900],
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'In case of emergency',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'For life-threatening emergencies, always call 911 first.',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildContactSection(
            'Building Emergency',
            [
              Contact('Building Security', '555-0100'),
              Contact('Property Manager', '555-0101'),
              Contact('Maintenance Emergency', '555-0102'),
            ],
          ),
          _buildContactSection(
            'Utility Emergency',
            [
              Contact('Electric Company', '555-0200'),
              Contact('Gas Company', '555-0201'),
              Contact('Water Company', '555-0202'),
            ],
          ),
          _buildContactSection(
            'Medical Services',
            [
              Contact('Nearest Hospital', '555-0300'),
              Contact('Poison Control', '555-0301'),
              Contact('24/7 Nurse Line', '555-0302'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(String title, List<Contact> contacts) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            ...contacts.map((contact) => _buildContactTile(contact)),
          ],
        ),
      ),
    );
  }

  Widget _buildContactTile(Contact contact) {
    return ListTile(
      title: Text(
        contact.name,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        contact.number,
        style: TextStyle(color: Colors.grey[400]),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.phone),
        onPressed: () => _makeCall(contact.number),
      ),
    );
  }
}

class Contact {
  final String name;
  final String number;

  const Contact(this.name, this.number);
}
