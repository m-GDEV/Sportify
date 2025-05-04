import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 12),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFA8E6A2),
                Color(0xFF6FCF97),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            titleSpacing: 16,
            title: Row(
              children: const [
                SizedBox(width: 10),
                Text(
                  'Player Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture + Basic Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage('assets/profile_pic.png'), // replace with real image
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("John Doe", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text("Toronto, ON", style: TextStyle(color: Colors.grey[700])),
                      SizedBox(height: 4),
                      Text("⚽ 🏀 🏸 Preferred Sports: Football, Basketball, Badminton", style: TextStyle(fontSize: 13)),
                    ],
                  ),
                )
              ],
            ),

            SizedBox(height: 16),

            // Bio
            Text("About Me", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 6),
            Text(
              "Passionate about sports and always up for a match. Looking for partners to play ranked or casual games regularly.",
              style: TextStyle(color: Colors.grey[800]),
            ),

            SizedBox(height: 20),

            // Stats Grid
            Text("Game Stats", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _statCard("Total Matches", "58"),
                _statCard("Ranked", "35"),
                _statCard("Casual", "23"),
                _statCard("Win/Loss", "34 / 24"),
                _statCard("Current Rank", "Gold II"),
                _statCard("Most Played", "Football"),
                _statCard("Last Match", "Apr 30 • Won"),
              ],
            ),

            SizedBox(height: 24),

            // Upcoming Matches
            Text("Upcoming Matches", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            _matchTile("Sat, May 4 • 5:00 PM", "Basketball • Community Center", "Basketball"),
            _matchTile("Mon, May 6 • 6:30 PM", "Football • Sports Arena", "Football"),

            // Recent Matches
            SizedBox(height: 24),
            Text("Recent Matches", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            _matchTile("Apr 30", "🏆 Won • Football", "Football"),
            _matchTile("Apr 28", "❌ Lost • Badminton", "Badminton"),
            _matchTile("Apr 26", "🏆 Won • Basketball", "Basketball"),

            SizedBox(height: 24),

            // Friends
            Text("Connections", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                _friendChip("Alice"),
                _friendChip("Bob"),
                _friendChip("Charlie"),
                _friendChip("Zara"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String value) {
    return Container(
      width: 160,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.green[50],
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 13, color: Colors.green[900])),
          SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _matchTile(String date, String description, String sport) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(_getSportIcon(sport), color: Colors.green[700]),
      title: Text(description),
      subtitle: Text(date),
    );
  }

  IconData _getSportIcon(String sport) {
    switch (sport.toLowerCase()) {
      case 'football':
      case 'soccer':
        return Icons.sports_soccer;
      case 'basketball':
        return Icons.sports_basketball;
      case 'tennis':
        return Icons.sports_tennis;
      case 'badminton':
        return Icons.sports_tennis; // placeholder
      case 'cricket':
        return Icons.sports_cricket;
      default:
        return Icons.sports;
    }
  }

  Widget _friendChip(String name) {
    return Chip(
      avatar: CircleAvatar(child: Text(name[0])),
      label: Text(name),
      backgroundColor: Colors.green[100],
    );
  }
}
