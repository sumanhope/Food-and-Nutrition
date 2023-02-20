import 'package:flutter/material.dart';
import 'package:foodandnutrition/allpages/nutritional.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({super.key, required this.title});
  final String title;

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "foodname": "Rice", "cal": 223},
    {"id": 2, "foodname": "Noodles", "cal": 159},
    {"id": 3, "foodname": "Potato", "cal": 220},
    {"id": 4, "foodname": "Banana", "cal": 105},
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    _foundUsers = _allUsers;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _foundUsers.isNotEmpty
                ? ListView.builder(
                    itemCount: _foundUsers.length,
                    itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundUsers[index]["id"]),
                      color: const Color.fromARGB(153, 0, 150, 135),
                      elevation: 9,
                      shadowColor: Colors.teal[800],
                      child: ListTile(
                        leading: Text(
                          _foundUsers[index]["id"].toString(),
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white),
                        ),
                        title: Text(_foundUsers[index]['foodname'],
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text(
                            '${_foundUsers[index]["cal"].toString()} cal',
                            style: const TextStyle(color: Colors.white)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewData(
                                foodId: _foundUsers[index]["id"].toString(),
                                foodname:
                                    _foundUsers[index]['foodname'].toString(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : const Text(
                    'No results found',
                    style: TextStyle(fontSize: 24),
                  ),
          ),
        ],
      ),
    );
  }
}
