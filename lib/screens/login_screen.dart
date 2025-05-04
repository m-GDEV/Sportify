import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:sportify/main.dart';
import 'package:sportify/screens/home_screen.dart';
import 'package:sportify/util/AuthService.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email = "";
  var password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 32, 0, 40),
              child: Text(
                "Welcome to Sportify!",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text(
                "Please login to get started",
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
                  onChanged:
                      (value) => setState(() {
                        password = value;
                      }),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText:
                        'Enter the password you used to sign up',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),

            ],),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () async{
                  final res = await AuthService.login(email: email, password: password);

                  if (res!.contains('Success')) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MainNavigation()));
                  }
                  else {
                    showDialog<String> (context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error logging in account'),
                        content: Text(res),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    });
                  }
                },
                child: Text('Submit', style: TextStyle(fontSize: 48, color: Colors.white), 
              )),
                        ),
            )
          ],
        ),
      ),
    );
  }
}

