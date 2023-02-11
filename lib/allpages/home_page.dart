import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodandnutrition/allpages/nutritional.dart';
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
  String username = "Loading";
  DateTime today = DateTime.now();
  String dateStr = "";
  @override
  void initState() {
    //dateStr = "${today.year}/${today.month}/${today.day}";
    dateStr = DateFormat('MMM d,yyyy').format(today);
    debugPrint(dateStr);
    getData();
    super.initState();
  }

  void getData() async {
    _uid = user.uid;

    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      username = userDoc.get('username');
    });
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
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
          backgroundColor: Colors.white,
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
                    children: const [
                      FoodCard(
                        imagelink: "images/high-fiber.jpg",
                        about: 'contains list of high-fiber foods',
                        type: 'High-Fiber',
                        whichpatients: 'For Piles',
                      ),
                      FoodCard(
                        imagelink: "images/High-Protein.jpg",
                        about: 'contains list of high-protein foods',
                        type: 'High-Protein',
                        whichpatients: 'For test',
                      ),
                      FoodCard(
                        imagelink: "images/vegetarian.jpg",
                        about: 'contains list of vegetarian foods',
                        type: 'Vegetarian',
                        whichpatients: 'For Vegans',
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
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        dateStr,
                        style: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 15,
                          color: Colors.teal[500],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
                Smallcards(
                  foodname: 'Rice, white (1cup)',
                  totalcalories: '223 cal',
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
                  foodname: 'Noodles, (1cup)',
                  totalcalories: '159 cal',
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
                  foodname: 'Potato, (1 baked)',
                  totalcalories: '220 cal',
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
                  foodname: 'Banana, (1)',
                  totalcalories: '105 cal',
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
        color: const Color.fromARGB(153, 0, 150, 135),
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
            onTap: press
            //() {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const ViewData(),
            //     ),
            //   );
            // },
            ),
      ),
    );
  }
}
