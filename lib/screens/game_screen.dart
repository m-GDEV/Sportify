import 'package:flutter/material.dart';

class GamesScreen extends StatelessWidget {
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
    {
      'sport': 'Badminton',
      'time': '4:45 PM',
      'location': 'Sunrise Gymnasium',
      'distance': '1.7 km',
      'rsvpLimit': 4,
      'rsvps': ['Nina', 'Raj', 'Meera']
    },
    {
      'sport': 'Cricket',
      'time': '2:00 PM',
      'location': 'Greenfield Park',
      'distance': '2.6 km',
      'rsvpLimit': 11,
      'rsvps': ['Dev', 'Aryan', 'Anika', 'Farhan', 'Yusuf']
    },
    {
      'sport': 'Volleyball',
      'time': '7:00 PM',
      'location': 'Beachside Court',
      'distance': '0.9 km',
      'rsvpLimit': 6,
      'rsvps': ['Sara', 'Tanya', 'Ishaan']
    },
    {
      'sport': 'Table Tennis',
      'time': '5:30 PM',
      'location': 'Downtown Rec Center',
      'distance': '1.0 km',
      'rsvpLimit': 4,
      'rsvps': ['Leo', 'Zara', 'Kunal', 'Manav']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 12),
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
            centerTitle: false,
            titleSpacing: 16,
            title: const Text(
              'Games Near Me',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white,
                letterSpacing: 0.7,
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: nearbyGames.length,
        itemBuilder: (context, index) {
          final game = nearbyGames[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              border: Border.all(color: Colors.green.shade800),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.greenAccent.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: ListTile(
              title: Text(
                '${game['sport']} • ${game['time']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent,
                ),
              ),
              subtitle: Text(
                '${game['location']} • ${game['distance']}',
                style: const TextStyle(color: Colors.white),
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
      appBar: AppBar(
        title: Text('${game['sport']} Game'),
        backgroundColor: Colors.green[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🕒 ${game['time']}', style: const TextStyle(color: Colors.white, fontSize: 16)),
            Text('📍 ${game['location']}', style: const TextStyle(color: Colors.white, fontSize: 16)),
            Text('📏 ${game['distance']}', style: const TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 20),
            Text(
              'Players Attending (${rsvps.length}/${game['rsvpLimit']})',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: rsvps
                  .map((name) => Chip(
                        avatar: CircleAvatar(child: Text(name[0])),
                        label: Text(name),
                        backgroundColor: Colors.grey[850],
                        labelStyle: const TextStyle(color: Colors.white),
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
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.green[300]!),
                  ),
                  child: Text(
                    isFull ? 'Full' : 'RSVP to this Game',
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
