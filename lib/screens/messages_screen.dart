import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_navigation_drawer.dart';
import '../widgets/bottom_home_button.dart';
import '../models/message_model.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _recipientController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _recipientController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _showNewMessageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.grey[900],
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'New Message',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _recipientController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Recipient',
                  labelStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.person, color: Colors.grey[400]),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[700]!),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _messageController,
                style: const TextStyle(color: Colors.white),
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Message',
                  labelStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.message, color: Colors.grey[400]),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[700]!),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _recipientController.clear();
                      _messageController.clear();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (_recipientController.text.isNotEmpty &&
                          _messageController.text.isNotEmpty) {
                        context.read<MessageModel>().addMessage(
                              Message(
                                sender: _recipientController.text,
                                preview: _messageController.text,
                                avatarUrl:
                                    'https://picsum.photos/seed/${_recipientController.text}/200',
                              ),
                            );
                        _recipientController.clear();
                        _messageController.clear();
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Send'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showNewMessageDialog(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: const CustomNavigationDrawer(),
      body: Stack(
        children: [
          Consumer<MessageModel>(
            builder: (context, messageModel, child) => ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
              children: [
                const Text(
                  'Messages',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ...messageModel.messages.map((message) => _buildMessageItem(
                      message.sender,
                      message.preview,
                      message.avatarUrl,
                    )),
              ],
            ),
          ),
          const BottomHomeButton(),
        ],
      ),
    );
  }

  Widget _buildMessageItem(String sender, String preview, String avatarUrl) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.grey[900],
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(avatarUrl),
        ),
        title: Text(
          sender,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          preview,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.grey[400]),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
        onTap: () {
          // TODO: Navigate to message details
        },
      ),
    );
  }
}
