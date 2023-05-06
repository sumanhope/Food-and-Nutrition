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
  ) async {
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
      }).then((value) => Navigator.pop(context));
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
                ),
                TextField(
                  controller: calcontroller,
                  decoration: const InputDecoration(labelText: "Food Cal"),
                ),
                TextField(
                  controller: fatscontroller,
                  decoration: const InputDecoration(labelText: "Fats"),
                ),
                TextField(
                  controller: carbscontroller,
                  decoration: const InputDecoration(labelText: "Carbs"),
                ),
                TextField(
                  controller: fibercontroller,
                  decoration: const InputDecoration(labelText: "Fiber"),
                ),
                TextField(
                  controller: proteincontroller,
                  decoration: const InputDecoration(labelText: "Protein"),
                ),
                TextField(
                  controller: sugarcontroller,
                  decoration: const InputDecoration(labelText: "Sugar"),
                ),
                TextField(
                  controller: ironcontroller,
                  decoration: const InputDecoration(labelText: "Iron"),
                ),
                TextField(
                  controller: calciumcontroller,
                  decoration: const InputDecoration(labelText: "Calcium"),
                ),
                TextField(
                  controller: potassiumcontroller,
                  decoration: const InputDecoration(labelText: "Potassium"),
                ),
                TextField(
                  controller: vitaminAcontroller,
                  decoration: const InputDecoration(labelText: "Vitamin A"),
                ),
                TextField(
                  controller: vitaminCcontroller,
                  decoration: const InputDecoration(labelText: "Vitamin C"),
                ),
                TextField(
                  controller: vitaminDcontroller,
                  decoration: const InputDecoration(labelText: "Vitamin D"),
                ),
                TextField(
                  controller: measurecontroller,
                  decoration: const InputDecoration(labelText: "Vitamin D"),
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
                      );
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
