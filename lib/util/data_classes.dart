class User {
  final String name;
  final String location;
  final String profileImagePath;
  final String bio;
  final List<String> preferredSports;
  final Map<String, String> stats;
  final List<MatchInfo> upcomingMatches;
  final List<MatchInfo> recentMatches;
  final List<String> friends;
  final int score; // Placeholder for score, can be updated later

  User({
    required this.name,
    required this.location,
    required this.profileImagePath,
    required this.bio,
    required this.preferredSports,
    required this.stats,
    required this.upcomingMatches,
    required this.recentMatches,
    required this.friends,
    required this.score,
  });

  @override
  String toString() {
    return '''
  User Profile:
  -------------
  Name: $name
  Location: $location
  Preferred Sports: ${preferredSports.join(', ')}
  Bio: $bio

  Game Stats:
  ${stats.entries.map((e) => '  ${e.key}: ${e.value}').join('\n')}

  Upcoming Matches:
  ${upcomingMatches.map((m) => '  ${m.date} - ${m.description} (${m.sport})').join('\n')}

  Recent Matches:
  ${recentMatches.map((m) => '  ${m.date} - ${m.description} (${m.sport})').join('\n')}

  Connections:
  ${friends.join(', ')}

  Total Score: 
  ${score} points across all sports
  ''';
  }

}

class MatchInfo {
  final String date;
  final String description;
  final String sport;

  MatchInfo({required this.date, required this.description, required this.sport});
}

final dummyUser = User(
  name: "Le Goat James",
  location: "Toronto, ON",
  profileImagePath: "profile_pic.jpg",
  bio: "Passionate about sports and always up for a match. Looking for partners to play ranked or casual games regularly.",
  preferredSports: ["Football", "Basketball", "Badminton"],
  stats: {
    "Total Matches": "58",
    "Ranked": "35",
    "Casual": "23",
    "Win/Loss": "34 / 24",
    "Current Rank": "Gold II",
    "Most Played": "Football",
    "Last Match": "Apr 30 • Won",
  },
  upcomingMatches: [
    MatchInfo(date: "Sat, May 4 • 5:00 PM", description: "Basketball • Community Center", sport: "Basketball"),
    MatchInfo(date: "Mon, May 6 • 6:30 PM", description: "Football • Sports Arena", sport: "Football"),
  ],
  recentMatches: [
    MatchInfo(date: "Apr 30", description: "🏆 Won • Football", sport: "Football"),
    MatchInfo(date: "Apr 28", description: "❌ Lost • Badminton", sport: "Badminton"),
    MatchInfo(date: "Apr 26", description: "🏆 Won • Basketball", sport: "Basketball"),
  ],
  friends: ["Alice", "Bob", "Charlie", "Zara"],
  score: 1200
);
