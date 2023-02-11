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
  final fooddesccontroller = TextEditingController();
  final servsizecontroller = TextEditingController();
  final calcontroller = TextEditingController();

  Future submitfood(String id, String name, String size, String desc,
      String cat, String cal) async {
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
        'foodDescription': desc,
        'servingSize': size,
        'calories': cal,
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
                  controller: fooddesccontroller,
                  decoration: const InputDecoration(labelText: "Food Desc"),
                ),
                TextField(
                  controller: servsizecontroller,
                  decoration: const InputDecoration(labelText: "Food Size"),
                ),
                TextField(
                  controller: calcontroller,
                  decoration: const InputDecoration(labelText: "Food Cal"),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      submitfood(
                          foodidcontroller.text,
                          foodnamecontroller.text,
                          servsizecontroller.text,
                          fooddesccontroller.text,
                          foodcatcontroller.text,
                          calcontroller.text);
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
