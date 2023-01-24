import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:foodandnutrition/Homepage/landing.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({super.key});

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  var box = const SizedBox(
    height: 20,
  );

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const LandingPage()
      : KeyboardDismisser(
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
                    "We have send a Verification link",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      color: Colors.teal,
                    ),
                  ),
                  const Text(
                    " on your email",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      color: Colors.teal,
                    ),
                  ),
                  box,
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton.icon(
                        onPressed:
                            canResendEmail ? sendVerificationEmail : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 0, 150, 135),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: const BorderSide(
                            width: 3,
                            color: Color.fromARGB(143, 0, 0, 0),
                          ),
                        ),
                        icon: const Icon(
                          Icons.email,
                          size: 20,
                        ),
                        label: const Text(
                          "Resend",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        )),
                  ),
                  box,
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: OutlinedButton(
                        onPressed: () => FirebaseAuth.instance.signOut(),
                        style: OutlinedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(198, 6, 201, 181),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: const BorderSide(
                            width: 3,
                            color: Colors.teal,
                          ),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        )),
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
