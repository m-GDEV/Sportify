import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:sportify/main.dart';
import 'package:sportify/screens/home_screen.dart';
import 'package:sportify/screens/login_screen.dart';
import 'package:sportify/util/AuthService.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  var email = "";
  var password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // gradient: white to 255, 168, 230, 162
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                  child: Text(
                    "Welcome to ",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
                Image.asset(
                  'lib/assets/Sportify_logo.png',
                  height: 90,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                  child: Text(
                    "Please create an account to get started",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 500,
                    child: TextField(
                      autofillHints: [AutofillHints.email],
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                        print(email);
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Please enter a valid email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 500,
                    child: TextField(
                      onChanged: (value) => setState(() {
                        password = value;
                      }),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: '',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      final res = await AuthService.registration(
                          email: email, password: password);

                      if (res != null && res.contains('Success')) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const MainNavigation()));
                      } else {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error creating an account'),
                              content: Text(res ?? 'Unknown error'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text(
                      ' Submit ',
                      style: TextStyle(fontSize: 36, color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      'Already have an account? Log in here!',
                      style: TextStyle(fontSize: 24, color: Colors.green),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
