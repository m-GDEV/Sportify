import 'package:flutter/material.dart';
import 'package:sportify/screens/profile_page.dart';
import '../screens/player_page.dart';
import '../util/data_classes.dart';

class LeaderboardCard extends StatelessWidget {
  final List<User> players;

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
            player: player,
            rank: index + 1,
          );
        }).toList(),
      ],
    );
  }
}

class _LeaderboardEntry extends StatelessWidget {
  final User player;
  final int rank;

  const _LeaderboardEntry({
    required this.player,
    required this.rank,
  });

  Widget _medalIcon(int rank) {
    switch (rank) {
      case 1:
        return const Icon(Icons.emoji_events, color: Color(0xFFFFD700), size: 32);
      case 2:
        return const Icon(Icons.emoji_events, color: Color(0xFFC0C0C0), size: 32);
      case 3:
        return const Icon(Icons.emoji_events, color: Color(0xFFCD7F32), size: 32);
      default:
        return Padding(
          padding: EdgeInsets.only(left: rank == 10 ? 0 : 4),
          child: Icon(Icons.circle, size: 8, color: Colors.grey[400]),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool showRankNumber = rank > 3;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(
              player: player, externalPlayer: true,
            ),
          ),
        );
      },
      child: Container(
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
                ? Padding(
                    padding: EdgeInsets.only(left: rank == 10 ? 0 : 4),
                    child: Text(
                      '#$rank',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  )
                : _medalIcon(rank),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    player.preferredSports[0],
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${player.score} ',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Icon(
              Icons.stars_rounded,
              color: Colors.green,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}