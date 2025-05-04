import 'package:flutter/material.dart';

class PlayerPage extends StatelessWidget {
  final String name;
  final String sport;
  final int score;

  const PlayerPage({
    super.key,
    required this.name,
    required this.sport,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Profile'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage('assets/profile_pic.png'), // Placeholder image
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text("Preferred Sport: $sport", style: TextStyle(color: Colors.grey[700])),
                      const SizedBox(height: 4),
                      Text("🏅 $score points", style: const TextStyle(fontSize: 13)),
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: 24),

            // Bio
            const Text("About Me", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            const Text(
              "Sport lover. Always ready to join a casual or competitive match. Connect with me for your next game!",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 24),

            // Game Stats (fake/sample values)
            const Text("Game Stats", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                _StatCard("Total Matches", "42"),
                _StatCard("Ranked", "27"),
                _StatCard("Casual", "15"),
                _StatCard("Win/Loss", "30 / 12"),
                _StatCard("Current Rank", "Silver I"),
                _StatCard("Most Played", "Soccer"),
              ],
            ),

            const SizedBox(height: 24),

            // Connections
            const Text("Connections", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: const [
                _FriendChip("Alice"),
                _FriendChip("Bob"),
                _FriendChip("Charlie"),
                _FriendChip("Zara"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.green[50],
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 13, color: Colors.green[900])),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _FriendChip extends StatelessWidget {
  final String name;

  const _FriendChip(this.name);

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: CircleAvatar(child: Text(name[0])),
      label: Text(name),
      backgroundColor: Colors.green[100],
    );
  }
}
