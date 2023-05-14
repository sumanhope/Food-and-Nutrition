import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodandnutrition/allpages/dietlist.dart';
import 'package:foodandnutrition/allpages/nutritional.dart';
import 'package:foodandnutrition/services/darkthemeperf.dart';
import 'package:foodandnutrition/utils/foodcard.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//import 'package:foodandnutrition/allpages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = PageController();
  final User user = FirebaseAuth.instance.currentUser!;

  String _uid = " ";
  String username = "";
  DateTime today = DateTime.now();
  String dateStr = "";
  bool reload = true;
  UsernamePerfs testuser = UsernamePerfs();
  @override
  void initState() {
    //dateStr = "${today.year}/${today.month}/${today.day}";
    dateStr = DateFormat('MMM d,yyyy').format(today);
    // testuser.getUsername().then((result) {
    //   username = result;
    //   if (username != "Loading") {
    //     getData();
    //   }
    // });
    callServer();
    debugPrint(dateStr);
    super.initState();
  }

  void callServer() async {
    String test = await testuser.getUsername();
    if (test == "Loading") {
      getData();
    } else {
      setState(() {
        username = test;
      });
    }
  }

  void getData() async {
    _uid = user.uid;

    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      username = userDoc.get('username');
      testuser.setUsername(username);
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Home",
            style: TextStyle(
              letterSpacing: 1.5,
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        //backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  children: [
                    FoodCard(
                      imagelink: "images/high-fiber.jpg",
                      about: 'contains list of high-fiber foods',
                      type: 'High-Fiber',
                      whichpatients: 'For Piles',
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FoodListScreen(
                              title: "High-Fiber",
                              imageurl: "images/high-fiber.jpg",
                              description: "",
                            ),
                          ),
                        );
                      },
                    ),
                    FoodCard(
                      imagelink: "images/High-Protein.jpg",
                      about: 'contains list of high-protein foods',
                      type: 'High-Protein',
                      whichpatients: 'For test',
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FoodListScreen(
                              title: "High Protein",
                              imageurl: "images/High-Protein.jpg",
                              description: "",
                            ),
                          ),
                        );
                      },
                    ),
                    FoodCard(
                      imagelink: "images/vegetarian.jpg",
                      about: 'contains list of vegetarian foods',
                      type: 'Vegetarian',
                      whichpatients: 'For Vegans',
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FoodListScreen(
                              title: "Vegetarian",
                              imageurl: "images/vegetarian.jpg",
                              description: "",
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Colors.teal,
                  dotHeight: 10,
                  dotWidth: 10,
                  strokeWidth: 2,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hi, $username!",
                      style: const TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 25,
                        //color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      dateStr,
                      style: const TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 15,
                        //color: Colors.teal[500],
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              Smallcards(
                foodname: 'Rice, cooked',
                totalcalories: '130 kcal',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ViewData(
                        foodId: "1",
                        foodname: "Rice",
                      ),
                    ),
                  );
                },
              ),
              Smallcards(
                foodname: 'Noodles, cooked',
                totalcalories: '219 kcal',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ViewData(foodId: "2", foodname: "Noodles"),
                    ),
                  );
                },
              ),
              Smallcards(
                foodname: 'Potato, baked',
                totalcalories: '220 kcal',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ViewData(foodId: "3", foodname: "Potato"),
                    ),
                  );
                },
              ),
              Smallcards(
                foodname: 'Banana',
                totalcalories: '105 kcal',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ViewData(foodId: "4", foodname: "Banana"),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Smallcards extends StatelessWidget {
  const Smallcards({
    Key? key,
    required this.foodname,
    required this.totalcalories,
    required this.press,
  }) : super(key: key);
  final String foodname;
  final String totalcalories;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
      child: Card(
        //color: const Color.fromARGB(153, 0, 150, 135),
        elevation: 9,
        shadowColor: Colors.teal[800],
        child: ListTile(
            title: Text(
              foodname,
              style: const TextStyle(
                letterSpacing: 1.2,
                fontSize: 19,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            subtitle: Text(
              totalcalories,
              style: const TextStyle(
                letterSpacing: 1.5,
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            onTap: press),
      ),
    );
  }
}
