import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:foodandnutrition/ForgotPassword/forgotpass_page.dart';
import 'package:foodandnutrition/Homepage/home_page.dart';
import 'package:foodandnutrition/Signup/signup_page.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
//import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  String password = '';
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    usernameController.addListener(() => setState(() {}));
  }

  Widget buildUser() {
    return TextField(
      controller: usernameController,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(117, 100, 255, 219),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide:
              BorderSide(color: Color.fromRGBO(77, 182, 172, 1), width: 3),
        ),
        labelText: 'Username',
        labelStyle: const TextStyle(
          color: Colors.teal,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),

        prefixIcon: const Icon(
          Icons.person,
          color: Colors.teal,
          size: 30,
        ),
        suffixIcon: usernameController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => usernameController.clear(),
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

  Widget buildPassword() {
    return TextField(
      onChanged: (value) => setState(() => password = value),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(117, 100, 255, 219),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide:
              BorderSide(color: Color.fromRGBO(77, 182, 172, 1), width: 3),
        ),
        labelText: 'Password',
        labelStyle: const TextStyle(
          color: Colors.teal,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
        prefixIcon: const Icon(
          Icons.key,
          color: Colors.teal,
          size: 30,
        ),
        // suffixIcon: Icon(
        //   Icons.visibility_off,
        //   color: Colors.teal,
        //   size: 30,
        // ),
        suffixIcon: IconButton(
          icon: isPasswordVisible
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
          onPressed: () =>
              setState(() => isPasswordVisible = !isPasswordVisible),
          color: Colors.teal,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(color: Colors.teal, width: 3),
        ),
      ),
      obscureText: isPasswordVisible,
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
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: ClipPath(
                        clipper: WaveClipperTwo(),
                        child: Container(
                          color: Colors.teal,
                          height: 180,
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: WaveClipperTwo(),
                      child: Container(
                        color: Colors.teal,
                        height: 160,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                colorizeAnimation(),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 25.0),
                  child: Column(
                    children: [
                      Container(
                        child: buildUser(),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: buildPassword(),
                      ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const ResetPasswordScreen();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: usernameController.text,
                                    password: password)
                                .then((value) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const HomePage();
                                  },
                                ),
                              );
                            });

                            /*debugPrint('Username: ${usernameController.text}');
                            debugPrint('Password: $password');*/
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
                          //Icon(Icons.chevron_right_rounded),
                          child: const Text(
                            "LOGIN",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have a account?',
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          TextButton(
                            child: const Text(
                              'Click Here',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const SignUpScreen();
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
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
          'Hello Again!',
          textStyle: colorizeTextStyle,
          colors: colorizeColors,
          textAlign: TextAlign.center,
          speed: const Duration(milliseconds: 250),
        ),
        ColorizeAnimatedText(
          'Welcome Back',
          textStyle: colorizeTextStyle,
          colors: colorizeColors,
          textAlign: TextAlign.center,
          speed: const Duration(milliseconds: 250),
        ),
        ColorizeAnimatedText(
          'You\'ve been missed',
          textStyle: colorizeTextStyle,
          colors: colorizeColors,
          textAlign: TextAlign.center,
          speed: const Duration(milliseconds: 250),
        ),
        ColorizeAnimatedText(
          'Login',
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
