import 'package:flutter/material.dart';
import 'package:foodandnutrition/allpages/nutritional.dart';
import 'package:foodandnutrition/navpages/home_page.dart';

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
    {"id": 1, "foodname": "Rice", "cal": 130},
    {"id": 25, "foodname": "Broccoli", "cal": 34},
    {"id": 26, "foodname": "Cauliflower", "cal": 25},
    {"id": 5, "foodname": "Carrots", "cal": 41},
    {"id": 27, "foodname": "Brussels Sprouts", "cal": 43},
    {"id": 28, "foodname": "Bell Peppers", "cal": 26},
    {"id": 29, "foodname": "Mushrooms", "cal": 22}
  ];
  final List<Map<String, dynamic>> highfiber = [
    {"id": 30, "foodname": "Chia Seeds", "cal": 60},
    {"id": 5, "foodname": "Lentils", "cal": 165},
    {"id": 31, "foodname": "Green Peas", "cal": 81},
    {"id": 32, "foodname": "Black Beans", "cal": 91},
    {"id": 24, "foodname": "Oatmeal", "cal": 145},
    {"id": 4, "foodname": "Banana", "cal": 89},
  ];
  final List<Map<String, dynamic>> highprotein = [
    {"id": 34, "foodname": "Chicken Breast", "cal": 195},
    {"id": 35, "foodname": "Tofu", "cal": 70},
    {"id": 36, "foodname": "Yogurt", "cal": 243},
    {"id": 37, "foodname": "Boiled Egg", "cal": 154},
    {"id": 33, "foodname": "Whole Wheat Pasta", "cal": 180},
    {"id": 38, "foodname": "Salmon", "cal": 139},
    {"id": 32, "foodname": "Black Beans", "cal": 91},
  ];
  final List<Map<String, dynamic>> vegetarian = [
    {"id": 3, "foodname": "Potato, Baked", "cal": 103},
    {"id": 7, "foodname": "Carrot", "cal": 41},
    {"id": 8, "foodname": "Cucumber", "cal": 12},
    {"id": 9, "foodname": "Cooked Soybeans", "cal": 172},
    {"id": 39, "foodname": "Bodi", "cal": 31},
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
          _foundUsers = highfiber;
        }
        break;
      case "High-Protein":
        {
          _foundUsers = highprotein;
        }
        break;
      case "Vegetarian":
        {
          _foundUsers = vegetarian;
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
                    itemBuilder: (context, index) {
                      return Smallcards(
                        foodname: _foundUsers[index]['foodname'],
                        totalcalories: _foundUsers[index]["cal"].toString(),
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewData(
                                foodId: _foundUsers[index]['id'].toString(),
                                foodname: _foundUsers[index]['foodname'],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    // child: ListTile(
                    //   leading: Text(
                    //     _foundUsers[index]["id"].toString(),
                    //     style: const TextStyle(
                    //         fontSize: 24, color: Colors.white),
                    //   ),
                    //   title: Text(_foundUsers[index]['foodname'],
                    //       style: const TextStyle(color: Colors.white)),
                    //   subtitle: Text(
                    //       '${_foundUsers[index]["cal"].toString()} cal',
                    //       style: const TextStyle(color: Colors.white)),
                    //   onTap: () {},
                    // ),

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
