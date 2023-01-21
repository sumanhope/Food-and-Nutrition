// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:foodandnutrition/Login/login_page.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class ResetVerifyScreen extends StatelessWidget {
  ResetVerifyScreen({
    super.key,
    required this.useremail,
  });
  final String useremail;

  var box = const SizedBox(
    height: 20,
  );

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        gestures: const [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: Scaffold(
          body: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                Stack(
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: ClipPath(
                        clipper: MovieTicketClipper(),
                        child: Container(
                          color: Colors.teal,
                          height: 110,
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: MovieTicketClipper(),
                      child: Container(
                        color: Colors.teal,
                        height: 100,
                      ),
                    ),
                  ],
                ),
                box,
                const SizedBox(
                  child: Icon(
                    Icons.email_outlined,
                    size: 150,
                    color: Colors.teal,
                  ),
                ),
                box,
                const Text(
                  "Check Your Mail",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    color: Colors.teal,
                  ),
                ),
                box,
                const Text(
                  "We have send a password recover",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Colors.teal,
                  ),
                ),
                const Text(
                  "instruction to your email",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Colors.teal,
                  ),
                ),
                box,
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        debugPrint("Clicked Resend\n Email:$useremail");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 150, 135),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: const BorderSide(
                          width: 3,
                          color: Color.fromARGB(88, 0, 0, 0),
                        ),
                      ),
                      child: const Text(
                        "Resend",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      )),
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextButton(
                    child: const Text(
                      "Skip, I'll confirm later.",
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const LoginScreen();
                      }));
                    },
                  ),
                ),
                box,
                const Text(
                  "Didn't receive email? Check spam filter",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Colors.teal,
                  ),
                ),
                const Text(
                  "or try another email?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
