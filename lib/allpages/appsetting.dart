import 'package:flutter/material.dart';
import 'package:foodandnutrition/provider/darkthemeprov.dart';
import 'package:provider/provider.dart';

class Appsetting extends StatefulWidget {
  const Appsetting({super.key});

  @override
  State<Appsetting> createState() => _AppsettingState();
}

class _AppsettingState extends State<Appsetting> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      //backgroundColor: Color(0x5F303030),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "App Settings",
          style: TextStyle(
            letterSpacing: 1.5,
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        //backgroundColor: Color(0xFF000000),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: themeState.getDarkTheme,
            onChanged: (bool value) {
              setState(() {
                themeState.setDarkTheme = value;
              });
            },
            title: const Text(
              "Dark Mode",
              style: TextStyle(
                fontSize: 18,
                //color: Colors.teal,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            secondary: Icon(
              themeState.getDarkTheme
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
              size: 30,
              //color: Colors.teal,
            ),
            activeColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
