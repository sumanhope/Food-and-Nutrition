import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Addfood extends StatefulWidget {
  const Addfood({super.key});

  @override
  State<Addfood> createState() => _AddfoodState();
}

class _AddfoodState extends State<Addfood> {
  final foodidcontroller = TextEditingController();
  final foodnamecontroller = TextEditingController();
  final foodcatcontroller = TextEditingController();
  final servsizecontroller = TextEditingController();
  final calcontroller = TextEditingController();
  final fatscontroller = TextEditingController();
  final carbscontroller = TextEditingController();
  final fibercontroller = TextEditingController();
  final proteincontroller = TextEditingController();
  final sugarcontroller = TextEditingController();
  final ironcontroller = TextEditingController();
  final calciumcontroller = TextEditingController();
  final potassiumcontroller = TextEditingController();
  final vitaminAcontroller = TextEditingController();
  final vitaminCcontroller = TextEditingController();
  final vitaminDcontroller = TextEditingController();
  final measurecontroller = TextEditingController();
  final dietcontroller = TextEditingController();

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

  Future submitfood(
      String id,
      String name,
      double size,
      String cat,
      double cal,
      double fat,
      double carbs,
      double fiber,
      double protein,
      double sugar,
      double iron,
      double calcium,
      double potassium,
      double vitaminA,
      double vitaminC,
      double vitaminD,
      String measure,
      String diet) async {
    try {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      FirebaseFirestore.instance.collection('food').doc(id).set({
        'foodId': id,
        'foodName': name,
        'foodCategory': cat,
        'servingSize': size,
        'calories': cal,
        'fat': fat,
        'carb': carbs,
        'fiber': fiber,
        'sugar': sugar,
        'protein': protein,
        'iron': iron,
        'calcium': calcium,
        'potassium': potassium,
        'vitaminA': vitaminA,
        'vitaminC': vitaminC,
        'vitaminD': vitaminD,
        'measure': measure,
        'diet': diet,
      }).then(
        (value) {
          Navigator.pop(context);
          errorDialog("Food Added");
        },
      );
    } on Exception catch (e) {
      Navigator.pop(context);
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Food"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextField(
                  controller: foodidcontroller,
                  decoration: const InputDecoration(labelText: "Food Id"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: foodnamecontroller,
                  decoration: const InputDecoration(labelText: "Food Name"),
                ),
                TextField(
                  controller: foodcatcontroller,
                  decoration: const InputDecoration(labelText: "Food Cat"),
                ),
                TextField(
                  controller: servsizecontroller,
                  decoration: const InputDecoration(labelText: "Food Size"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: calcontroller,
                  decoration: const InputDecoration(labelText: "Food Cal"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: fatscontroller,
                  decoration: const InputDecoration(labelText: "Fats"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: carbscontroller,
                  decoration: const InputDecoration(labelText: "Carbs"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: fibercontroller,
                  decoration: const InputDecoration(labelText: "Fiber"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: proteincontroller,
                  decoration: const InputDecoration(labelText: "Protein"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: sugarcontroller,
                  decoration: const InputDecoration(labelText: "Sugar"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: ironcontroller,
                  decoration: const InputDecoration(labelText: "Iron"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: calciumcontroller,
                  decoration: const InputDecoration(labelText: "Calcium"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: potassiumcontroller,
                  decoration: const InputDecoration(labelText: "Potassium"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: vitaminAcontroller,
                  decoration: const InputDecoration(labelText: "Vitamin A"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: vitaminCcontroller,
                  decoration: const InputDecoration(labelText: "Vitamin C"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: vitaminDcontroller,
                  decoration: const InputDecoration(labelText: "Vitamin D"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: measurecontroller,
                  decoration: const InputDecoration(labelText: "Measurement"),
                ),
                TextField(
                  controller: dietcontroller,
                  decoration: const InputDecoration(labelText: "Diet Name"),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      submitfood(
                        foodidcontroller.text,
                        foodnamecontroller.text,
                        double.parse(servsizecontroller.text),
                        foodcatcontroller.text,
                        double.parse(calcontroller.text),
                        double.parse(fatscontroller.text),
                        double.parse(carbscontroller.text),
                        double.parse(fibercontroller.text),
                        double.parse(proteincontroller.text),
                        double.parse(sugarcontroller.text),
                        double.parse(ironcontroller.text),
                        double.parse(calciumcontroller.text),
                        double.parse(potassiumcontroller.text),
                        double.parse(vitaminAcontroller.text),
                        double.parse(vitaminCcontroller.text),
                        double.parse(vitaminDcontroller.text),
                        measurecontroller.text,
                        dietcontroller.text,
                      );
                      foodidcontroller.clear();
                      foodnamecontroller.clear();

                      foodcatcontroller.clear();
                      calcontroller.clear();
                      fatscontroller.clear();
                      carbscontroller.clear();
                      fibercontroller.clear();
                      proteincontroller.clear();
                      sugarcontroller.clear();
                      ironcontroller.clear();
                      calciumcontroller.clear();
                      potassiumcontroller.clear();
                      vitaminAcontroller.clear();
                      vitaminCcontroller.clear();
                      vitaminDcontroller.clear();
                      dietcontroller.clear();
                    },
                    child: const Text("Submit")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
