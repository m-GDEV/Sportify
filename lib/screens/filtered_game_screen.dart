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
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = nearbyGames
        .where((game) => game['sport'].toLowerCase() == selectedSport.toLowerCase())
        .toList();

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
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              'Nearby $selectedSport Games',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
      body: filtered.isEmpty
          ? const Center(
              child: Text(
                'No games found for this sport.',
                style: TextStyle(color: Colors.white70),
              ),
            )
          : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final game = filtered[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    border: Border.all(color: Colors.green.shade800),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    title: Text(
                      '${game['sport']} • ${game['time']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      '${game['location']} • ${game['distance']}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: Text(
                      '${game['rsvps'].length}/${game['rsvpLimit']}',
                      style: const TextStyle(color: Colors.white),
                    ),
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
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              '${game['sport']} Game',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🕒 ${game['time']}', style: const TextStyle(fontSize: 16, color: Colors.white)),
            Text('📍 ${game['location']}', style: const TextStyle(fontSize: 16, color: Colors.white)),
            Text('📏 ${game['distance']}', style: const TextStyle(fontSize: 16, color: Colors.white)),
            const SizedBox(height: 20),
            Text(
              'Players Attending (${rsvps.length}/${game['rsvpLimit']})',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: rsvps.map((name) => Chip(
                avatar: CircleAvatar(child: Text(name[0])),
                label: Text(name),
                backgroundColor: Colors.green[100],
              )).toList(),
            ),
            const Spacer(),
            Center(
              child: GestureDetector(
                onTap: isFull ? null : _handleRSVP,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(
                    color: isFull ? Colors.grey[800] : Colors.green,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.green[100]!),
                  ),
                  child: Text(
                    isFull ? 'Full' : 'RSVP to this Game',
                    style: TextStyle(
                      color: isFull ? Colors.white : Colors.white,
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
