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
    var user = player;
    if (user == null) {
      user = dummyUser;
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFA8E6A2), Color(0xFF6FCF97)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            titleSpacing: 16,
            title: const Row(
              children: [
                SizedBox(width: 10),
                Text(
                  'My Profile',
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
                  backgroundImage: AssetImage('assets/profile-pic.jpg'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(user.location, style: TextStyle(color: Colors.grey[700])),
                      const SizedBox(height: 4),
                      Text("⚽ 🏀 🏸 Preferred Sports: ${user.preferredSports.join(', ')}",
                          style: const TextStyle(fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            const Text("About Me", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(user.bio, style: TextStyle(color: Colors.grey[800])),

            const SizedBox(height: 20),
            // const Text("✨ AI Generated Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),

            AiSummary(user, context),

            const SizedBox(height: 20),
            const Text("Game Stats", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: user.stats.entries.map((e) => _statCard(e.key, e.value)).toList(),
            ),

            Matches(user, externalPlayer),

            const SizedBox(height: 24),
            const Text("Connections", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: user.friends.map((name) => _friendChip(name)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String value, [double width = 160, bool markdown = false]) {
    Widget content;
    if (markdown)
      content = MarkdownBody(data: value, styleSheet: MarkdownStyleSheet(textScaleFactor: 1.2));
    else {
      content = Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
    }
    
    return Container(
      width: width != 160 ? double.infinity : width,
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
          content
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
        return Icons.sports_tennis;
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

  Widget Matches(User user, bool enabled) {
    if (enabled) {
  return Column(children: [
            const SizedBox(height: 24),
            const Text("Upcoming Matches", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            ...user.upcomingMatches.map((m) => _matchTile(m.date, m.description, m.sport)),

            const SizedBox(height: 24),
            const Text("Recent Matches", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            ...user.recentMatches.map((m) => _matchTile(m.date, m.description, m.sport)),
    ],);

    }
    else {
      return Column();
    }

  } 

  Widget AiSummary(User user, BuildContext context) {

    final dummyUserInfo = dummyUser.toString();
    final actualUserInfo = user.toString();

    // when the actual user is looking at their profile
    final internalPrompt = "Generate a summary of the user profile based on the following information. Write it like you are addressing the user yourself. for example, (you are a very good basketball player). additionally mention what their biggest strengths and weaknesses are. also metnion what they might sport they might like to try if they haven't tried it yet. mention their closest friends. write in a fun manner and keep it light :) Make sure to use markdown formatting. :\n$actualUserInfo";
    // when the actual user is looking at someone else's profile
    final externalPrompt = "Generate a summary of the head-to-head comparison between the first user and the second user. Address the first user as 'you' and the second user by name. additionally mention what their biggest strengths and weaknesses are in relation to each other. mention how they can work together and how they might compete against one another. write in a fun manner and keep it light :):\n user 1: $dummyUserInfo\n user 2: $actualUserInfo";
    final prompt = externalPlayer ? externalPrompt : internalPrompt;
    final title = externalPlayer ? "✨ AI Head-to-Head Insights": "✨ AI Generated Summary";

    return FutureBuilder<String>(
      future: generateSummary(context, prompt),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return _statCard(title, snapshot.data ?? "No summary generated.", 170, true);
        }
      },
    );
  }
}