import 'package:flutter/material.dart';
//import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool isPasswordVisible = false;
  Widget buildEmail() => const TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(90, 255, 255, 255),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 3),
          ),
          labelText: 'Username',
          labelStyle: TextStyle(
            color: Colors.teal,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.teal,
            size: 30,
          ),
          //prefixIconColor: Colors.teal,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 3),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
      );
  Widget buildPassword() => const TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(90, 255, 255, 255),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 3),
          ),
          labelText: 'Password',
          labelStyle: TextStyle(
            color: Colors.teal,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
          prefixIcon: Icon(
            Icons.key,
            color: Colors.teal,
            size: 30,
          ),
          suffixIcon: Icon(
            Icons.visibility_off,
            color: Colors.teal,
            size: 30,
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 3)),
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Hello Again!',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Welcome back you\'ve been missed',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Container(
                        child: buildEmail(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: buildPassword(),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
