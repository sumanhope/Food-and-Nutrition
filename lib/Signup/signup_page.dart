import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  int currentStep = 0;
  final fullname = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();
  final dob = TextEditingController();
  final height = TextEditingController();
  final weight = TextEditingController();
  final unit = TextEditingController();

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
                      //send data to server from here
                    } else {
                      setState(() => currentStep += 1);
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
                          Expanded(
                            child: ElevatedButton(
                              onPressed: details.onStepContinue,
                              child: Text(
                                'Next',
                                style: textstyle,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
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
                  controller: fullname,
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
                  controller: username,
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
                  controller: email,
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
                height: 50,
                child: TextFormField(
                  controller: password,
                  style: steptextstyle,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    enabledBorder: unfocuseborder,
                    focusedBorder: focuseborder,
                  ),
                ),
              ),
              box(),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: confirmpassword,
                  style: steptextstyle,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    enabledBorder: unfocuseborder,
                    focusedBorder: focuseborder,
                  ),
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
                  controller: dob,
                  style: steptextstyle,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    enabledBorder: unfocuseborder,
                    focusedBorder: focuseborder,
                  ),
                ),
              ),
              box(),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: height,
                  style: steptextstyle,
                  decoration: InputDecoration(
                    labelText: 'Height',
                    enabledBorder: unfocuseborder,
                    focusedBorder: focuseborder,
                  ),
                ),
              ),
              box(),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: weight,
                  style: steptextstyle,
                  decoration: InputDecoration(
                    labelText: 'Weight',
                    enabledBorder: unfocuseborder,
                    focusedBorder: focuseborder,
                  ),
                ),
              ),
              box(),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: unit,
                  style: steptextstyle,
                  decoration: InputDecoration(
                    labelText: 'Measurement Unit',
                    enabledBorder: unfocuseborder,
                    focusedBorder: focuseborder,
                  ),
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
            'Full name : ${fullname.text}\nUsername : ${username.text}\nEmail : ${email.text}\nPassword : ${password.text}\nConfirmPassword : ${confirmpassword.text}\nDate of Birth : ${dob.text}\nHeight : ${height.text}\nweight : ${weight.text}\nUnit : ${unit.text}',
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
