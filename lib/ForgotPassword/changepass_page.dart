import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({super.key});

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  var box = const SizedBox(
    height: 10,
  );
  var user = FirebaseAuth.instance.currentUser!;
  final passwordController = TextEditingController();
  final newpassController = TextEditingController();
  final changepassController = TextEditingController();
  bool isPasswordVisible = false;
  bool isNewpass = false;
  bool isChangePass = false;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(() => setState(() {}));
    newpassController.addListener(() => setState(() {}));
    changepassController.addListener(() => setState(() {}));
  }

  String? get passerrorText {
    // at any time, we can get the text from _controller.value.text
    final text = passwordController.value.text;

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

  String? get newpasserrorText {
    // at any time, we can get the text from _controller.value.text
    final text = newpassController.value.text;

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
    final text = changepassController.value.text;

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

  var unfocuseborder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: Color.fromRGBO(77, 182, 172, 1), width: 3),
  );
  var focuseborder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: Colors.teal, width: 3),
  );

  bool passwordConfirmed() {
    if (newpassController.text.trim() == changepassController.text.trim()) {
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

  Future _changePassword(String currentPassword, String newPassword) async {
    //Create an instance of the current user.

    //Must re-authenticate user before updating the password. Otherwise it may fail or user get signed out.

    final cred = EmailAuthProvider.credential(
        email: user.email!, password: currentPassword);
    await user.reauthenticateWithCredential(cred).then((value) async {
      await user.updatePassword(newPassword).then((_) {
        debugPrint("Changed");
      }).catchError((error) {
        errorDialog(error.toString());
      });
    }).catchError((err) {
      errorDialog(err.toString());
    });
  }

  Widget buildPass() {
    return TextField(
      controller: passwordController,
      decoration: InputDecoration(
        errorStyle: const TextStyle(
            color: Colors.teal,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold),
        filled: true,
        fillColor: const Color.fromARGB(117, 100, 255, 219),
        enabledBorder: unfocuseborder,
        focusedBorder: focuseborder,
        errorBorder: unfocuseborder,
        focusedErrorBorder: focuseborder,
        errorText: passerrorText,
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

  Widget buildNewPass() {
    return TextField(
      controller: newpassController,
      decoration: InputDecoration(
        errorStyle: const TextStyle(
            color: Colors.teal,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold),
        filled: true,
        fillColor: const Color.fromARGB(117, 100, 255, 219),
        enabledBorder: unfocuseborder,
        focusedBorder: focuseborder,
        errorBorder: unfocuseborder,
        focusedErrorBorder: focuseborder,
        errorText: newpasserrorText,
        prefixIcon: const Icon(
          Icons.key,
          color: Colors.teal,
          size: 30,
        ),
        suffixIcon: IconButton(
          icon: isNewpass
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
          onPressed: () => setState(() => isNewpass = !isNewpass),
          color: Colors.teal,
        ),
        //prefixIconColor: Colors.teal,
      ),
      obscureText: isNewpass,
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
      controller: changepassController,
      decoration: InputDecoration(
        errorStyle: const TextStyle(
            color: Colors.teal,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold),
        errorText: errorText,
        filled: true,
        fillColor: const Color.fromARGB(117, 100, 255, 219),
        enabledBorder: unfocuseborder,
        focusedBorder: focuseborder,
        errorBorder: unfocuseborder,
        focusedErrorBorder: focuseborder,
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
                      "New Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.teal,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  buildNewPass(),
                  const SizedBox(
                    height: 20,
                  ),
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
                        //debugPrint("OTP: ${emailController.text}")
                        if (passwordController.text.isNotEmpty &&
                            newpassController.text.isNotEmpty &&
                            changepassController.text.isNotEmpty) {
                          if (passwordConfirmed()) {
                            if (newpassController.text.length > 6) {
                              if (passwordController.text !=
                                  newpassController.text) {
                                _changePassword(passwordController.text,
                                    newpassController.text);
                              } else {
                                errorDialog(
                                    "Your new password cannot be old password");
                              }
                            } else {
                              errorDialog(
                                "Password should be more than 6 characters",
                              );
                            }
                          } else {
                            errorDialog("Password doesnot match");
                          }
                        } else {
                          errorDialog("Please fill both field");
                        }
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
                        Navigator.of(context).pop(context);
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
