import 'package:flutter/material.dart';
import 'find_players_screen.dart';
import '../widgets/sport_card.dart';
import '../widgets/leaderboard_card.dart';

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

  final leaderboardData = [
    {'name': 'Amit', 'score': 1200, 'sport': 'Soccer'},
    {'name': 'Leila', 'score': 1100, 'sport': 'Tennis'},
    {'name': 'Zara', 'score': 1050, 'sport': 'Basketball'},
    {'name': 'Khalid', 'score': 980, 'sport': 'Soccer'},
    {'name': 'Farah', 'score': 940, 'sport': 'Cricket'},
    {'name': 'Ravi', 'score': 910, 'sport': 'Basketball'},
    {'name': 'Sara', 'score': 890, 'sport': 'Tennis'},
    {'name': 'John', 'score': 870, 'sport': 'Football'},
    {'name': 'Tina', 'score': 850, 'sport': 'Badminton'},
    {'name': 'Ali', 'score': 820, 'sport': 'Volleyball'},
  ];

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
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 10),
                Image.asset(
                  'lib/assets/Sportify_logo.png',
                  height: 40,
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
                'Hey Milind,\nwant to play today?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: sports.map((sport) {
                    return SportCard(
                      name: sport['name'],
                      icon: sport['icon'],
                      isSelected: selectedSport == sport['name'],
                      onTap: () {
                        setState(() {
                          selectedSport = sport['name'];
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              LeaderboardCard(players: leaderboardData),
            ],
          ),
        ),
      ),
    );
  }
}
