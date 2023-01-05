import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          appBar: AppBar(
            title: const Text("Sign Up"),
            centerTitle: true,
          ),
          body: Theme(
            data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(primary: Colors.teal)),
            child: Stepper(
              type: StepperType.horizontal,
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
                  decoration: const InputDecoration(
                    labelText: 'Full name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              box(),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: username,
                  style: steptextstyle,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              box(),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: email,
                  style: steptextstyle,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              box(),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: password,
                  style: steptextstyle,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              box(),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: confirmpassword,
                  style: steptextstyle,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
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
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              box(),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: height,
                  style: steptextstyle,
                  decoration: const InputDecoration(
                    labelText: 'Height',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              box(),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: weight,
                  style: steptextstyle,
                  decoration: const InputDecoration(
                    labelText: 'Weight',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              box(),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: unit,
                  style: steptextstyle,
                  decoration: const InputDecoration(
                    labelText: 'Measurement Unit',
                    border: OutlineInputBorder(),
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
          content: Container(
            child: Text(
              'Full name : ${fullname.text}\nUsername : ${username.text}\nEmail : ${email.text}\nPassword : ${password.text}\nConfirmPassword : ${confirmpassword.text}\nDate of Birth : ${dob.text}\nHeight : ${height.text}\nweight : ${weight.text}\nUnit : ${unit.text}',
              style: steptextstyle,
            ),
          ),
        ),
      ];
}
