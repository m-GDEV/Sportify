import 'package:flutter/material.dart';
import 'chat_detail_screen.dart';

class ChatsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> chats = [
    {
      'name': 'Leila',
      'lastMessage': 'Hey! You playing today?',
      'time': '2:45 PM',
      'unread': true
    },
    {
      'name': 'Amit',
      'lastMessage': 'Nice game yesterday!',
      'time': '1:10 PM',
      'unread': false
    },
    {
      'name': 'Farah',
      'lastMessage': 'Let’s plan for the weekend!',
      'time': '11:02 AM',
      'unread': true
    },
    {
      'name': 'Khalid',
      'lastMessage': 'GGs!',
      'time': 'Mon',
      'unread': false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1B5E20), Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'Chats',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () {
                // Navigate to AI chat screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('AI Chat not implemented yet')),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.green[800],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.auto_awesome, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Chat with AI',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...chats.map((chat) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green.shade800.withOpacity(0.2)),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green[700],
                  child: Text(chat['name'][0], style: const TextStyle(color: Colors.white)),
                ),
                title: Text(chat['name'],
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text(chat['lastMessage'],
                    style: TextStyle(
                        color: chat['unread'] ? Colors.greenAccent : Colors.grey[400])),
                trailing: Text(chat['time'], style: const TextStyle(color: Colors.grey)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatDetailScreen(name: chat['name']),
                    ),
                  );
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

}
