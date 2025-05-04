import 'package:flutter/material.dart';
import 'package:sportify/util/data_classes.dart';
import 'find_players_screen.dart';
import '../widgets/sport_card.dart';
import '../widgets/leaderboard_card.dart';
import 'filtered_game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedSport;

  final List<Map<String, dynamic>> sports = [
    {'name': 'Soccer', 'icon': Icons.sports_soccer},
    {'name': 'Basketball', 'icon': Icons.sports_basketball},
    {'name': 'Tennis', 'icon': Icons.sports_tennis},
    {'name': 'Cricket', 'icon': Icons.sports_cricket},
    {'name': 'More', 'icon': Icons.more_horiz},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
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
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 10),
                Image.asset(
                  'lib/assets/Sportify_logo.png',
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hey Milind,\n what would you like to play today?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 80,
                child: SizedBox(
                  height: 80,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: sports.map((sport) {
                      final isSelected = selectedSport == sport['name'];
                      return SportCard(
                        name: sport['name'],
                        icon: sport['icon'],
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            selectedSport = sport['name'];
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),

              ),
              const SizedBox(height: 20),
              if (selectedSport != null)
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FilteredGamesScreen(selectedSport: selectedSport!),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 0),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.green[800],
                        border: Border.all(color: Colors.green.shade300),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'Find Games Near You',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              const SizedBox(height: 8),
              LeaderboardCard(players: leaderboardUsers),
            ],
          ),
        ),
      ),
    );
  }


  final List<User> leaderboardUsers = [
  User(
    name: 'Amit',
    location: 'Toronto, ON',
    profileImagePath: 'assets/amit.png',
    bio: 'Enthusiastic soccer player who loves team games and weekly leagues.',
    preferredSports: ['Soccer'],
    stats: {
      'Total Matches': '85',
      'Ranked': '60',
      'Casual': '25',
      'Win/Loss': '50 / 35',
      'Current Rank': 'Platinum I',
      'Most Played': 'Soccer',
      'Last Match': 'May 1 • Won',
    },
    upcomingMatches: [
      MatchInfo(date: 'May 5 • 6:00 PM', description: 'Soccer • High Park', sport: 'Soccer'),
    ],
    recentMatches: [
      MatchInfo(date: 'May 1', description: '🏆 Won • Soccer', sport: 'Soccer'),
    ],
    friends: ['Zara', 'Khalid'],
    score: 1200,
  ),
  User(
    name: 'Leila',
    location: 'Vancouver, BC',
    profileImagePath: 'assets/leila.png',
    bio: 'Loves fast-paced tennis matches and practicing volleys.',
    preferredSports: ['Tennis'],
    stats: {
      'Total Matches': '70',
      'Ranked': '50',
      'Casual': '20',
      'Win/Loss': '40 / 30',
      'Current Rank': 'Gold II',
      'Most Played': 'Tennis',
      'Last Match': 'May 2 • Lost',
    },
    upcomingMatches: [
      MatchInfo(date: 'May 6 • 7:00 PM', description: 'Tennis • Riverdale Courts', sport: 'Tennis'),
    ],
    recentMatches: [
      MatchInfo(date: 'May 2', description: '❌ Lost • Tennis', sport: 'Tennis'),
    ],
    friends: ['Farah', 'Sara'],
    score: 1100,
  ),
  User(
    name: 'Zara',
    location: 'Calgary, AB',
    profileImagePath: 'assets/zara.png',
    bio: 'Basketball lover and team captain with sharp shooting skills.',
    preferredSports: ['Basketball'],
    stats: {
      'Total Matches': '90',
      'Ranked': '55',
      'Casual': '35',
      'Win/Loss': '48 / 42',
      'Current Rank': 'Diamond',
      'Most Played': 'Basketball',
      'Last Match': 'Apr 30 • Won',
    },
    upcomingMatches: [
      MatchInfo(date: 'May 4 • 5:00 PM', description: 'Basketball • YMCA Gym', sport: 'Basketball'),
    ],
    recentMatches: [
      MatchInfo(date: 'Apr 30', description: '🏆 Won • Basketball', sport: 'Basketball'),
    ],
    friends: ['Amit', 'John'],
    score: 1050,
  ),
  User(
    name: 'Khalid',
    location: 'Ottawa, ON',
    profileImagePath: 'assets/khalid.png',
    bio: 'Plays competitive soccer and enjoys weekly pick-up games.',
    preferredSports: ['Soccer'],
    stats: {
      'Total Matches': '68',
      'Ranked': '40',
      'Casual': '28',
      'Win/Loss': '30 / 38',
      'Current Rank': 'Silver',
      'Most Played': 'Soccer',
      'Last Match': 'Apr 29 • Lost',
    },
    upcomingMatches: [],
    recentMatches: [
      MatchInfo(date: 'Apr 29', description: '❌ Lost • Soccer', sport: 'Soccer'),
    ],
    friends: ['Ali', 'Ravi'],
    score: 980,
  ),
  User(
    name: 'Farah',
    location: 'Mississauga, ON',
    profileImagePath: 'assets/farah.png',
    bio: 'Cricket enthusiast and strategic batswoman.',
    preferredSports: ['Cricket'],
    stats: {
      'Total Matches': '55',
      'Ranked': '35',
      'Casual': '20',
      'Win/Loss': '31 / 24',
      'Current Rank': 'Gold I',
      'Most Played': 'Cricket',
      'Last Match': 'Apr 28 • Won',
    },
    upcomingMatches: [],
    recentMatches: [
      MatchInfo(date: 'Apr 28', description: '🏆 Won • Cricket', sport: 'Cricket'),
    ],
    friends: ['Leila', 'Sara'],
    score: 940,
  ),
  User(
    name: 'Ravi',
    location: 'Brampton, ON',
    profileImagePath: 'assets/ravi.png',
    bio: 'Enjoys basketball and building team strategies.',
    preferredSports: ['Basketball'],
    stats: {
      'Total Matches': '50',
      'Ranked': '25',
      'Casual': '25',
      'Win/Loss': '22 / 28',
      'Current Rank': 'Bronze II',
      'Most Played': 'Basketball',
      'Last Match': 'Apr 27 • Lost',
    },
    upcomingMatches: [],
    recentMatches: [
      MatchInfo(date: 'Apr 27', description: '❌ Lost • Basketball', sport: 'Basketball'),
    ],
    friends: ['Khalid'],
    score: 910,
  ),
  User(
    name: 'Sara',
    location: 'Halifax, NS',
    profileImagePath: 'assets/sara.png',
    bio: 'Tennis player who also loves doubles tournaments.',
    preferredSports: ['Tennis'],
    stats: {
      'Total Matches': '65',
      'Ranked': '30',
      'Casual': '35',
      'Win/Loss': '36 / 29',
      'Current Rank': 'Silver II',
      'Most Played': 'Tennis',
      'Last Match': 'Apr 30 • Won',
    },
    upcomingMatches: [],
    recentMatches: [
      MatchInfo(date: 'Apr 30', description: '🏆 Won • Tennis', sport: 'Tennis'),
    ],
    friends: ['Farah', 'Leila'],
    score: 890,
  ),
  User(
    name: 'John',
    location: 'Montreal, QC',
    profileImagePath: 'assets/john.png',
    bio: 'Football fanatic and long-time team player.',
    preferredSports: ['Football'],
    stats: {
      'Total Matches': '73',
      'Ranked': '40',
      'Casual': '33',
      'Win/Loss': '39 / 34',
      'Current Rank': 'Gold II',
      'Most Played': 'Football',
      'Last Match': 'Apr 25 • Won',
    },
    upcomingMatches: [],
    recentMatches: [
      MatchInfo(date: 'Apr 25', description: '🏆 Won • Football', sport: 'Football'),
    ],
    friends: ['Zara'],
    score: 870,
  ),
  User(
    name: 'Tina',
    location: 'London, ON',
    profileImagePath: 'assets/tina.png',
    bio: 'Badminton champion in local leagues.',
    preferredSports: ['Badminton'],
    stats: {
      'Total Matches': '40',
      'Ranked': '20',
      'Casual': '20',
      'Win/Loss': '28 / 12',
      'Current Rank': 'Platinum',
      'Most Played': 'Badminton',
      'Last Match': 'Apr 24 • Won',
    },
    upcomingMatches: [],
    recentMatches: [
      MatchInfo(date: 'Apr 24', description: '🏆 Won • Badminton', sport: 'Badminton'),
    ],
    friends: ['Sara'],
    score: 850,
  ),
  User(
    name: 'Ali',
    location: 'Edmonton, AB',
    profileImagePath: 'assets/ali.png',
    bio: 'Volleyball spiker and fitness enthusiast.',
    preferredSports: ['Volleyball'],
    stats: {
      'Total Matches': '60',
      'Ranked': '38',
      'Casual': '22',
      'Win/Loss': '33 / 27',
      'Current Rank': 'Silver I',
      'Most Played': 'Volleyball',
      'Last Match': 'Apr 23 • Lost',
    },
    upcomingMatches: [],
    recentMatches: [
      MatchInfo(date: 'Apr 23', description: '❌ Lost • Volleyball', sport: 'Volleyball'),
    ],
    friends: ['Khalid'],
    score: 820,
  ),
];

}
