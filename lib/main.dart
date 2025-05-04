import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:provider/provider.dart';
import 'package:sportify/screens/create_account_screen.dart';
import 'package:sportify/screens/login_screen.dart';
import 'package:sportify/util/api_keys.dart';
import 'screens/home_screen.dart';
import 'screens/find_players_screen.dart';
import 'screens/review_locations_screen.dart';
import 'screens/game_screen.dart';
import 'screens/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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
    return ChangeNotifierProvider(create: (context) => MyAppState(),
      child: MaterialApp(
      title: 'Sportify',
      theme: ThemeData(
        primarySwatch: Colors.green,
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          labelStyle: TextStyle(color: Colors.green),
          floatingLabelStyle: TextStyle(color: Colors.green),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.green[900],
        ),
        fontFamily: 'Outfit',
      ),
      home: const MainNavigation(),
    )
      );
  }
}

class MyAppState extends ChangeNotifier {
  var model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: GEMINI_KEY);
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
    ProfilePage(externalPlayer: false,),
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
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(),
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
