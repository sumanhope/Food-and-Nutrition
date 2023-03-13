import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  //String foodname = "Rice";
  String calories = "0";
  String foodCat = "";
  String foodDesc = "";
  String servSize = "0";
  String imageurl = "";
  bool isfav = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    final DocumentSnapshot foodDoc = await FirebaseFirestore.instance
        .collection('food')
        .doc(widget.foodId)
        .get();
    setState(() {
      imageurl = foodDoc.get('imageurl');
      foodCat = foodDoc.get('foodCategory');
      foodDesc = foodDoc.get('foodDescription');
      servSize = foodDoc.get('servingSize');
      calories = foodDoc.get('calories');
      favornot();
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
      onError: (e) => print("Error updating document $e"),
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
          (value) => print("Removed from Fav"),
          onError: (e) => print("Error updating document $e"),
        );
  }

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
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Container(
                    alignment: Alignment.center,
                    width: 350,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(16),
                      image: imageurl != ""
                          ? DecorationImage(
                              image: NetworkImage(imageurl),
                              fit: BoxFit.fill,
                            )
                          : const DecorationImage(
                              image: AssetImage("images/box.png"),
                              fit: BoxFit.cover,
                            ),
                      //color: const Color.fromARGB(94, 68, 137, 255),
                    )),
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
                      "Serving Size: $servSize",
                      style: const TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    box,
                    Text(
                      "Food Description: $foodDesc",
                      style: const TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    box,
                    Text(
                      "Calories: $calories",
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
                    const Text(
                      "Vitam A: ",
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    box,
                    const Text(
                      "Total Crab:",
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    box,
                    const Text(
                      "Iron: ",
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    box,
                    const Text(
                      "Sugar: ",
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    box,
                    const Text(
                      "Vitamin D: ",
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
