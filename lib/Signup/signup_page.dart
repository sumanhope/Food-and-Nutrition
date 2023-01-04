import 'package:flutter/material.dart';
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
          body: Stepper(
            //type: StepperType.horizontal,
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
            onStepCancel: currentStep == 0
                ? null
                : () => setState(() => currentStep -= 1),
          ),
        ),
      );

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          title: const Text("Account"),
          content: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full name'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
              ),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          title: const Text("BMI"),
          content: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Date of Birth'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Height'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Weight'),
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Measurement Units'),
              ),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          title: const Text("Confirm"),
          content: Container(),
        ),
      ];
}
