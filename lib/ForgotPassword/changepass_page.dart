import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:foodandnutrition/ForgotPassword/forgotpass_page.dart';

import '../Login/login_page.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({super.key});

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  var box = const SizedBox(
    height: 10,
  );
  final passwordController = TextEditingController();
  final changepassController = TextEditingController();
  bool isPasswordVisible = false;
  bool isChangePass = false;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(() => setState(() {}));
    changepassController.addListener(() => setState(() {}));
  }

  Widget buildPass() {
    return TextField(
      controller: passwordController,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(117, 100, 255, 219),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide:
              BorderSide(color: Color.fromRGBO(77, 182, 172, 1), width: 3),
        ),

        prefixIcon: const Icon(
          Icons.key,
          color: Colors.teal,
          size: 30,
        ),
        suffixIcon: IconButton(
          icon: isPasswordVisible
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
          onPressed: () =>
              setState(() => isPasswordVisible = !isPasswordVisible),
          color: Colors.teal,
        ),
        //prefixIconColor: Colors.teal,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.teal, width: 3),
        ),
      ),
      obscureText: isPasswordVisible,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontFamily: 'Poppins',
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }

  Widget buildChangePass() {
    return TextField(
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
        prefixIcon: const Icon(
          Icons.key,
          color: Colors.teal,
          size: 30,
        ),
        suffixIcon: IconButton(
          icon: isChangePass
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
          onPressed: () => setState(() => isChangePass = !isChangePass),
          color: Colors.teal,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(color: Colors.teal, width: 3),
        ),
      ),
      obscureText: isChangePass,
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Opacity(
                  opacity: 0.5,
                  child: ClipPath(
                    clipper: OvalBottomBorderClipper(),
                    child: Container(
                      color: Colors.teal,
                      height: 150,
                    ),
                  ),
                ),
                ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    color: Colors.teal,
                    height: 130,
                  ),
                ),
              ],
            ),
            box,
            Container(
              alignment: const Alignment(-0.67, 0.5),
              child: const Text(
                "Create new password",
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
              alignment: const Alignment(-0.6, 0.5),
              child: const Text(
                "Your new password must be different",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color.fromARGB(197, 2, 68, 62),
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            Container(
              alignment: const Alignment(-0.7, 0.5),
              child: const Text(
                "from previous used passwords.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color.fromARGB(197, 2, 68, 62),
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            box,
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
              child: Column(
                children: [
                  Container(
                    alignment: const Alignment(-1, 0.5),
                    child: const Text(
                      "Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.teal,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  buildPass(),
                  box,
                  Container(
                    alignment: const Alignment(-1, 0.5),
                    child: const Text(
                      "Confirm Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.teal,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  buildChangePass(),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        //debugPrint("OTP: ${emailController.text}");
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const LoginScreen();
                            },
                          ),
                        );
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
                              return const ResetPasswordScreen();
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
}
