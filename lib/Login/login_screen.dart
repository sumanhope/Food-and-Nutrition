import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                  color: Colors.teal,
                  height: 270,
                ),
              ),
            ),
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                color: Colors.teal,
                height: 250,
              ),
            ),
            const Positioned(
              top: 280,
              left: 150,
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
