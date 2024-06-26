// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodandnutrition/CaloriesTracking/addfood.dart';
import 'package:foodandnutrition/CaloriesTracking/datadisplay.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../CaloriesTracking/trackpagewidgets.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class TrackPage extends StatefulWidget {
  const TrackPage({super.key});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  final _controller = PageController();
  final foodnamecontroller = TextEditingController();
  final basecalcontroller = TextEditingController();
  final caloriescontroller = TextEditingController();
  final carbscontroller = TextEditingController();
  final proteincontroller = TextEditingController();
  final fatscontroller = TextEditingController();
  String userId = FirebaseAuth.instance.currentUser!.uid;
  String currentDate = DateTime.now().toString().substring(0, 10);
  double percentcal = 0.0;
  double percentcarbs = 0.0;
  double percentprotein = 0.0;
  double percentfats = 0.0;
  double basecal = 1;
  double foodcal = 0;
  double remaining = 1;
  double carbs = 0;
  double protein = 0;
  double fats = 0;
  double basecarbs = 0; //(2000 x 0.5) / 4
  double baseprotein = 0; // Grams of protein = (2000 x 0.2) / 4
  double basefats = 0; //Grams of fats = (2000 x 0.3) / 9
  String foodname = "";
  var textstyle = const TextStyle(
    letterSpacing: 1.5,
    fontSize: 14,
    color: Colors.teal,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
  );

  @override
  void initState() {
    super.initState();
    getData();
    loadWaterLevel();
  }

  void getData() async {
    final User user = FirebaseAuth.instance.currentUser!;

    String uid = user.uid;

    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      basecal = double.parse(userDoc.get('basecalories').toString());
      remaining = basecal;
    });
    getMacro();
  }

  void getMacro() {
    setState(() {
      basecarbs = (basecal * 0.5) / 4;
      baseprotein = (basecal * 0.2) / 4;
      double basefat = (basecal * 0.3) / 9;
      String formattedfats = basefat.toStringAsFixed(1);
      basefats = double.parse(formattedfats);
    });
    getFoodTrack();
  }

  addCal(double intakecal, double intakecarbs, double intakeprotein,
      double intakefats) {
    setState(() {
      if (percentcal > 1) {
        percentcal = 1;
      } else {
        //normalized_value = (value - min_value) / (max_value - min_value)

        double normalizecal = (intakecal - 0) / (basecal - 0);
        double normalizecarbs = intakecarbs / basecarbs;
        double normalizeprotein = intakeprotein / baseprotein;
        double normalizefats = intakefats / basefats;

        foodcal += intakecal;
        carbs += intakecarbs;
        protein += intakeprotein;
        fats += intakefats;
        String formatcarbs = carbs.toStringAsFixed(2);
        carbs = double.parse(formatcarbs);
        String formatprotein = protein.toStringAsFixed(2);
        protein = double.parse(formatprotein);
        String formatfats = fats.toStringAsFixed(2);
        fats = double.parse(formatfats);
        if (foodcal > basecal) {
          foodcal = basecal;
        }
        percentcal += normalizecal;
        percentcarbs += normalizecarbs;
        percentprotein += normalizeprotein;
        percentfats += normalizefats;
        if (percentcarbs > 1) {
          percentcarbs = 1;
        }
        if (percentprotein > 1) {
          percentprotein = 1;
        }
        if (percentfats > 1) {
          percentfats = 1;
        }
        if (percentcal > 1) {
          percentcal = 1;
        }
        remaining -= intakecal;
        if (remaining < 0) {
          remaining = basecal;
        }
        // debugPrint(foodcal.toString());
        // debugPrint(remaining.toString());
        // debugPrint(percentcal.toString());
        // debugPrint(percentcarbs.toString());
        // debugPrint(percentfats.toString());
        // debugPrint(percentprotein.toString());
        debugPrint(fats.toString());
      }
    });
  }

  Future getFoodTrack() async {
    double totalCalories = 0;
    double totalcarbs = 0;
    double totalprotein = 0;
    double totalfats = 0;

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('foodtrack')
          .doc(userId)
          .get();
      if (snapshot.exists) {
        final data = snapshot.data();
        if (data != null) {
          final foodArray = data[currentDate] as List<dynamic>?;

          if (foodArray != null) {
            for (final foodData in foodArray) {
              final calories = double.tryParse(foodData['calories'] ?? 0.0);
              final carbs = double.tryParse(foodData['carbs'] ?? 0);
              final protein = double.tryParse(foodData['protein'] ?? 0);
              final fats = double.tryParse(foodData['fats'] ?? 0);

              if (calories != null &&
                  carbs != null &&
                  protein != null &&
                  fats != null) {
                totalCalories += calories;
                totalcarbs += carbs;
                totalprotein += protein;
                totalfats += fats;
              }
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Error getting food track data: $e');
    }
    addCal(totalCalories, totalcarbs, totalprotein, totalfats);
  }

  double waterlevel = 0;
  int watercount = 0;
  void incrementWaterLevel() {
    setState(() {
      waterlevel += 0.1;
      watercount += 1;
      if (waterlevel > 1.0) {
        waterlevel = 1.0;
      }
      if (watercount > 10) {
        watercount = 10;
      }
      saveWaterLevel(waterlevel, watercount);
    });
  }

  void decrementWaterLevel() {
    setState(() {
      waterlevel -= 0.1;
      watercount -= 1;
      if (waterlevel < 0) {
        waterlevel = 0;
      }
      if (watercount < 0) {
        watercount = 0;
      }
      saveWaterLevel(waterlevel, watercount);
    });
  }

  Future<void> loadWaterLevel() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      waterlevel = prefs.getDouble('waterlevel') ?? 0.0;
      watercount = prefs.getInt('watercount') ?? 0;
    });
  }

  Future<void> saveWaterLevel(double value, int value1) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('waterlevel', value);
    await prefs.setInt('watercount', value1);
    try {
      await FirebaseFirestore.instance
          .collection('watertrack')
          .doc(userId)
          .update({currentDate: value1});
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        // Document doesn't exist, so create it with the food entry for the current date
        await FirebaseFirestore.instance
            .collection('watertrack')
            .doc(userId)
            .set({currentDate: value1});
      } else {
        errorDialog(e.toString());
      }
    } catch (e) {
      errorDialog(e.toString());
    }
  }

  Future errorDialog(String error) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          backgroundColor: Colors.green,
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

  Future<void> addFood(String addfood, double addcalories, double addcarbs,
      double addprotein, double addfats) async {
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
        ]),
      });
      Navigator.pop(context);
      errorDialog("Sucessfully submitted");
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
          ],
        });
        Navigator.pop(context);
        errorDialog("Sucessfully submitted");
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
    setState(() {
      foodcal = 0;
      carbs = 0;
      protein = 0;
      fats = 0;
      percentcal = 0;
      percentcarbs = 0;
      percentprotein = 0;
      percentfats = 0;
    });
    getFoodTrack();
  }

  void deleteFoodData(
    int index,
    String userId,
    String currentDate,
  ) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('foodtrack')
          .doc(userId)
          .get();
      if (snapshot.exists) {
        final data = snapshot.data();
        if (data != null) {
          final foodArray = data[currentDate] as List<dynamic>?;

          if (foodArray != null && foodArray.length > index) {
            final newArray = List<dynamic>.from(foodArray)..removeAt(index);

            await FirebaseFirestore.instance
                .collection('foodtrack')
                .doc(userId)
                .update({
              currentDate: newArray,
            });
          }
        }
      }
    } catch (e) {
      debugPrint('Error deleting food data: $e');
    }
    setState(() {
      foodcal = 0;
      carbs = 0;
      protein = 0;
      fats = 0;
      percentcal = 0;
      percentcarbs = 0;
      percentprotein = 0;
      percentfats = 0;
    });

    getFoodTrack();
  }

  Future showFoodDetails(
      String foodname,
      String servingsize,
      String measure,
      String calories,
      String carbs,
      String protein,
      String fats,
      int whichindex) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Food Details',
            style: textstyle,
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: 200,
            width: 450,
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
                  Text("Serving Size: $servingsize $measure", style: textstyle),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Calories: ${calories}kcal", style: textstyle),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Carbs: ${carbs}g", style: textstyle),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Protein: ${protein}g", style: textstyle),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Fats: ${fats}g", style: textstyle),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Index: $whichindex", style: textstyle),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                      child: const Text('Close'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        deleteFoodData(whichindex, userId, currentDate);
                        double testcal = double.parse(calories);
                        double testcarb = double.parse(carbs);
                        double testprotein = double.parse(protein);
                        double testfats = double.parse(fats);
                        addCal(
                          -testcal,
                          -testcarb,
                          -testprotein,
                          -testfats,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                      child: const Text('Delete'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Track your Calories",
          style: TextStyle(
            letterSpacing: 1.5,
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool refresh = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddFoodScreen();
              },
            ),
          );
          if (refresh) {
            setState(() {
              foodcal = 0;
              carbs = 0;
              protein = 0;
              fats = 0;
              percentcal = 0;
              percentcarbs = 0;
              percentprotein = 0;
              percentfats = 0;
            });
            getFoodTrack();
            setState(() {
              refresh = false;
            });
          }
          // if (foodcal != basecal) {
          //   addCal(600);
          // } else {
          //   errorDialog("All done");
          // }
          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return AlertDialog(
          //       title: Text(
          //         'Track Food',
          //         style: textstyle,
          //         textAlign: TextAlign.center,
          //       ),
          //       content: SizedBox(
          //         height: 350,
          //         width: 450,
          //         child: SingleChildScrollView(
          //           child: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: <Widget>[
          //               Text(
          //                 "Name of food",
          //                 style: textstyle,
          //               ),
          //               TextField(
          //                 controller: foodnamecontroller,
          //               ),
          //               const SizedBox(
          //                 height: 10,
          //               ),
          //               Text("Calories", style: textstyle),
          //               TextField(
          //                 controller: caloriescontroller,
          //               ),
          //               const SizedBox(
          //                 height: 10,
          //               ),
          //               Text("Carbs", style: textstyle),
          //               TextField(
          //                 controller: carbscontroller,
          //               ),
          //               const SizedBox(
          //                 height: 10,
          //               ),
          //               Text("Protein", style: textstyle),
          //               TextField(
          //                 controller: proteincontroller,
          //               ),
          //               Text("Fats", style: textstyle),
          //               TextField(
          //                 controller: fatscontroller,
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //       actions: <Widget>[
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: [
          //             Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: SizedBox(
          //                 width: 100,
          //                 height: 50,
          //                 child: ElevatedButton(
          //                   onPressed: () {
          //                     foodnamecontroller.clear();
          //                     caloriescontroller.clear();
          //                     carbscontroller.clear();
          //                     proteincontroller.clear();
          //                     fatscontroller.clear();
          //                     Navigator.of(context).pop();
          //                   },
          //                   style: ElevatedButton.styleFrom(
          //                     backgroundColor: Colors.teal,
          //                   ),
          //                   child: const Text('Close'),
          //                 ),
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: SizedBox(
          //                 width: 100,
          //                 height: 50,
          //                 child: ElevatedButton(
          //                   onPressed: () {
          //                     if (foodnamecontroller.text.isNotEmpty &&
          //                         caloriescontroller.text.isNotEmpty &&
          //                         carbscontroller.text.isNotEmpty &&
          //                         proteincontroller.text.isNotEmpty &
          //                             fatscontroller.text.isNotEmpty) {
          //                       addFood();
          //                     } else {
          //                       errorDialog("Please fill all fields");
          //                     }
          //                   },
          //                   style: ElevatedButton.styleFrom(
          //                     backgroundColor: Colors.teal,
          //                   ),
          //                   child: const Text('Submit'),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     );
          //   },
          // );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 300,
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const AllTrack(
                              page: 0,
                            );
                          },
                        ),
                      );
                    },
                    child: AspectRatio(
                      aspectRatio: 1.2,
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        margin: const EdgeInsets.only(
                            top: 20, left: 10, right: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 0.1, left: 10),
                              child: Text(
                                "Calories",
                                style: TextStyle(
                                  letterSpacing: 1.5,
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleProgress(
                                    percentcal: percentcal,
                                    foodcal: foodcal,
                                    basecal: basecal,
                                    remaining: remaining),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Base Goal",
                                      style: TextStyle(
                                        letterSpacing: 1,
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Text(
                                      "$basecal kcal",
                                      style: const TextStyle(
                                        letterSpacing: 1.5,
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    const Text(
                                      "Food",
                                      style: TextStyle(
                                        letterSpacing: 1,
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Text(
                                      "$foodcal kcal",
                                      style: const TextStyle(
                                        letterSpacing: 1.5,
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 1.4,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const AllTrack(
                                page: 1,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        margin: const EdgeInsets.only(
                            top: 20, left: 10, right: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 0.1, left: 10),
                              child: Text(
                                "Macro Nutrients",
                                style: TextStyle(
                                  letterSpacing: 1.5,
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MacroNutrients(
                                    basecarb: basecarbs,
                                    carb: carbs,
                                    perccarbs: percentcarbs,
                                    baseprot: baseprotein,
                                    prot: protein,
                                    percprot: percentprotein,
                                    basefat: basefats,
                                    fat: fats,
                                    percfats: percentfats),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const AllTrack(
                              page: 2,
                            );
                          },
                        ),
                      );
                    },
                    child: AspectRatio(
                      aspectRatio: 1.4,
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        margin: const EdgeInsets.only(
                            top: 20, left: 10, right: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 0.1, left: 10),
                              child: Text(
                                "Water",
                                style: TextStyle(
                                  letterSpacing: 1.5,
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 140,
                                  height: 140,
                                  child: LiquidCircularProgressIndicator(
                                    value: waterlevel,
                                    backgroundColor: Colors.white,
                                    valueColor: const AlwaysStoppedAnimation(
                                        Colors.tealAccent),
                                    center: Text(
                                      watercount == 10
                                          ? "😄"
                                          : watercount == 0
                                              ? "😔"
                                              : "$watercount/10",
                                      style: const TextStyle(
                                        letterSpacing: 1.5,
                                        fontSize: 22,
                                        color: Colors.teal,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 7, 255, 230),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Text(
                                      "+",
                                      style: TextStyle(
                                        letterSpacing: 1.5,
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    onPressed: () {
                                      incrementWaterLevel();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      decrementWaterLevel();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 7, 255, 230),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Text(
                                      "-",
                                      style: TextStyle(
                                        letterSpacing: 1.5,
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Colors.teal,
                  dotHeight: 10,
                  dotWidth: 10,
                  strokeWidth: 2,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "All foods: ",
                style: textstyle,
                textAlign: TextAlign.left,
              ),
            ),
            Flexible(
              //fit: FlexFit.loose,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('foodtrack')
                    .doc(userId)
                    .snapshots(),
                builder: (context, snapshot) {
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

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text(
                        "No food added",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  if (snapshot.data!.exists) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    if (data.containsKey(currentDate)) {
                      List<dynamic> foodEntries = data[currentDate];
                      if (foodEntries.isEmpty) {
                        return const Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Icon(
                                Icons.fastfood,
                                size: 40,
                                color: Colors.teal,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Use below button to track!",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: foodEntries.length,
                        shrinkWrap: true,

                        itemBuilder: (BuildContext context, int index) {
                          return FoodLogCard(
                            foodname: foodEntries[index]["foodname"],
                            totalcalories: foodEntries[index]["calories"],
                            press: () {
                              showFoodDetails(
                                foodEntries[index]["foodname"],
                                foodEntries[index]["servingSize"],
                                foodEntries[index]["measure"],
                                foodEntries[index]["calories"],
                                foodEntries[index]["carbs"],
                                foodEntries[index]["protein"],
                                foodEntries[index]["fats"],
                                index,
                              );
                            },
                            // icontap: () {
                            //   deleteFoodData(index, userId, currentDate);
                            // },
                          );
                        },
                        // add this line to show a message if the list is empty
                      );
                    } else {
                      return const Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Icon(
                              Icons.fastfood,
                              size: 40,
                              color: Colors.teal,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Use below button to track!",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  } else {
                    return const Center(
                      child: Text(
                        "No food added",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodLogCard extends StatelessWidget {
  const FoodLogCard({
    Key? key,
    required this.foodname,
    required this.totalcalories,
    required this.press,
    // required this.icontap,
  }) : super(key: key);
  final String foodname;
  final String totalcalories;
  final VoidCallback press;
  // final VoidCallback icontap;

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
          onTap: press,
          // trailing: IconButton(
          //   icon: const Icon(
          //     Icons.delete,
          //     color: Colors.white,
          //     size: 25,
          //   ),
          //   onPressed: icontap,
          // ),
        ),
      ),
    );
  }
}
