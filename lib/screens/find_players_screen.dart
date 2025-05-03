import 'package:flutter/material.dart';
import '../widgets/player_tile.dart';

class FindPlayersScreen extends StatelessWidget {
  final String selectedSport;

  const FindPlayersScreen({Key? key, required this.selectedSport}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy player list
    final List<Map<String, dynamic>> players = [
      {'name': 'Amit', 'sport': 'Soccer', 'time': '4:00 PM', 'rating': 4.5},
      {'name': 'Sanjay', 'sport': 'Tennis', 'time': '6:30 PM', 'rating': 4.8},
      {'name': 'Rina', 'sport': 'Soccer', 'time': '5:15 PM', 'rating': 4.1},
      {'name': 'Farah', 'sport': 'Basketball', 'time': '7:00 PM', 'rating': 3.9},
    ];

    // Filter players by selected sport
    final filtered = players.where((p) => p['sport'] == selectedSport).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Players for $selectedSport')),
      body: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final player = filtered[index];
          return PlayerTile(
            name: player['name'],
            sport: player['sport'],
            time: player['time'],
            rating: player['rating'],
          );

        },
      ),
    );
  }
}
