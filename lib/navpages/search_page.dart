import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodandnutrition/allpages/nutritional.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String foodname = "";
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
        labelText: 'Search',
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

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Search",
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
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                            return SearchCards(
                              foodname: data['foodName'].toString(),
                              category: data['foodCategory'].toString(),
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewData(
                                      foodId: data["foodId"].toString(),
                                      foodname: data["foodName"].toString(),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          if (data['foodName']
                              .toString()
                              .toLowerCase()
                              .startsWith(foodname.toLowerCase())) {
                            return SearchCards(
                              foodname: data['foodName'].toString(),
                              category: data['foodCategory'].toString(),
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewData(
                                      foodId: data["foodId"].toString(),
                                      foodname: data["foodName"].toString(),
                                    ),
                                  ),
                                );
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
    );
  }
}

class SearchCards extends StatelessWidget {
  const SearchCards({
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
