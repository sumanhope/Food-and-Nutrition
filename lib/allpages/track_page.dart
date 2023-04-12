import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodandnutrition/allpages/home_page.dart';
import 'package:foodandnutrition/utils/foodcard.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TrackPage extends StatefulWidget {
  const TrackPage({super.key});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  final _controller = PageController();
  final foodnamecontroller = TextEditingController();
  final caloriescontroller = TextEditingController();
  final carbscontroller = TextEditingController();
  final proteincontroller = TextEditingController();
  final fatscontroller = TextEditingController();
  var textstyle = const TextStyle(
    letterSpacing: 1.5,
    fontSize: 14,
    color: Colors.teal,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
  );
  Widget _circleProgress() {
    return SizedBox(
      width: 170,
      height: 170,
      child: Stack(
        children: [
          SizedBox(
            width: 170,
            height: 170,
            child: CircularProgressIndicator(
              strokeWidth: 8,
              value: 0.72,
              backgroundColor: Colors.white10.withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromARGB(88, 242, 242, 242),
                  width: 6,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                ),
                child: Container(
                  margin: const EdgeInsets.all(22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Remaining",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        "1,112",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        "kcal",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _macronutrients() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _marconutrientsTile(
          title: 'Carbs',
          percentValue: 0.5,
          amountInGram: '14/323g',
        ),
        const SizedBox(
          height: 5,
        ),
        _marconutrientsTile(
          title: 'Protein',
          percentValue: 0.7,
          amountInGram: '14/129g',
        ),
        const SizedBox(
          height: 5,
        ),
        _marconutrientsTile(
          title: 'Fats',
          percentValue: 0.4,
          amountInGram: '14/85g',
        ),
      ],
    );
  }

  Widget _marconutrientsTile(
      {required String title,
      required double percentValue,
      required amountInGram}) {
    return SizedBox(
      height: 60,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          LinearPercentIndicator(
            width: 200,
            animation: true,
            lineHeight: 6,
            animationDuration: 1500,
            percent: percentValue,
            barRadius: const Radius.circular(3),
            padding: EdgeInsets.zero,
            backgroundColor:
                const Color.fromARGB(184, 255, 255, 255).withOpacity(0.3),
            progressColor: Colors.white,
          ),
          Text(
            amountInGram,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
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

  @override
  void initState() {
    super.initState();
    loadWaterLevel();
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

  Future addFood() async {
    try {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      await FirebaseFirestore.instance.collection('foodtrack').doc().set({
        "foodname": foodnamecontroller.text,
        "calories": caloriescontroller.text,
        "carbs": carbscontroller.text,
        "protein": proteincontroller.text,
        "fats": fatscontroller.text
      }).then((value) {
        Navigator.pop(context);
        errorDialog("Sucessfully submitted");
        foodnamecontroller.clear();
        caloriescontroller.clear();
        carbscontroller.clear();
        proteincontroller.clear();
        fatscontroller.clear();
      });
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      errorDialog(e.toString());
    }
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
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Track Food',
                  style: textstyle,
                  textAlign: TextAlign.center,
                ),
                content: SizedBox(
                  height: 350,
                  width: 450,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Name of food",
                          style: textstyle,
                        ),
                        TextField(
                          controller: foodnamecontroller,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Calories", style: textstyle),
                        TextField(
                          controller: caloriescontroller,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Carbs", style: textstyle),
                        TextField(
                          controller: carbscontroller,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Protein", style: textstyle),
                        TextField(
                          controller: proteincontroller,
                        ),
                        Text("Fats", style: textstyle),
                        TextField(
                          controller: fatscontroller,
                        ),
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
                              foodnamecontroller.clear();
                              caloriescontroller.clear();
                              carbscontroller.clear();
                              proteincontroller.clear();
                              fatscontroller.clear();
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
                              if (foodnamecontroller.text.isNotEmpty &&
                                  caloriescontroller.text.isNotEmpty &&
                                  carbscontroller.text.isNotEmpty &&
                                  proteincontroller.text.isNotEmpty &
                                      fatscontroller.text.isNotEmpty) {
                                addFood();
                              } else {
                                errorDialog("Please fill all fields");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                            ),
                            child: const Text('Submit'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
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
                  AspectRatio(
                    aspectRatio: 1.2,
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      margin: const EdgeInsets.only(
                          top: 20, left: 10, right: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _circleProgress(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
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
                                    "3,000 kcal",
                                    style: TextStyle(
                                      letterSpacing: 1.5,
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  Text(
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
                                    "1,888 kcal",
                                    style: TextStyle(
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 1.4,
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      margin: const EdgeInsets.only(
                          top: 20, left: 10, right: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
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
                              _macronutrients(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 1.4,
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      margin: const EdgeInsets.only(
                          top: 20, left: 10, right: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
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
                                    backgroundColor:
                                        const Color.fromARGB(255, 7, 255, 230),
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
                                    backgroundColor:
                                        const Color.fromARGB(255, 7, 255, 230),
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
                      .collection("foodtrack")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text("Something is wrong"),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "No food added",
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
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        DocumentSnapshot docs = snapshot.data!.docs[index];
                        return Smallcards(
                            foodname: docs["foodname"],
                            totalcalories: docs["calories"],
                            press: () {});
                      }),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
