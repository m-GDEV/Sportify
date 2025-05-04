import 'package:flutter/material.dart';

class LeaderboardCard extends StatelessWidget {
  final List<Map<String, dynamic>> players;

  const LeaderboardCard({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Leaderboard",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...players.asMap().entries.map((entry) {
          final index = entry.key;
          final player = entry.value;
          return _LeaderboardEntry(
            rank: index + 1,
            name: player['name'],
            score: player['score'],
            sport: player['sport'],
          );
        }).toList(),
      ],
    );
  }
}

class _LeaderboardEntry extends StatelessWidget {
  final int rank;
  final String name;
  final int score;
  final String sport;

  const _LeaderboardEntry({
    required this.rank,
    required this.name,
    required this.score,
    required this.sport,
  });

  Widget _medalIcon(int rank) {
    switch (rank) {
      case 1:
        return const Icon(Icons.emoji_events, size: 36, color: Color.fromARGB(255, 255, 213, 0));
      case 2:
        return const Padding(
          padding: EdgeInsets.only(left: 4.0), // reduce from 8 or more
          child: Icon(
            Icons.emoji_events,
            size: 32,
            color: Color(0xFFC0C0C0), // gold
          ),
        );
      case 3:
        return const Padding(
          padding: EdgeInsets.only(left: 4.0), // reduce from 8 or more
          child: Icon(
            Icons.emoji_events,
            size: 32,
            color: Color(0xFFCD7F32), // gold
          ),
        );
      default:
        return Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(Icons.circle, size: 8, color: Colors.grey[400]),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool showRankNumber = rank > 3;

    return Container(
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade100),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          showRankNumber
              ? Text(
                  '  #$rank ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              : _medalIcon(rank),
          const SizedBox(width: 4),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Top Sport: $sport',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          Text(
            '$score ',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          Icon(Icons.stars, color: Colors.green[900], size: 20),
        ],
      ),
    );
  }
}

