import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({super.key});

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  final otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    otpController.addListener(() => setState(() {}));
  }

  var box = const SizedBox(
    height: 20,
  );
  Widget buildOTP() {
    return TextField(
      controller: otpController,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(117, 100, 255, 219),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide:
              BorderSide(color: Color.fromRGBO(77, 182, 172, 1), width: 3),
        ),
        labelText: 'OTTP',
        labelStyle: const TextStyle(
          color: Colors.teal,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),

        prefixIcon: const Icon(
          Icons.numbers_sharp,
          color: Colors.teal,
          size: 30,
        ),
        suffixIcon: otpController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => otpController.clear(),
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
      keyboardType: TextInputType.number,
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
                  "We have send an OTP on your email",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Colors.teal,
                  ),
                ),
                const Text(
                  "Please enter it below",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Colors.teal,
                  ),
                ),
                box,
                // const TextField(
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(),
                //     label: Text("OTP"),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 25.0),
                  child: buildOTP(),
                ),

                box,
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        debugPrint("OTP: ${otpController.text}");
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
