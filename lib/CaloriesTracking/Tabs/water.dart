import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodandnutrition/utils/barchart.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class WaterTab extends StatefulWidget {
  const WaterTab({super.key});

  @override
  State<WaterTab> createState() => _WaterTabState();
}

class _WaterTabState extends State<WaterTab> {
  late DateTime _selectedDate;
  String userId = FirebaseAuth.instance.currentUser!.uid;
  int totalwatercount = 10;
  int trackwatercount = 0;
  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    getWaterTrack(_selectedDate);
  }

  getWaterTrack(DateTime date) async {
    String currentDate = DateFormat('yyyy-MM-dd').format(date);
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('watertrack')
          .doc(userId)
          .get();
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey(currentDate)) {
          setState(() {
            trackwatercount = data[currentDate];
          });
          // return data[currentDate];
        }
      }
    } catch (e) {
      debugPrint('Error getting Water track data: $e');
    }
  }

  void _goToPreviousDate() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
      trackwatercount = 0;
    });
    getWaterTrack(_selectedDate);
  }

  void _goToNextDate() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 1));
      trackwatercount = 0;
      //_loadContent();
    });
    getWaterTrack(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
        id: "waterlevel",
        data: [
          BarChartModel(
            day: DateFormat('yyyy-MM-dd').format(_selectedDate).toString(),
            waterlevel: trackwatercount,
            color: charts.ColorUtil.fromDartColor(Colors.pink),
          ),
          // BarChartModel(
          //   day: "",
          //   waterlevel: 10,
          //   color: charts.ColorUtil.fromDartColor(Colors.transparent),
          // ),
        ],
        domainFn: (BarChartModel series, _) => series.day,
        measureFn: (BarChartModel series, _) => series.waterlevel,
        colorFn: (BarChartModel series, _) => series.color,
        measureUpperBoundFn: (BarChartModel series, _) => 10,
        measureLowerBoundFn: (BarChartModel series, _) => 0,
      ),
    ];
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
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 300,
              width: size.width,
              decoration: BoxDecoration(
                color: const Color(0x92abd1c6),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: charts.BarChart(
                series,
                animate: true,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Total Water count: $totalwatercount",
            style: const TextStyle(
              letterSpacing: 1.5,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            "Total Drank Water Count: $trackwatercount",
            style: const TextStyle(
              letterSpacing: 1.5,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
