import 'package:flutter/material.dart';

class FilteredGamesScreen extends StatelessWidget {
  final String selectedSport;

  FilteredGamesScreen({Key? key, required this.selectedSport}) : super(key: key);


  final List<Map<String, dynamic>> nearbyGames = [
    {
      'sport': 'Basketball',
      'time': '3:30 PM',
      'location': 'City Sports Complex',
      'distance': '1.2 km',
      'rsvpLimit': 6,
      'rsvps': ['Arjun', 'Leila', 'Dev', 'Sofia', 'Raj']
    },
    {
      'sport': 'Tennis',
      'time': '5:00 PM',
      'location': 'West Park Field',
      'distance': '0.8 km',
      'rsvpLimit': 4,
      'rsvps': ['Marcus', 'Anika', 'Zara']
    },
    {
      'sport': 'Soccer',
      'time': '6:15 PM',
      'location': 'Arena 21',
      'distance': '2.1 km',
      'rsvpLimit': 10,
      'rsvps': ['Arjun', 'Leila', 'Marcus', 'Nina', 'Leo', 'Aryan']
    },
    // ... Add more if needed
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = nearbyGames
        .where((game) => game['sport'].toLowerCase() == selectedSport.toLowerCase())
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby $selectedSport Games'),
        backgroundColor: Colors.green[700],
      ),
      body: filtered.isEmpty
          ? const Center(child: Text('No games found for this sport.'))
          : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final game = filtered[index];
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
                    subtitle: Text('${game['location']} • ${game['distance']}'),
                    trailing: Text('${game['rsvps'].length}/${game['rsvpLimit']}'),
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

class GameDetailScreen extends StatefulWidget {
  final Map<String, dynamic> game;

  const GameDetailScreen({Key? key, required this.game}) : super(key: key);

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  late List<String> rsvps;

  @override
  void initState() {
    super.initState();
    rsvps = List<String>.from(widget.game['rsvps']);
  }

  void _handleRSVP() {
    if (rsvps.length >= widget.game['rsvpLimit']) return;

    setState(() {
      rsvps.add('You');
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('RSVP confirmed!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final game = widget.game;
    final isFull = rsvps.length >= game['rsvpLimit'];

    return Scaffold(
      appBar: AppBar(title: Text('${game['sport']} Game')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🕒 ${game['time']}', style: const TextStyle(fontSize: 16)),
            Text('📍 ${game['location']}', style: const TextStyle(fontSize: 16)),
            Text('📏 ${game['distance']}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Text('Players Attending (${rsvps.length}/${game['rsvpLimit']})',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: rsvps
                  .map((name) => Chip(
                        avatar: CircleAvatar(child: Text(name[0])),
                        label: Text(name),
                        backgroundColor: Colors.green[100],
                      ))
                  .toList(),
            ),
            const Spacer(),
            Center(
            child: GestureDetector(
              onTap: isFull ? null : _handleRSVP,
              child: Container(
                margin: const EdgeInsets.only(top: 0),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.green[100]!),
                ),
                child: Text(
                  isFull ? 'Full' : 'RSVP to this Game',
                  style: TextStyle(
                    color: Colors.green[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),

          ],
        ),
      ),
    );
  }
}
