import 'package:flutter/material.dart';
import 'package:foodandnutrition/CaloriesTracking/Tabs/calories.dart';
import 'package:foodandnutrition/CaloriesTracking/Tabs/macro.dart';
import 'package:foodandnutrition/CaloriesTracking/Tabs/water.dart';

class AllTrack extends StatefulWidget {
  const AllTrack({super.key, required this.page});
  final int page;
  @override
  State<AllTrack> createState() => _AllTrackState();
}

class _AllTrackState extends State<AllTrack> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: widget.page,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "All details",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          centerTitle: true,
        ),
        body: const Column(
          children: [
            TabBar(
              unselectedLabelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
              labelColor: Colors.teal,
              labelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
              tabs: [
                Tab(
                  text: "Calories",
                ),
                Tab(
                  text: "Macro",
                ),
                Tab(
                  text: "Water",
                ),
              ],
            ),
            Expanded(
                child: TabBarView(
              children: [CaloriesTab(), MacroTab(), WaterTab()],
            ))
          ],
        ),
      ),
    );
  }
}
