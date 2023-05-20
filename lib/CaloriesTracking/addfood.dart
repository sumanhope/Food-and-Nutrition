// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodandnutrition/navpages/track_page.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  String foodname = "";
  TrackPage track = const TrackPage();
  String userId = FirebaseAuth.instance.currentUser!.uid;
  String currentDate = DateTime.now().toString().substring(0, 10);
  Future errorDialog(String error) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          backgroundColor: const Color.fromARGB(121, 53, 233, 215),
          elevation: 5,
          title: Text(
            error,
            style: const TextStyle(
              letterSpacing: 2.5,
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }

  Widget buildUser() {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).cardColor,
        //floatingLabelStyle: TextStyle(color: Colors.white),

        //fillColor: const Color.fromARGB(117, 100, 255, 219),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide:
              BorderSide(color: Color.fromRGBO(77, 182, 172, 1), width: 3),
        ),
        labelText: 'Search Food',
        labelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.teal,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white,
          size: 30,
        ),

        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.teal, width: 3),
        ),
      ),
      onChanged: (value) {
        setState(() {
          foodname = value;
        });
      },
      style: TextStyle(
        color: Theme.of(context).unselectedWidgetColor,
        fontSize: 15,
        fontFamily: 'Poppins',
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }

  var textstyle = const TextStyle(
    letterSpacing: 1.5,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
  );

  Future<void> addFood(String addfood, String addcalories, String addcarbs,
      String addprotein, String addfats) async {
    try {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });

      await FirebaseFirestore.instance
          .collection('foodtrack')
          .doc(userId)
          .update({
        currentDate: FieldValue.arrayUnion([
          {
            "foodname": addfood,
            "calories": addcalories,
            "carbs": addcarbs,
            "protein": addprotein,
            "fats": addfats
          }
        ])
      });
      Navigator.pop(context);
      errorDialog("Food Logged");
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        // Document doesn't exist, so create it with the food entry for the current date
        await FirebaseFirestore.instance
            .collection('foodtrack')
            .doc(userId)
            .set({
          currentDate: [
            {
              "foodname": addfood,
              "calories": addcalories,
              "carbs": addcarbs,
              "protein": addprotein,
              "fats": addfats
            }
          ]
        });
        Navigator.pop(context);
        errorDialog("Food Logged");
      } else {
        // Handle other errors as needed
        Navigator.pop(context);
        errorDialog(e.toString());
      }
    } catch (e) {
      // Handle other errors as needed
      Navigator.pop(context);
      errorDialog(e.toString());
    }
  }

  Map<String, double> calculateCalories(
    double servingSize,
    double calories,
    double carbs,
    double protein,
    double fats,
    String measure,
  ) {
    double totalCalories = 0;
    double totalCarbs = 0;
    double totalprotein = 0;
    double totalfats = 0;
    if (measure == "g") {
      totalCalories = calories * (servingSize / 100);
      totalCarbs = carbs * (servingSize / 100);
      totalprotein = protein * (servingSize / 100);
      totalfats = fats * (servingSize / 100);
    } else {
      totalCalories = calories * (servingSize);
      totalCarbs = carbs * (servingSize);
      totalprotein = protein * (servingSize);
      totalfats = fats * (servingSize);
    }

    // Calculate the calories and total carbs based on the serving size and macronutrient values

    String formattedCalories = totalCalories.toStringAsFixed(2);
    String formattedCarbs = totalCarbs.toStringAsFixed(2);
    String formattedProtein = totalprotein.toStringAsFixed(2);
    String formattedFats = totalfats.toStringAsFixed(2);

    return {
      'calories': double.parse(formattedCalories),
      'carbs': double.parse(formattedCarbs),
      'protein': double.parse(formattedProtein),
      'fats': double.parse(formattedFats),
    };
  }

  void showDialogFunction(
    BuildContext context,
    String foodname,
    double calories,
    double carbs,
    double protein,
    double fats,
    double servingsize,
    String measure,
  ) {
    TextEditingController servingSizeController =
        TextEditingController(text: servingsize.toString());
    double testcalories = calories;
    double testcarb = carbs;
    double testprotein = protein;
    double testfats = fats;
    Map<String, double> result;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Food Details'),
              content: SizedBox(
                height: 200,
                width: 350,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Name of food: $foodname",
                        style: textstyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Serving Size: ",
                            style: textstyle,
                          ),
                          SizedBox(
                            width: 60,
                            child: TextField(
                              controller: servingSizeController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  servingsize = double.tryParse(value) ?? 0;
                                  // Update the calories based on the new serving size
                                  result = calculateCalories(
                                    servingsize,
                                    calories,
                                    carbs,
                                    protein,
                                    fats,
                                    measure,
                                  );
                                  testcalories = result['calories']!;
                                  testcarb = result['carbs']!;
                                  testprotein = result['protein']!;
                                  testfats = result['fats']!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Measurement: $measure",
                        style: textstyle,
                        softWrap: true,
                        maxLines: 4,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Calories: $testcalories",
                        style: textstyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Carbs: $testcarb",
                        style: textstyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Protein: $testprotein",
                        style: textstyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Fats: $testfats",
                        style: textstyle,
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                OutlinedButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
                ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () {
                    addFood(
                      foodname,
                      testcalories.toString(),
                      testcarb.toString(),
                      testprotein.toString(),
                      testfats.toString(),
                    );
                    // Perform action when OK is pressed
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigating back to the previous page with a result
        return false;
      },
      child: KeyboardDismisser(
        gestures: const [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            title: const Text(
              "Add Food",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: buildUser(),
                  ),
                  Flexible(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("food")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "Error: ${snapshot.error}",
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                color: Colors.teal,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data!.docs[index].data();
                            if (foodname.isEmpty) {
                              return Addfoodcard(
                                foodname: data['foodName'].toString(),
                                category: data['foodCategory'].toString(),
                                press: () {
                                  String food = data['foodName'].toString();
                                  double cal =
                                      double.parse(data["calories"].toString());
                                  double carbs =
                                      double.parse(data['carb'].toString());
                                  double protein =
                                      double.parse(data['protein'].toString());
                                  double fats =
                                      double.parse(data['fat'].toString());
                                  double servingsize = double.parse(
                                      data['servingSize'].toString());
                                  String measure = data['measure'].toString();

                                  showDialogFunction(context, food, cal, carbs,
                                      protein, fats, servingsize, measure);
                                },
                              );
                            }
                            if (data['foodName']
                                .toString()
                                .toLowerCase()
                                .startsWith(foodname.toLowerCase())) {
                              return Addfoodcard(
                                foodname: data['foodName'].toString(),
                                category: data['foodCategory'].toString(),
                                press: () {
                                  String food = data['foodName'].toString();
                                  double cal =
                                      double.parse(data["calories"].toString());
                                  double carbs =
                                      double.parse(data['carb'].toString());
                                  double protein =
                                      double.parse(data['protein'].toString());
                                  double fats =
                                      double.parse(data['fat'].toString());
                                  double servingsize = double.parse(
                                      data['servingSize'].toString());
                                  String measure = data['measure'].toString();

                                  showDialogFunction(context, food, cal, carbs,
                                      protein, fats, servingsize, measure);
                                },
                              );
                            }
                            if (index == snapshot.data!.docs.length - 1) {
                              return const Center(
                                child: Text(
                                  'No similar food found',
                                  style: TextStyle(
                                    letterSpacing: 1.2,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              );
                            }

                            return Container();
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Addfoodcard extends StatelessWidget {
  const Addfoodcard({
    Key? key,
    required this.foodname,
    required this.category,
    required this.press,
  }) : super(key: key);
  final String foodname;
  final String category;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 1),
      child: Card(
        //color: const Color.fromARGB(153, 0, 150, 135),
        elevation: 9,
        shadowColor: Colors.teal[800],
        child: ListTile(
            title: Text(
              foodname,
              style: const TextStyle(
                letterSpacing: 1.2,
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            subtitle: Text(
              category,
              style: const TextStyle(
                letterSpacing: 1.5,
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontFamily: 'Poppins',
              ),
            ),
            onTap: press),
      ),
    );
  }
}
