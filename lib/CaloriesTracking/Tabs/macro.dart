import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:foodandnutrition/utils/indicator.dart';
import 'package:foodandnutrition/utils/piechart.dart';
import 'package:intl/intl.dart';

class MacroTab extends StatefulWidget {
  const MacroTab({super.key});

  @override
  State<MacroTab> createState() => _MacroTabState();
}

class _MacroTabState extends State<MacroTab> {
  int touchedIndex = -1;
  Showpiechart pie = Showpiechart();
  late DateTime _selectedDate;
  String userId = FirebaseAuth.instance.currentUser!.uid;
  double percentcarbs = 0.0;
  double percentprotein = 0.0;
  double percentfats = 0.0;
  double basecarbs = 0; //(2000 x 0.5) / 4
  double baseprotein = 0; // Grams of protein = (2000 x 0.2) / 4
  double basefats = 0;
  double basecal = 3000;
  //Stream<QuerySnapshot> _contentStream;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    getbaseMacro();
    getFoodTrack(_selectedDate);
  }

  void getbaseMacro() {
    setState(() {
      basecarbs = (basecal * 0.5) / 4;
      baseprotein = (basecal * 0.2) / 4;
      basefats = (basecal * 0.3) / 9;
    });
  }

  void getMacro(double totalcarbs, double totalprotein, double totalfats) {
    setState(() {
      percentcarbs = totalcarbs / basecarbs;
      percentprotein = totalprotein / baseprotein;
      percentfats = totalfats / basefats;
    });
  }

  //  void _loadContent() {
  //   final DateFormat formatter = DateFormat('yyyy-MM-dd');
  //   final String formattedDate = formatter.format(_selectedDate);
  //   setState(() {
  //     // _contentStream = FirebaseFirestore.instance
  //     //     .collection('content')
  //     //     .where('date', isEqualTo: formattedDate)
  //     //     .snapshots();
  //   });
  // }
  Future getFoodTrack(DateTime date) async {
    String currentDate = DateFormat('yyyy-MM-dd').format(date);
    double totalcarbs = 0;
    double totalprotein = 0;
    double totalfats = 0;
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('foodtrack')
          .doc(userId)
          .get();
      if (snapshot.exists) {
        final data = snapshot.data();
        if (data != null) {
          final foodArray = data[currentDate] as List<dynamic>?;

          if (foodArray != null) {
            for (final foodData in foodArray) {
              final carbs = double.tryParse(foodData['carbs'] ?? '');
              final protein = double.tryParse(foodData['protein'] ?? '');
              final fats = double.tryParse(foodData['fats'] ?? '');

              if (carbs != null && protein != null && fats != null) {
                totalcarbs += carbs;
                totalprotein += protein;
                totalfats += fats;
              } else {
                debugPrint("No data inside array");
                percentcarbs = 0.01;
                percentfats = 0.01;
                percentprotein = 0.01;
              }
            }
            getMacro(totalcarbs, totalprotein, totalfats);
          } else {
            debugPrint("Food Array null");
            percentcarbs = 0.01;
            percentfats = 0.01;
            percentprotein = 0.01;
          }
        } else {
          debugPrint("data null");
        }
      } else {
        debugPrint("snapshot not found");
      }
      setState(() {});
    } catch (e) {
      debugPrint('Error getting food track data: $e');
    }
  }

  void _goToPreviousDate() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
      percentcarbs = 0;
      percentfats = 0;
      percentprotein = 0;
    });
    getFoodTrack(_selectedDate);
  }

  void _goToNextDate() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 1));
      percentcarbs = 0;
      percentfats = 0;
      percentprotein = 0;
      //_loadContent();
    });
    getFoodTrack(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
                onPressed: _goToPreviousDate,
              ),
              const SizedBox(width: 16),
              Text(
                DateFormat('yyyy-MM-dd').format(_selectedDate),
                style: const TextStyle(
                  letterSpacing: 1.5,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward,
                  size: 30,
                ),
                onPressed: _goToNextDate,
              ),
            ],
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              width: size.width,
              height: 300,
              decoration: BoxDecoration(
                color: const Color(0x92abd1c6),
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
                  sections: pie.showingSections(
                      touchedIndex, percentcarbs, percentfats, percentprotein),
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
                    color: Color(0xFFE16162),
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
                Text(
                  "${percentcarbs.toStringAsFixed(2)}g",
                  style: const TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Text(
                  "${basecarbs}g",
                  style: const TextStyle(
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
                      shape: BoxShape.rectangle, color: Color(0xFFf9bc60)),
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
                Text(
                  "${percentfats.toStringAsFixed(2)}g",
                  style: const TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Text(
                  "${basefats}g",
                  style: const TextStyle(
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
                    color: Color(0xFFe8e4e6),
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
                Text(
                  "${percentprotein.toStringAsFixed(2)}g",
                  style: const TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Text(
                  "${baseprotein}g",
                  style: const TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          percentcarbs < 0.02
              ? const Text(
                  "No Food Logged Found",
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                )
              : const Text(
                  "Food Logged Found",
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                )
        ],
      ),
    );
  }
}
