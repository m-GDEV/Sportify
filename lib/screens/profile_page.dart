import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:provider/provider.dart';
import 'package:sportify/util/utils.dart';
import '../main.dart';
import '../util/data_classes.dart';

class ProfilePage extends StatelessWidget {
  final User? player;
  final bool externalPlayer;
  const ProfilePage({super.key, this.player, required this.externalPlayer});

  @override
  Widget build(BuildContext context) {
    var user = player ?? dummyUser;

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
              'My Profile',
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
                  backgroundImage: AssetImage('lib/assets/profile-pic.png'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 4),
                      Text(user.location, style: TextStyle(color: Colors.grey[400])),
                      const SizedBox(height: 4),
                      Text("⚽ 🏀 🏸 Preferred Sports: ${user.preferredSports.join(', ')}",
                          style: const TextStyle(fontSize: 13, color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            const Text("About Me", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 6),
            Text(user.bio, style: TextStyle(color: Colors.grey[300])),

            const SizedBox(height: 20),
            AiSummary(user, context),

            const SizedBox(height: 20),
            const Text("Game Stats", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: user.stats.entries.map((e) => _statCard(e.key, e.value)).toList(),
            ),

            Matches(user, externalPlayer),

            const SizedBox(height: 24),
            const Text("Connections", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: user.friends.map((name) => _friendChip(name)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String value, [double width = 160, bool markdown = false]) {
    Widget content;
    if (markdown) {
      content = MarkdownBody(data: value, styleSheet: MarkdownStyleSheet(p: const TextStyle(color: Colors.white, fontSize: 14)));
    } else {
      content = Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white));
    }

    return Container(
      width: width != 160 ? double.infinity : width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF1E1E1E),
        border: Border.all(color: Colors.green.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.greenAccent.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 13, color: Colors.greenAccent)),
          const SizedBox(height: 4),
          content,
        ],
      ),
    );
  }

  Widget _matchTile(String date, String description, String sport) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        border: Border.all(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(_getSportIcon(sport), color: Colors.greenAccent),
        title: Text(description, style: const TextStyle(color: Colors.white)),
        subtitle: Text(date, style: const TextStyle(color: Colors.grey)),
      ),
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
      case 'badminton':
        return Icons.sports_tennis;
      case 'cricket':
        return Icons.sports_cricket;
      default:
        return Icons.sports;
    }
  }

  Widget _friendChip(String name) {
    return Chip(
      avatar: CircleAvatar(
        backgroundColor: Colors.green[700],
        child: Text(name[0], style: const TextStyle(color: Colors.white)),
      ),
      label: Text(name, style: const TextStyle(color: Colors.white)),
      backgroundColor: const Color(0xFF1E1E1E),
      shape: StadiumBorder(side: BorderSide(color: Colors.green.shade300)),
    );
  }

  Widget Matches(User user, bool enabled) {
    if (!enabled) return const SizedBox.shrink();
    return Column(children: [
      const SizedBox(height: 24),
      const Text("Upcoming Matches", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
      const SizedBox(height: 8),
      ...user.upcomingMatches.map((m) => _matchTile(m.date, m.description, m.sport)),

      const SizedBox(height: 24),
      const Text("Recent Matches", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
      const SizedBox(height: 8),
      ...user.recentMatches.map((m) => _matchTile(m.date, m.description, m.sport)),
    ]);
  }

  Widget AiSummary(User user, BuildContext context) {
    final dummyUserInfo = dummyUser.toString();
    final actualUserInfo = user.toString();

    final internalPrompt = "Generate a summary of the user profile based on the following information. Write it like you are addressing the user yourself. for example, (you are a very good basketball player)...\n$actualUserInfo";
    final externalPrompt = "Generate a summary of the head-to-head comparison between the first user and the second user...\nuser 1: $dummyUserInfo\nuser 2: $actualUserInfo";
    final prompt = externalPlayer ? externalPrompt : internalPrompt;
    final title = externalPlayer ? "✨ AI Head-to-Head Insights" : "✨ AI Generated Summary";

    return FutureBuilder<String>(
      future: generateSummary(context, prompt),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Center(child: CircularProgressIndicator(color: Colors.greenAccent)),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.redAccent));
        } else {
          return _statCard(title, snapshot.data ?? "No summary generated.", 170, true);
        }
      },
    );
  }
}
