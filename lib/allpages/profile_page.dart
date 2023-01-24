// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";

import '../Welcome/welcome_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  height: 115,
                  width: 150,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("images/kayo.jpg"),
                  ),
                ),
                Stack(
                  children: [
                    Text(
                      user.email.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30.0, right: 10.0),
                      child: Text(
                        "Age",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 60.0, right: 12.0),
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
                          FirebaseAuth.instance.signOut();
                        },
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 60.0, left: 20.0),
                        child: TextButton(
                          child: Icon(
                            Icons.edit_note,
                            size: 40,
                            color: Colors.teal,
                          ),
                          onPressed: () {},
                        )),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(
              height: 5,
              thickness: 2,
              color: Colors.black,
            ),
            ProfileMenu(
              firsticon: Icons.person,
              text: "Username",
              secondicon: Icons.chevron_right_sharp,
              press: () {},
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
              press: () {},
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
          padding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Color.fromARGB(255, 219, 223, 222),
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
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: Colors.teal,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            Spacer(),
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
