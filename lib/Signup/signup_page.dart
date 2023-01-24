// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:foodandnutrition/Homepage/landing.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  int currentStep = 0;
  final fullnamecontroller = TextEditingController();
  final usernamecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final heightcontroller = TextEditingController();
  final weightcontroller = TextEditingController();

  var _text, texttwo;

  @override
  void dispose() {
    fullnamecontroller.dispose();
    usernamecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
    agecontroller.dispose();
    heightcontroller.dispose();
    weightcontroller.dispose();
    super.dispose();
  }

  Future signIn() async {
    if (passwordConfirmed()) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                content: Text(e.message.toString()),
              );
            });
      }

      addUser(
        fullnamecontroller.text.trim(),
        usernamecontroller.text.trim(),
        emailcontroller.text.trim(),
        int.parse(agecontroller.text.trim()),
        int.parse(heightcontroller.text.trim()),
        int.parse(weightcontroller.text.trim()),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const LandingPage();
          },
        ),
      );
    }
  }

  Future addUser(String fullname, String username, String email, int age,
      int height, int weight) async {
    await FirebaseFirestore.instance.collection('users').add({
      'full name': fullname,
      'username': username,
      'email': email,
      'age': age,
      'height': height,
      'weight': weight,
    });
  }

  bool passwordConfirmed() {
    if (passwordcontroller.text.trim() ==
        confirmpasswordcontroller.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  var textstyle = const TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
  );
  var steptextstyle = const TextStyle(
    color: Colors.teal,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
  );
  var unfocuseborder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: Color.fromRGBO(77, 182, 172, 1), width: 3),
  );
  var focuseborder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: Colors.teal, width: 3),
  );

  box() {
    return const SizedBox(
      height: 20,
    );
  }

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = passwordcontroller.value.text;

    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Required';
    }
    if (text.length < 6) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }

  String? get errorText {
    // at any time, we can get the text from _controller.value.text
    final text = confirmpasswordcontroller.value.text;

    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Required';
    }
    if (text.length < 6) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
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
                      clipper: OvalBottomBorderClipper(),
                      child: Container(
                        color: Colors.teal,
                        height: 110,
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: OvalBottomBorderClipper(),
                    child: Container(
                      color: Colors.teal,
                      height: 100,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              colorizeAnimation(),
              Expanded(
                child: Stepper(
                  type: StepperType.horizontal,
                  physics: const ScrollPhysics(),
                  steps: getSteps(),
                  currentStep: currentStep,
                  onStepContinue: () {
                    final isLastStep = currentStep == getSteps().length - 1;
                    if (isLastStep) {
                      debugPrint('Completed');
                      signIn();

                      //send data to server from here

                    } else {
                      if (passwordConfirmed() &&
                          (passwordcontroller.text != '' &&
                              confirmpasswordcontroller.text != '')) {
                        setState(() => currentStep += 1);
                      } else {
                        debugPrint("Password didnot match");
                      }
                    }
                  },
                  onStepTapped: (step) => setState(() => currentStep = step),
                  onStepCancel: currentStep == 0
                      ? null
                      : () => setState(() => currentStep -= 1),
                  controlsBuilder: (context, details) {
                    return Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Row(
                        children: [
                          if (currentStep != 0)
                            Expanded(
                              child: ElevatedButton(
                                onPressed: details.onStepCancel,
                                child: Text(
                                  'Back',
                                  style: textstyle,
                                ),
                              ),
                            ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: details.onStepContinue,
                              child: Text(
                                'Next',
                                style: textstyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text(
            "Account",
            style: steptextstyle,
          ),
          content: Column(
            children: [
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: fullnamecontroller,
                  style: steptextstyle,
                  decoration: InputDecoration(
                    enabledBorder: unfocuseborder,
                    focusedBorder: focuseborder,
                    labelText: 'Full name',
                  ),
                ),
              ),
              box(),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: usernamecontroller,
                  style: steptextstyle,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    enabledBorder: unfocuseborder,
                    focusedBorder: focuseborder,
                  ),
                ),
              ),
              box(),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: emailcontroller,
                  style: steptextstyle,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    enabledBorder: unfocuseborder,
                    focusedBorder: focuseborder,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              box(),
              SizedBox(
                height: 75,
                child: TextFormField(
                  controller: passwordcontroller,
                  style: steptextstyle,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(
                        color: Colors.teal,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                    labelText: 'Password',
                    enabledBorder: unfocuseborder,
                    focusedBorder: focuseborder,
                    errorBorder: unfocuseborder,
                    focusedErrorBorder: focuseborder,
                    errorText: _errorText,
                  ),
                  onChanged: (text) => setState(() => _text),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 75,
                child: TextFormField(
                  controller: confirmpasswordcontroller,
                  style: steptextstyle,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(
                        color: Colors.teal,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                    labelText: 'Confirm Password',
                    enabledBorder: unfocuseborder,
                    focusedBorder: focuseborder,
                    errorBorder: unfocuseborder,
                    focusedErrorBorder: focuseborder,
                    errorText: errorText,
                  ),
                  onChanged: (text) => setState(() => texttwo),
                ),
              ),
            ],
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text(
            "BMI",
            style: steptextstyle,
          ),
          content: Column(
            children: [
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: agecontroller,
                  style: steptextstyle,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    enabledBorder: unfocuseborder,
                    focusedBorder: focuseborder,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              box(),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: heightcontroller,
                  style: steptextstyle,
                  decoration: InputDecoration(
                    labelText: 'Height',
                    enabledBorder: unfocuseborder,
                    focusedBorder: focuseborder,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              box(),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: weightcontroller,
                  style: steptextstyle,
                  decoration: InputDecoration(
                    labelText: 'Weight',
                    enabledBorder: unfocuseborder,
                    focusedBorder: focuseborder,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          title: Text(
            "Confirm",
            style: steptextstyle,
          ),
          content: Text(
            'Full name : ${fullnamecontroller.text}\nUsername : ${usernamecontroller.text}\nEmail : ${emailcontroller.text}\nPassword : ${passwordcontroller.text}\nConfirmPassword : ${confirmpasswordcontroller.text}\nDate of Birth : ${agecontroller.text}\nHeight : ${heightcontroller.text}\nweight : ${weightcontroller.text}',
            style: steptextstyle,
          ),
        ),
      ];
}

Widget colorizeAnimation() {
  const colorizeColors = [
    Colors.teal,
    Color.fromRGBO(142, 249, 243, 0.533),
    Color.fromRGBO(219, 84, 97, 0.867),
    Color.fromRGBO(89, 60, 143, 0.333),
    Color.fromRGBO(23, 23, 56, 0.067),
  ];

  const colorizeTextStyle = TextStyle(
    color: Colors.teal,
    fontSize: 30,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
  );

  return Center(
    child: AnimatedTextKit(
      animatedTexts: [
        ColorizeAnimatedText(
          'Thank You',
          textStyle: colorizeTextStyle,
          colors: colorizeColors,
          textAlign: TextAlign.center,
          speed: const Duration(milliseconds: 250),
        ),
        ColorizeAnimatedText(
          'For Joining',
          textStyle: colorizeTextStyle,
          colors: colorizeColors,
          textAlign: TextAlign.center,
          speed: const Duration(milliseconds: 250),
        ),
        ColorizeAnimatedText(
          'Register Below',
          textStyle: colorizeTextStyle,
          colors: colorizeColors,
          textAlign: TextAlign.center,
          speed: const Duration(milliseconds: 250),
        ),
        ColorizeAnimatedText(
          'With Your Details',
          textStyle: colorizeTextStyle,
          colors: colorizeColors,
          textAlign: TextAlign.center,
          speed: const Duration(milliseconds: 250),
        ),
      ],
      repeatForever: true,
    ),
  );
}
