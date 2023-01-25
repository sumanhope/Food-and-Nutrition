import 'package:flutter/material.dart';
import 'package:foodandnutrition/utils/foodcard.dart';
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
  final searchcontroller = TextEditingController();

  Widget buildSearch() {
    return TextField(
      controller: searchcontroller,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(117, 100, 255, 219),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide:
              BorderSide(color: Color.fromRGBO(77, 182, 172, 1), width: 3),
        ),
        labelText: 'Search Bar',
        labelStyle: const TextStyle(
          color: Colors.teal,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),

        prefixIcon: const Icon(
          Icons.search,
          color: Colors.teal,
          size: 30,
        ),
        suffixIcon: searchcontroller.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => searchcontroller.clear(),
              ),
        //prefixIconColor: Colors.teal,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.teal, width: 3),
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontFamily: 'Poppins',
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        gestures: const [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false, title: const Text("Home")),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Center(
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
                              patients: "For Diabetes",
                              fooddetails: "Low Carb",
                              fooddesc: "Test",
                            ),
                            FoodCard(
                              patients: "For Piles",
                              fooddetails: "High Fiber",
                              fooddesc: "Test",
                            ),
                            FoodCard(
                              patients: "For Fever",
                              fooddetails: "Nutrient-rich Foods",
                              fooddesc: "Test",
                            ),
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
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25.0),
                        child: buildSearch(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 15),
                        child: Container(
                          height: 70,
                          width: 500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromARGB(255, 4, 194, 175),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 15),
                        child: Container(
                          height: 70,
                          width: 500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromARGB(255, 4, 194, 175),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
