import 'package:flutter/material.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen(
      {super.key,
      required this.title,
      required this.imageurl,
      required this.description});
  final String title;
  final String imageurl;
  final String description;

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "foodname": "Rice", "cal": 110},
    {"id": 2, "foodname": "Noodles", "cal": 159},
    {"id": 3, "foodname": "Potato", "cal": 220},
    {"id": 4, "foodname": "Banana", "cal": 105},
  ];
  final List<Map<String, dynamic>> lowfat = [
    {"id": 1, "foodname": "Lentils", "cal": 120},
    {"id": 2, "foodname": "Rice", "cal": 110},
    {"id": 3, "foodname": "flatbread", "cal": 100},
    {"id": 4, "foodname": "Soybeans", "cal": 150},
    {"id": 5, "foodname": "Carrots", "cal": 25},
    {"id": 6, "foodname": "Rice Cracker", "cal": 40},
    {"id": 7, "foodname": "Cucumbers", "cal": 16},
    {"id": 8, "foodname": "Apples", "cal": 95}
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    switch (widget.title) {
      case "Low Fats":
        {
          _foundUsers = lowfat;
        }
        break;
      case "High-Fiber":
        {
          _foundUsers = lowfat;
        }
        break;
      case "High-Protein":
        {
          _foundUsers = lowfat;
        }
        break;
      case "Vegetarian":
        {
          _foundUsers = lowfat;
        }
        break;
      default:
        {
          _foundUsers = _allUsers;
        }
        break;
    }

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
      ),
      body: Column(
        //mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(
                  alignment: Alignment.center,
                  width: 400,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(widget.imageurl),
                      fit: BoxFit.cover,
                    ),
                    //color: const Color.fromARGB(94, 68, 137, 255),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.description,
              softWrap: true,
              maxLines: 5,
              textAlign: TextAlign.start,
              style: const TextStyle(
                letterSpacing: 1.5,
                fontSize: 15,
                color: Colors.teal,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Flexible(
            child: _foundUsers.isNotEmpty
                ? ListView.builder(
                    itemCount: _foundUsers.length,
                    itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundUsers[index]["id"]),
                      //color: const Color.fromARGB(153, 0, 150, 135),
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ViewData(
                          //       foodId: _foundUsers[index]["id"].toString(),
                          //       foodname:
                          //           _foundUsers[index]['foodname'].toString(),
                          //     ),
                          //   ),
                          // );
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
