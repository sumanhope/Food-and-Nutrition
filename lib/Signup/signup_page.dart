// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../Verification/emailverification_page.dart';

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
  final gendercontroller = TextEditingController();
  final dobcontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final heightcontroller = TextEditingController();
  final weightcontroller = TextEditingController();
  DateTime today = DateTime.now();

  final FirebaseAuth auth = FirebaseAuth.instance;
  var _text, texttwo;

  @override
  void dispose() {
    fullnamecontroller.dispose();
    usernamecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
    gendercontroller.dispose();
    dobcontroller.dispose();
    agecontroller.dispose();
    heightcontroller.dispose();
    weightcontroller.dispose();

    super.dispose();
  }

  Future signIn() async {
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (context) {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     });
    // addUser(
    //   fullnamecontroller.text.trim(),
    //   usernamecontroller.text.trim(),
    //   emailcontroller.text.trim(),
    //   int.parse(agecontroller.text.trim()),
    //   int.parse(heightcontroller.text.trim()),
    //   int.parse(weightcontroller.text.trim()),
    // );
    try {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      );
      final User user = auth.currentUser!;
      final uid = user.uid;
      String dateStr = "${today.day}-${today.month}-${today.year}";

      debugPrint(dateStr);
      FirebaseFirestore.instance.collection('users').doc(uid).set({
        'UserId': uid,
        'fullname': fullnamecontroller.text.trim(),
        'username': usernamecontroller.text.trim(),
        'email': emailcontroller.text.trim(),
        'gender': gendercontroller.text.trim(),
        'DOB': dobcontroller.text.trim(),
        'age': int.parse(agecontroller.text.trim()),
        'height': int.parse(heightcontroller.text.trim()),
        'weight': int.parse(weightcontroller.text.trim()),
        'register': dateStr,
        'before': '',
        'after': '',
        'profile': ''
      }).then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const EmailVerifyScreen(),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      errorDialog(e.toString());
    }
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
  var labelstyle = const TextStyle(
    color: Colors.teal,
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

    if (text.length < 7) {
      return 'Too short (need ${7 - text.length} more letters)';
    }
    // return null if the text is valid
    return "Done";
  }

  String? get errorText {
    // at any time, we can get the text from _controller.value.text
    final text = confirmpasswordcontroller.value.text;

    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Required';
    }

    if (text.length < 7) {
      return 'Too short (need ${7 - text.length} more letters)';
    }
    // return null if the text is valid
    return "Done";
  }

  bool formone() {
    if (fullnamecontroller.text.isNotEmpty &&
        usernamecontroller.text.isNotEmpty &&
        emailcontroller.text.isNotEmpty &&
        passwordcontroller.text.isNotEmpty &&
        confirmpasswordcontroller.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool formtwo() {
    if (gendercontroller.text.isNotEmpty &&
        agecontroller.text.isNotEmpty &&
        dobcontroller.text.isNotEmpty &&
        heightcontroller.text.isNotEmpty &&
        weightcontroller.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future errorDialog(String error) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          backgroundColor: const Color.fromARGB(121, 53, 233, 215),
          elevation: 5,
          title: Text(
            error,
            style: const TextStyle(
              letterSpacing: 1.5,
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        gestures: const [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
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
                      if (currentStep == 0) {
                        if (formone()) {
                          if (passwordConfirmed()) {
                            if (passwordcontroller.text.length > 6) {
                              setState(() => currentStep += 1);
                            } else {
                              errorDialog(
                                  "Password should be more than 6 characters");
                            }
                          } else {
                            errorDialog("Password doesnot match");
                          }
                        } else {
                          errorDialog("Please fill all the details");
                        }
                      } else if (currentStep == 1) {
                        if (formtwo()) {
                          setState(() => currentStep += 1);
                        } else {
                          errorDialog("Please fill all the details");
                        }
                      }
                    }
                  },
                  onStepTapped: (step) => setState(() => currentStep = step),
                  onStepCancel: currentStep == 0
                      ? null
                      : () => setState(() => currentStep -= 1),
                  controlsBuilder: (context, details) {
                    return Container(
                      margin: const EdgeInsets.only(top: 20, right: 5),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          if (currentStep != 0)
                            Expanded(
                              child: ElevatedButton(
                                onPressed: details.onStepCancel,
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
                                child: Text(
                                  'Back',
                                  style: textstyle,
                                ),
                              ),
                            ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: details.onStepContinue,
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
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: fullnamecontroller,
                  style: steptextstyle,
                  decoration: InputDecoration(
                    enabledBorder: unfocuseborder,
                    focusedBorder: focuseborder,
                    labelText: 'Full name',
                    labelStyle: labelstyle,
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
                    labelStyle: labelstyle,
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
                    labelStyle: labelstyle,
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
                    labelStyle: labelstyle,
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
                    labelStyle: labelstyle,
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
                  controller: gendercontroller,
                  style: steptextstyle,
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    labelStyle: labelstyle,
                    enabledBorder: unfocuseborder,
                    focusedBorder: focuseborder,
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              box(),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: dobcontroller,
                  style: steptextstyle,
                  decoration: InputDecoration(
                    labelText: 'DOB',
                    labelStyle: labelstyle,
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
                  controller: agecontroller,
                  style: steptextstyle,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    labelStyle: labelstyle,
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
                    labelText: 'Height (cm)',
                    labelStyle: labelstyle,
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
                    labelText: 'Weight (kg)',
                    labelStyle: labelstyle,
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
            'Full name : ${fullnamecontroller.text}\nUsername : ${usernamecontroller.text}\nEmail : ${emailcontroller.text}\nPassword : ${passwordcontroller.text}\nConfirmPassword : ${confirmpasswordcontroller.text}\nGender : ${gendercontroller.text}\nDate of Birth : ${dobcontroller.text}\nAge: ${agecontroller.text}\nHeight : ${heightcontroller.text}\nweight : ${weightcontroller.text}',
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
