import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/find_players_screen.dart';
import 'screens/review_locations_screen.dart';
import 'screens/players_screen.dart';
import 'screens/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sportify',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF8F4FA), // light pastel
        primaryColor: Color(0xFF388E3C),            // green
        appBarTheme: AppBarTheme(
          color: Color(0xFF388E3C),
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
          titleLarge: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    PlayersScreen(),
    ReviewLocationsScreen(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green[500], // Dark green for selected items
        unselectedItemColor: Colors.green[300], // Slightly lighter green for unselected items
        selectedLabelStyle: TextStyle(color: Colors.green[500], fontWeight: FontWeight.bold), // Ensure selected label matches selected item color
        unselectedLabelStyle: TextStyle(color: Colors.green[300]), // Ensure unselected label matches unselected item color
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Players'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Locations'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}