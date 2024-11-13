import 'package:flutter/material.dart';
import '../widgets/custom_navigation_drawer.dart';
import '../widgets/bottom_home_button.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

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
                'Messages',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildMessageItem(
                'Property Manager',
                'Thank you for your prompt response regarding...',
                'https://picsum.photos/seed/PropManager/200',
              ),
              _buildMessageItem(
                'Maintenance Team',
                'We\'ve scheduled the repair for your unit on...',
                'https://picsum.photos/seed/Maintenance/200',
              ),
              _buildMessageItem(
                'John from 4B',
                'Hey neighbor! I was wondering if you could...',
                'https://picsum.photos/seed/John4B/200',
              ),
            ],
          ),
          const BottomHomeButton(),
        ],
      ),
    );
  }

  Widget _buildMessageItem(String sender, String preview, String avatarUrl) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(avatarUrl),
        ),
        title:
            Text(sender, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          preview,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // TODO: Navigate to message details
        },
      ),
    );
  }
}
