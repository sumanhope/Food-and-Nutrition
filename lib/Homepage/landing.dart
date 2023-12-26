import 'package:flutter/material.dart';
import 'package:foodandnutrition/navpages/food_page.dart';
import 'package:foodandnutrition/navpages/home_page.dart';
import 'package:foodandnutrition/navpages/profile_page.dart';
import 'package:foodandnutrition/navpages/search_page.dart';
import 'package:foodandnutrition/navpages/track_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const TrackPage(),
    const FoodPage(),
    const ProfileScreen(),
  ];

  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: pages[currentStep],
        bottomNavigationBar: Container(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            child: GNav(
              hoverColor: Theme.of(context).hoverColor,
              backgroundColor: Theme.of(context).primaryColor,
              color: Theme.of(context).unselectedWidgetColor,
              activeColor: Theme.of(context).focusColor,
              tabBackgroundColor: Theme.of(context).hoverColor,
              gap: 6,
              padding: const EdgeInsets.all(10),
              iconSize: 25,
              textStyle: TextStyle(
                fontSize: 15,
                color: Theme.of(context).focusColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.search,
                  text: "Search",
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
      ),
    );
  }
}
