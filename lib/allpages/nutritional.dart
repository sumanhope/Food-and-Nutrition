import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:foodandnutrition/allpages/dietlist.dart';
import 'package:foodandnutrition/models/food.dart';
import 'package:foodandnutrition/utils/indicator.dart';
import 'package:foodandnutrition/utils/piechart.dart';

class ViewData extends StatefulWidget {
  const ViewData({super.key, required this.foodname, required this.foodId});
  final String foodname;
  final String foodId;

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  final box = const SizedBox(
    height: 5,
  );
  final sidebox = const SizedBox(
    width: 60,
  );
  //String foodname = "Rice";
  double calories = 0;
  String foodCat = "";
  double servSize = 0;
  bool isfav = false;
  double fats = 100.0;
  double crab = 100.0;
  double fiber = 100.0;
  double protein = 100.0;
  double sugar = 100.0;
  double iron = 100.0;
  double calcium = 100.0;
  double potassium = 100.0;
  double vitaminA = 0.0;
  double vitaminC = 0.0;
  double vitaminD = 0.0;
  String measure = "g";
  String diet = "Test";
  Showpiechart pie = Showpiechart();
  double fatpercent = 0.0;
  double carbspercent = 0.0;
  double proteinpercent = 0.0;
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    final foodDoc = await FirebaseFirestore.instance
        .collection('food')
        .doc(widget.foodId)
        .get();
    final food = Food.fromMap(foodDoc.data()!);
    setState(() {
      foodCat = food.foodCategory;
      servSize = food.servingSize;
      calories = food.calories;
      fats = food.fats;
      crab = food.carbs;
      fiber = food.fiber;
      protein = food.protein;
      sugar = food.sugar;
      iron = food.iron;
      calcium = food.calcium;
      potassium = food.potassium;
      vitaminA = food.vitaminA;
      vitaminC = food.vitaminC;
      vitaminD = food.vitaminD;
      measure = food.measure;
      diet = food.diet;
      favornot();
    });
    caloriesbreakdown(crab, fats, protein, calories);
    // debugPrint("Carbs %: $carbspercent");
    // debugPrint("Fat %: $fatpercent");
    // debugPrint("Protein %: $proteinpercent");
  }

  void caloriesbreakdown(
      double carbs, double fat, double protein, double calories) {
    double calfat = fat * 9;
    double calcarb = carbs * 4;
    double calprotein = protein * 4;
    double cal = calfat + calcarb + calprotein;
    setState(() {
      carbspercent = (calcarb / cal) * 100;
      fatpercent = (calfat / cal) * 100;
      proteinpercent = (calprotein / cal) * 100;
    });
  }

  Future favornot() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    var collectionref = FirebaseFirestore.instance.collection("users-fav");
    var doc = await collectionref
        .doc(currentUser!.email)
        .collection("foods")
        .doc(widget.foodname)
        .get();
    setState(() {
      if (doc.exists) {
        isfav = true;
      } else {
        isfav = false;
      }
    });

    //print(isfav);
  }

  Future<void> favtoggle() async {
    setState(() {
      if (isfav) {
        isfav = false;
      } else {
        isfav = true;
      }
    });

    if (isfav) {
      addtoFav();
    } else {
      removefromFav();
    }
    //print(isfav);
  }

  Future addtoFav() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collection =
        FirebaseFirestore.instance.collection("users-fav");
    return collection
        .doc(currentUser!.email)
        .collection("foods")
        .doc(widget.foodname)
        .set({
      "foodID": widget.foodId,
      "foodName": widget.foodname,
      "calories": calories,
    }).then(
      (value) => debugPrint("Added to Favorites"),
      onError: (e) => debugPrint("Error updating document $e"),
    );
  }

  Future removefromFav() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collection =
        FirebaseFirestore.instance.collection("users-fav");
    return collection
        .doc(currentUser!.email)
        .collection("foods")
        .doc(widget.foodname)
        .delete()
        .then(
          (value) => debugPrint("Removed from Fav"),
          onError: (e) => debugPrint("Error updating document $e"),
        );
  }

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Nutritional facts",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Container(
                    alignment: Alignment.center,
                    width: 450,
                    height: 290,
                    decoration: BoxDecoration(
                      color: const Color(0x92abd1c6),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 0.5,
                            child: PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                  touchCallback:
                                      (FlTouchEvent event, pieTouchResponse) {
                                    setState(() {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        touchedIndex = -1;
                                        return;
                                      }
                                      touchedIndex = pieTouchResponse
                                          .touchedSection!.touchedSectionIndex;
                                    });
                                  },
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 0,
                                centerSpaceRadius: 0,
                                sections: pie.showingSections(touchedIndex,
                                    carbspercent, fatpercent, proteinpercent),
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Indicator(
                              color: Color(0xFFE16162),
                              text: 'Carbs',
                              isSquare: false,
                              textColor: Color(0xff001e1d),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Indicator(
                              color: Color(0xFFf9bc60),
                              text: 'Fats',
                              isSquare: false,
                              textColor: Color(0xff001e1d),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Indicator(
                              color: Color(0xFFe8e4e6),
                              text: 'Protein',
                              isSquare: false,
                              textColor: Color(0xff001e1d),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.foodname,
                      style: const TextStyle(
                        letterSpacing: 1.7,
                        fontSize: 20,
                        //color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: IconButton(
                      onPressed: favtoggle,
                      icon: (isfav
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border)),
                      iconSize: 30,
                      //color: Colors.teal,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  // width: 100,
                  child: OutlinedButton(
                    onPressed: () {
                      if (diet == "Low Fats") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FoodListScreen(
                              title: "Low Fats",
                              imageurl: "images/Low-Fat.jpg",
                              description:
                                  "Beneficial for weight management, heart health. Nutrient-rich options, lower in calories and saturated fats.",
                            ),
                          ),
                        );
                      } else if (diet == "High-Fiber") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FoodListScreen(
                              title: "High-Fiber",
                              imageurl: "images/high-fiber.jpg",
                              description:
                                  "Important for healthy diet, Promote digestion, heart health, and weight management.",
                            ),
                          ),
                        );
                      } else if (diet == "High-Protein") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FoodListScreen(
                              title: "High-Protein",
                              imageurl: "images/High-Protein.jpg",
                              description:
                                  "Essential for muscle building and overall health, Support muscle growth and repair.",
                            ),
                          ),
                        );
                      } else if (diet == "Vegetables") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FoodListScreen(
                              title: "Vegetarian",
                              imageurl: "images/vegetarian.jpg",
                              description:
                                  "Nutrient-rich and support a healthy lifestyle, Provide essential vitamins, minerals, and fiber.",
                            ),
                          ),
                        );
                      } else {
                        debugPrint("Error");
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(195, 1, 149, 135),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: const BorderSide(
                        width: 3,
                        color: Color.fromARGB(183, 0, 0, 0),
                      ),
                    ),
                    child: Text(
                      diet,
                      style: const TextStyle(
                        letterSpacing: 1.7,
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
                indent: 14,
                endIndent: 14,
                color: Colors.teal,
                height: 5,
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Food Category: $foodCat",
                      style: const TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    box,
                    Text(
                      "Serving Size: $servSize $measure",
                      style: const TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    box,
                    Text(
                      "Calories: $calories kcal",
                      style: const TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
                indent: 14,
                endIndent: 14,
                color: Colors.teal,
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Nutritional Facts",
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    box,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Crab: ${crab}g",
                          style: const TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Text(
                          "Total Fats: ${fats}g",
                          style: const TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    box,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Protein: ${protein}g",
                          style: const TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        sidebox,
                        Text(
                          "Fiber: ${fiber}g",
                          style: const TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    box,
                    Text(
                      "Sugar: ${sugar}g",
                      style: const TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    box,
                    const Text(
                      "Minerals",
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    box,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Iron: ${iron}mg",
                          style: const TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        sidebox,
                        Text(
                          "Calcium: ${calcium}mg",
                          style: const TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    box,
                    Text(
                      "Potassium: ${potassium}mg",
                      style: const TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    box,
                    const Text(
                      "Vitamins",
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    box,
                    Text(
                      "Vitamin A: ${vitaminA}mcg",
                      style: const TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    box,
                    Text(
                      "Vitamin C: ${vitaminC}mcg",
                      style: const TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    box,
                    Text(
                      "Vitamin D: ${vitaminD}mcg",
                      style: const TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    box,
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
                indent: 14,
                endIndent: 14,
                color: Colors.teal,
                height: 5,
              ),
              box,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 19),
                child: SizedBox(
                  width: 400,
                  child: Text(
                    "Please note that nutrient values may vary depending "
                    "on factors such as the type of rice, cooking method, "
                    "and serving size.",
                    maxLines: 5,
                    softWrap: true,
                    style: TextStyle(
                      letterSpacing: 1.5,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              box,
            ],
          ),
        ),
      ),
    );
  }
}
