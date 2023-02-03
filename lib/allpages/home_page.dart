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
  DateTime today = DateTime.now();
  String dateStr = "";
  @override
  void initState() {
    dateStr = "${today.year}/${today.month}/${today.day}";
    debugPrint(dateStr);
    super.initState();
  }

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
                        const Text(
                          "Hi, Suman!",
                          style: TextStyle(
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
                  const Smallcards(
                    foodname: 'Rice, white (1cup)',
                    totalcalories: '223 cal',
                  ),
                  const Smallcards(
                    foodname: 'Noodles, (1cup)',
                    totalcalories: '159 cal',
                  ),
                  const Smallcards(
                    foodname: 'Potato, (1 baked)',
                    totalcalories: '220 cal',
                  ),
                  const Smallcards(
                    foodname: 'Banana, (1)',
                    totalcalories: '105 cal',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
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
  }) : super(key: key);
  final String foodname;
  final String totalcalories;

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
          onTap: () {},
        ),
      ),
    );
  }
}
