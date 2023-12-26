import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodandnutrition/Homepage/landing.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class EditDetails extends StatefulWidget {
  const EditDetails({
    super.key,
    required this.userid,
    required this.username,
    required this.fullname,
    required this.email,
    required this.age,
    required this.height,
    required this.weight,
    required this.gender,
    required this.calories,
  });
  final String userid;
  final String username;
  final String fullname;
  final String email;
  final int age;
  final int height;
  final int weight;
  final String gender;
  final double calories;

  @override
  State<EditDetails> createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  var fullnamecontroller = TextEditingController();
  final usernamecontroller = TextEditingController();
  final caloriescontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final gendercontroller = TextEditingController();
  final heightcontroller = TextEditingController();
  final weightcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  void checkfield() {
    String uid, name, username, email, calories, age, gender, height, weight;
    uid = widget.userid;
    name = fullnamecontroller.text.trim().isEmpty
        ? widget.fullname
        : fullnamecontroller.text.trim();
    username = usernamecontroller.text.trim().isEmpty
        ? widget.username
        : usernamecontroller.text.trim();
    email = widget.email;
    calories = caloriescontroller.text.trim().isEmpty
        ? "${widget.calories}"
        : caloriescontroller.text.trim();
    age = agecontroller.text.trim().isEmpty
        ? "${widget.age}"
        : agecontroller.text.trim();
    gender = gendercontroller.text.trim().isEmpty
        ? widget.gender
        : gendercontroller.text.trim();
    height = heightcontroller.text.trim().isEmpty
        ? "${widget.height}"
        : heightcontroller.text.trim();
    weight = weightcontroller.text.trim().isEmpty
        ? "${widget.weight}"
        : weightcontroller.text.trim();
    debugPrint(
        "$uid,$name,$username,$email,$calories,$age,$gender,$height,$weight");
    updateuser(uid, name, username, calories, int.parse(age), gender,
        int.parse(height), int.parse(weight));
  }

  Future updateuser(
    String uid,
    String fullname,
    String username,
    String calories,
    int age,
    String gender,
    int height,
    int weight,
  ) async {
    final usercollection = FirebaseFirestore.instance.collection('users');
    final docRef = usercollection.doc(uid);

    try {
      await docRef.update({
        "username": username,
        "fullname": fullname,
        "age": age,
        "basecalories": calories,
        "gender": gender,
        "height": height,
        "weight": weight
      }).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LandingPage()),
        );
      });
    } catch (e) {
      debugPrint("some error occured $e");
    }
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
          gestures: const [
            GestureType.onTap,
            GestureType.onPanUpdateDownDirection,
          ],
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              title: const Text(
                "Edit Details",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                      ),
                    ),
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Only fill field ",
                          style: TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          "you want to edit",
                          style: TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Editfield(
                    labeltext: "Full name",
                    hinttext: widget.fullname,
                    cont: fullnamecontroller,
                  ),
                  Editfield(
                    labeltext: "Username",
                    hinttext: widget.username,
                    cont: usernamecontroller,
                  ),
                  Editfield(
                    labeltext: "Base Calories",
                    hinttext: "${widget.calories}",
                    cont: caloriescontroller,
                  ),
                  Editfield(
                    labeltext: "Age",
                    hinttext: "${widget.age}",
                    cont: agecontroller,
                  ),
                  Editfield(
                    labeltext: "Gender",
                    hinttext: widget.gender,
                    cont: gendercontroller,
                  ),
                  Editfield(
                    labeltext: "Height (cm)",
                    hinttext: "${widget.height}",
                    cont: heightcontroller,
                  ),
                  Editfield(
                    labeltext: "Weight (kg)",
                    hinttext: "${widget.weight}",
                    cont: weightcontroller,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(101, 0, 150, 135),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: const BorderSide(width: 2, color: Colors.teal),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: checkfield,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: const BorderSide(
                                width: 2, color: Color.fromARGB(135, 0, 0, 0)),
                          ),
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              letterSpacing: 1.5,
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ));
}

class Editfield extends StatelessWidget {
  const Editfield({
    Key? key,
    required this.labeltext,
    required this.hinttext,
    required this.cont,
  }) : super(key: key);
  final String labeltext;
  final String hinttext;
  final TextEditingController cont;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labeltext,
            style: const TextStyle(
              fontSize: 15,
              //color: Colors.teal,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          TextField(
            controller: cont,
            decoration: InputDecoration(hintText: hinttext),
            style: TextStyle(
              color: Theme.of(context).unselectedWidgetColor,
              fontSize: 15,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
