import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class BeforeandAfterScreen extends StatefulWidget {
  const BeforeandAfterScreen({super.key});

  @override
  State<BeforeandAfterScreen> createState() => _BeforeandAfterScreenState();
}

class _BeforeandAfterScreenState extends State<BeforeandAfterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[200],
      appBar: AppBar(
        title: const Text(
          "Before and After",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "Capture your Progress",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text(
                "Before",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(
                width: 18,
              ),
              Text(
                "After",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(94, 68, 137, 255),
                      border: Border.all(
                        width: 4,
                        color: Colors.teal,
                      ),
                    ),
                    child: const Icon(
                      LineIcons.male,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(94, 68, 137, 255),
                      border: Border.all(
                        width: 4,
                        color: Colors.teal,
                      ),
                    ),
                    child: const Icon(
                      LineIcons.male,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
