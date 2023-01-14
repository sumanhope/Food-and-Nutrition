// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:foodandnutrition/Homepage/home_page.dart';
import 'package:foodandnutrition/allpages/profile_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../allpages/food_page.dart';
import '../allpages/track_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int currentStep = 0;
  final List<Widget> pages = [
    HomePage(),
    TrackPage(),
    FoodPage(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentStep],
      bottomNavigationBar: Container(
        color: Colors.teal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
          child: GNav(
            backgroundColor: Colors.teal,
            color: Colors.black,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.teal.shade800,
            gap: 8,
            padding: EdgeInsets.all(16),
            iconSize: 25,
            textStyle: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: "Home",
              ),
              GButton(
                icon: Icons.speed,
                text: "Track",
              ),
              GButton(
                icon: Icons.rice_bowl,
                text: "Foods",
              ),
              GButton(
                icon: Icons.person,
                text: "Me",
              ),
            ],
            selectedIndex: currentStep,
            onTabChange: (index) {
              setState(() {
                currentStep = index;
              });
            },
          ),
        ),
      ),
    );
  }
}