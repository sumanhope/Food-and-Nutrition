import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodandnutrition/CaloriesTracking/trackpagewidgets.dart';
import 'package:intl/intl.dart';

class CaloriesTab extends StatefulWidget {
  const CaloriesTab({super.key});

  @override
  State<CaloriesTab> createState() => _CaloriesTabState();
}

class _CaloriesTabState extends State<CaloriesTab> {
  late DateTime _selectedDate;
  double percentcal = 0;
  double foodcal = 0;
  double basecal = 0;
  double remaining = 0;
  String userId = FirebaseAuth.instance.currentUser!.uid;
  //Stream<QuerySnapshot> _contentStream;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    getData(_selectedDate);

    //_loadContent();
  }

  void getData(DateTime date) async {
    final User user = FirebaseAuth.instance.currentUser!;

    String uid = user.uid;

    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      basecal = double.parse(userDoc.get('basecalories').toString());
      remaining = basecal;
    });
    getFoodTrack(date);
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
              final calories = double.tryParse(foodData['calories'] ?? '');
              if (calories != null) {
                foodcal += calories;
              }
            }
            remaining -= foodcal;
            percentcal = (foodcal - 0) / (basecal - 0);
          } else {
            debugPrint("Food Array null");
            foodcal = 0;
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
      foodcal = 0;
      remaining = basecal;
      percentcal = 0;
    });
    getFoodTrack(_selectedDate);
  }

  void _goToNextDate() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 1));
      foodcal = 0;
      remaining = basecal;
      percentcal = 0;
      //_loadContent();
    });
    getFoodTrack(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
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
        //Text("Date: $_selectedDate"),
        Container(
          padding: const EdgeInsets.all(18),
          width: 450,
          // height: 400,
          margin:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 0.1, left: 10),
                child: Text(
                  "Calories",
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CircleProgress(
                  percentcal: percentcal,
                  foodcal: foodcal,
                  basecal: basecal,
                  remaining: remaining),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Row(
            children: [
              const Text(
                "Base Goal: ",
                style: TextStyle(
                  letterSpacing: 1,
                  fontSize: 18,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                "$basecal kcal",
                style: const TextStyle(
                  letterSpacing: 1.5,
                  fontSize: 18,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 5, bottom: 5, left: 18, right: 10),
          child: Row(
            children: [
              const Text(
                "Food: ",
                style: TextStyle(
                  letterSpacing: 1,
                  fontSize: 18,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                "$foodcal kcal",
                style: const TextStyle(
                  letterSpacing: 1.5,
                  fontSize: 18,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
        foodcal < 1
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
        // Expanded(
        //   child: StreamBuilder<QuerySnapshot>(
        //     stream: _contentStream,
        //     builder: (context, snapshot) {
        //       if (!snapshot.hasData) {
        //         return const Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       }
        //       final List<DocumentSnapshot> documents = snapshot.data.docs;
        //       if (documents.isEmpty) {
        //         return const Center(
        //           child: Text('No content found for this date.'),
        //         );
        //       }
        //       final Map<String, dynamic> contentData = documents.first.data();
        //       return SingleChildScrollView(
        //         padding: const EdgeInsets.all(16),
        //         child: Text(
        //           contentData['text'],
        //           style: const TextStyle(fontSize: 20),
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
