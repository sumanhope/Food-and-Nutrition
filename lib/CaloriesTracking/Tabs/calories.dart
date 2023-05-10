import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CaloriesTab extends StatefulWidget {
  const CaloriesTab({super.key});

  @override
  State<CaloriesTab> createState() => _CaloriesTabState();
}

class _CaloriesTabState extends State<CaloriesTab> {
  late DateTime _selectedDate;
  //Stream<QuerySnapshot> _contentStream;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    //_loadContent();
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

  void _goToPreviousDate() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
      //_loadContent();
    });
  }

  void _goToNextDate() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 1));
      //_loadContent();
    });
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
              style: const TextStyle(fontSize: 24),
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
        const SizedBox(height: 16),
        Text("Date: $_selectedDate"),
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
