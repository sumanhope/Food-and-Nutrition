import 'package:cloud_firestore/cloud_firestore.dart';
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
      isfav = foodDoc.get('favorite');
    });
  }

  Future<void> favtoggle() async {
    setState(() {
      if (isfav) {
        isfav = false;
      } else {
        isfav = true;
      }
    });
    final usercollection = FirebaseFirestore.instance.collection('food');
    final docRef = usercollection.doc(widget.foodId);

    try {
      await docRef.update({"favorite": isfav});
    } catch (e) {
      debugPrint("some error occured $e");
    }
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
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Container(
                    //alignment: Alignment.center,
                    width: 390,
                    height: 250,
                    decoration: BoxDecoration(
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
                        color: Colors.teal,
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
                      color: Colors.teal,
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
                        color: Colors.teal,
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
                        color: Colors.teal,
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
                        color: Colors.teal,
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
                        color: Colors.teal,
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
                        color: Colors.teal,
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
                        color: Colors.teal,
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
                        color: Colors.teal,
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
                        color: Colors.teal,
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
                        color: Colors.teal,
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
                        color: Colors.teal,
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
