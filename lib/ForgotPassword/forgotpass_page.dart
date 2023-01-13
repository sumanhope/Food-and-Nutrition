import "package:flutter/material.dart";
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:foodandnutrition/Login/login_page.dart';
import 'package:foodandnutrition/Verification/resetverification.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  var box = const SizedBox(
    height: 20,
  );
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
  }

  Widget buildUser() {
    return TextField(
      controller: emailController,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(117, 100, 255, 219),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide:
              BorderSide(color: Color.fromRGBO(77, 182, 172, 1), width: 3),
        ),
        labelText: 'Email',
        labelStyle: const TextStyle(
          color: Colors.teal,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),

        prefixIcon: const Icon(
          Icons.email,
          color: Colors.teal,
          size: 30,
        ),
        suffixIcon: emailController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => emailController.clear(),
              ),
        //prefixIconColor: Colors.teal,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.teal, width: 3),
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontFamily: 'Poppins',
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
    );
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        gestures: const [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: Scaffold(
          body: Column(
            children: [
              Stack(
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: ClipPath(
                      clipper: MovieTicketClipper(),
                      child: Container(
                        color: Colors.teal,
                        height: 150,
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: MovieTicketClipper(),
                    child: Container(
                      color: Colors.teal,
                      height: 130,
                    ),
                  ),
                ],
              ),
              box,
              Container(
                alignment: const Alignment(-0.8, 0.5),
                child: const Text(
                  "Reset Password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.teal,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              box,
              Container(
                alignment: const Alignment(0, 0.5),
                child: const Text(
                  "Enter the email assoociated with your account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color.fromARGB(197, 2, 68, 62),
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Container(
                alignment: const Alignment(-0.4, 0.5),
                child: const Text(
                  "and we'll send an email with instructions to",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color.fromARGB(197, 2, 68, 62),
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Container(
                alignment: const Alignment(-0.8, 0.5),
                child: const Text(
                  "reset your password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color.fromARGB(197, 2, 68, 62),
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              box,
              Container(
                alignment: const Alignment(60, 1),
                child: const Text(
                  "Email address                                                           ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.teal,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                child: Column(
                  children: [
                    buildUser(),
                    box,
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          debugPrint("OTP: ${emailController.text}");
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const ResetVerifyScreen();
                              },
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 0, 150, 135),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: const BorderSide(
                            width: 3,
                            color: Color.fromARGB(88, 0, 0, 0),
                          ),
                        ),
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: TextButton(
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const LoginScreen();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
