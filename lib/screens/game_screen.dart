import 'package:flutter/material.dart';

class GamesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> nearbyGames = [
    {
      'sport': 'Basketball',
      'time': '3:30 PM',
      'location': 'City Sports Complex',
      'rsvps': ['Arjun', 'Leila']
    },
    {
      'sport': 'Tennis',
      'time': '5:00 PM',
      'location': 'West Park Field',
      'rsvps': ['Marcus']
    },
    {
      'sport': 'Soccer',
      'time': '6:15 PM',
      'location': 'Arena 21',
      'rsvps': ['Arjun', 'Leila', 'Marcus']
    },
    {
      'sport': 'Badminton',
      'time': '4:45 PM',
      'location': 'Sunrise Gymnasium',
      'rsvps': ['Nina', 'Raj']
    },
    {
      'sport': 'Cricket',
      'time': '2:00 PM',
      'location': 'Greenfield Park',
      'rsvps': ['Dev', 'Aryan', 'Anika']
    },
    {
      'sport': 'Volleyball',
      'time': '7:00 PM',
      'location': 'Beachside Court',
      'rsvps': ['Sara']
    },
    {
      'sport': 'Table Tennis',
      'time': '5:30 PM',
      'location': 'Downtown Rec Center',
      'rsvps': ['Leo', 'Zara']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Games Near Me')),
      body: ListView.builder(
        itemCount: nearbyGames.length,
        itemBuilder: (context, index) {
          final game = nearbyGames[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green[50],
              border: Border.all(color: Colors.green.shade100),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              title: Text(
                '${game['sport']} • ${game['time']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(game['location']),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GameDetailScreen(game: game),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class GameDetailScreen extends StatelessWidget {
  final Map<String, dynamic> game;

  const GameDetailScreen({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> rsvps = List<String>.from(game['rsvps']);

    return Scaffold(
      appBar: AppBar(title: Text('${game['sport']} Game')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🕒 Time: ${game['time']}', style: TextStyle(fontSize: 16)),
            Text('📍 Location: ${game['location']}', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Text('Players Attending', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...rsvps.map((name) => Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade100),
              ),
              child: Row(
                children: [
                  CircleAvatar(child: Text(name[0])),
                  const SizedBox(width: 12),
                  Text(name, style: TextStyle(fontSize: 16)),
                ],
              ),
            )),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // RSVP logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('RSVP confirmed!')),
                  );
                },
                child: const Text('RSVP to this Game'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
