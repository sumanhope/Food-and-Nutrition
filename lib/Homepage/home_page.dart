import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodandnutrition/Welcome/welcome_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => WelcomeScreen()),
                  ),
                );
              });
            },
            child: Text("Logout")),
      ),
    );
  }
}
