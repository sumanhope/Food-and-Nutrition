import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:foodandnutrition/ForgotPassword/changepass_page.dart';
import 'package:foodandnutrition/ProfileOptions/alldetails.dart';

import '../Welcome/welcome_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User user = FirebaseAuth.instance.currentUser!;
  String _uid = " ";
  String name = "Loading";
  int age = 0;
  String username = "Loading";
  int height = 0;
  int weight = 0;
  String email = "Loading";
  String gender = "Loading";
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    _uid = user.uid;

    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      name = userDoc.get('fullname');
      age = userDoc.get('age');
      username = userDoc.get('username');
      height = userDoc.get('height');
      weight = userDoc.get('weight');
      email = userDoc.get('email');
      gender = userDoc.get('gender');
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Profile",
            style: TextStyle(
              letterSpacing: 1.5,
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    height: 115,
                    width: 150,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("images/kayo.jpg"),
                    ),
                  ),
                  Stack(
                    children: [
                      Text(
                        // user.email.toString(),
                        username,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30.0, right: 10.0),
                        child: Text(
                          '$age',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20.0, right: 12.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // FirebaseAuth.instance.signOut().then((value) {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: ((context) => const WelcomeScreen()),
                        //     ),
                        //   );
                        // });
                        FirebaseAuth.instance.signOut().then((value) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WelcomeScreen(),
                            ),
                          );
                        });
                      },
                      child: const Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Divider(
                height: 5,
                thickness: 2,
                color: Colors.black,
              ),
              ProfileMenu(
                firsticon: Icons.person,
                text: name,
                secondicon: Icons.chevron_right_sharp,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewDetails(
                        userid: _uid,
                        username: username,
                        fullname: name,
                        age: age,
                        height: height,
                        weight: weight,
                        email: email,
                        gender: gender,
                      ),
                    ),
                  );
                },
              ),
              ProfileMenu(
                firsticon: Icons.favorite,
                text: "Favorites",
                secondicon: Icons.chevron_right_sharp,
                press: () {},
              ),
              ProfileMenu(
                firsticon: Icons.camera_alt,
                text: "Before and After",
                secondicon: Icons.chevron_right_sharp,
                press: () {},
              ),
              ProfileMenu(
                firsticon: Icons.settings,
                text: "App settings",
                secondicon: Icons.chevron_right_sharp,
                press: () {},
              ),
              ProfileMenu(
                firsticon: Icons.security,
                text: "Password and Security",
                secondicon: Icons.chevron_right_sharp,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePassScreen()),
                  );
                },
              ),
              ProfileMenu(
                firsticon: Icons.notifications,
                text: "Notification",
                secondicon: Icons.chevron_right_sharp,
                press: () {},
              ),
              ProfileMenu(
                firsticon: Icons.share,
                text: "Share with your friends",
                secondicon: Icons.chevron_right_sharp,
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  final String text;
  final IconData firsticon, secondicon;
  final VoidCallback press;
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.firsticon,
    required this.secondicon,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: const Color.fromARGB(73, 0, 150, 135),
        ),
        onPressed: press,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              firsticon,
              size: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.teal,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const Spacer(),
            Icon(
              secondicon,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
