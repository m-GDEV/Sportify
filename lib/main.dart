import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:sportify/screens/create_account_screen.dart';
import 'package:sportify/screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/find_players_screen.dart';
import 'screens/review_locations_screen.dart';
import 'screens/game_screen.dart';
import 'screens/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'util/api_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sportify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Outfit',
      ),
      home: const MainNavigation(),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: 'tspmo');
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
    GamesScreen(),
    ReviewLocationsScreen(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    BottomNavigationBar? bottomNavBar;
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      bottomNavBar = BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green[500], // Dark green for selected items
        unselectedItemColor: Colors.green[300], // Slightly lighter green for unselected items
        selectedLabelStyle: TextStyle(color: Colors.green[500], fontWeight: FontWeight.bold), // Ensure selected label matches selected item color
        unselectedLabelStyle: TextStyle(color: Colors.green[300]), // Ensure unselected label matches unselected item color
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.sports_soccer), label: 'Games'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Locations'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      );
    }

    Widget screen;
    if (user == null) {
      screen = CreateAccountScreen();
    } else {
      screen = _screens[_selectedIndex];
    }

    return Scaffold(
      body: screen,
      bottomNavigationBar: bottomNavBar,
      );
  }
}