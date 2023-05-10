import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:foodandnutrition/utils/indicator.dart';
import 'package:foodandnutrition/utils/piechart.dart';

class MacroTab extends StatefulWidget {
  const MacroTab({super.key});

  @override
  State<MacroTab> createState() => _MacroTabState();
}

class _MacroTabState extends State<MacroTab> {
  int touchedIndex = -1;
  Showpiechart pie = Showpiechart();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              width: size.width,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(5),
              ),
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 0,
                  sections: pie.showingSections(touchedIndex, 80, 10, 10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: size.width - 200,
                ),
                const Text(
                  "Percent",
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                const Text(
                  "Total",
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.indigo,
                  ),
                ),
                const Text(
                  "Carbohydrates",
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                const Text(
                  "80%",
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                const Text(
                  "135g",
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.yellow,
                  ),
                ),
                const Text(
                  "Fats                  ",
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                const Text(
                  "80%",
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                const Text(
                  "135g",
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.blue,
                  ),
                ),
                const Text(
                  "Protein              ",
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                const Text(
                  "80%",
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                const Text(
                  "135g",
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
