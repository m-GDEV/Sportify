import 'package:flutter/material.dart';
import '../widgets/player_tile.dart';

class PlayersScreen extends StatelessWidget {
  final List<Map<String, dynamic>> nearbyPlayers = [
    {
      'name': 'Arjun',
      'sport': 'Basketball',
      'time': '3:30 PM',
      'rating': 4.6,
      'distance': 1.2
    },
    {
      'name': 'Leila',
      'sport': 'Tennis',
      'time': '5:00 PM',
      'rating': 4.2,
      'distance': 2.5
    },
    {
      'name': 'Marcus',
      'sport': 'Soccer',
      'time': '6:15 PM',
      'rating': 4.9,
      'distance': 3.1
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Players Near Me'),
      ),
      body: ListView.builder(
        itemCount: nearbyPlayers.length,
        itemBuilder: (context, index) {
          final player = nearbyPlayers[index];
          return PlayerTile(
            name: player['name'],
            sport: player['sport'],
            time: player['time'],
            rating: player['rating'],
            distance: player['distance'],
          );
        },
      ),
    );
  }
}
