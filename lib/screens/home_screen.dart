import 'package:flutter/material.dart';
import 'find_players_screen.dart';
import '../widgets/sport_card.dart';


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
      appBar: AppBar(title: const Text('Sportify')),
      body: Padding(
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
            Center(
              child: ElevatedButton(
                onPressed: selectedSport != null
                    ? () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FindPlayersScreen(
                                selectedSport: selectedSport!,
                                ),
                            ),
                        );
                      }
                    : null,
                child: const Text('Find Players'),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
