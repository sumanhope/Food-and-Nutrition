import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Lottie.network(
            "https://assets7.lottiefiles.com/packages/lf20_jpxsQh.json"),
      ),
    );
  }
}
