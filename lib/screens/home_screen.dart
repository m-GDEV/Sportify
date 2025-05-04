import 'package:flutter/material.dart';
import 'find_players_screen.dart';
import '../widgets/sport_card.dart';
import '../widgets/leaderboard_card.dart';
import 'filtered_game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  String? selectedSport;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

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
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

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
                'Hey Milind,\nwant to play today?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: sports.map((sport) {
                    final isSelected = selectedSport == sport['name'];
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(12),
                      width: 100,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green[700] : Colors.grey[850],
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.greenAccent.withOpacity(0.4),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                )
                              ]
                            : [],
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedSport = sport['name'];
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(sport['icon'], size: 24, color: Colors.greenAccent),
                            const SizedBox(height: 8),
                            Text(
                              sport['name'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 12),
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
              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Leaderboard',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // updated
                      ),
                    ),
                    const SizedBox(height: 8),
                    LeaderboardCard(players: leaderboardData),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
