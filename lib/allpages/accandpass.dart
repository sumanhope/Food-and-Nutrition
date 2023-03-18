import 'package:flutter/material.dart';
import 'package:foodandnutrition/ForgotPassword/changepass_page.dart';
import 'package:foodandnutrition/allpages/accountdelete.dart';
import 'package:foodandnutrition/allpages/profile_page.dart';

class AccountandPassword extends StatefulWidget {
  const AccountandPassword({super.key});

  @override
  State<AccountandPassword> createState() => _AccountandPasswordState();
}

class _AccountandPasswordState extends State<AccountandPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Account and Password",
          style: TextStyle(
            letterSpacing: 1.5,
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Column(
        children: [
          ProfileMenu(
              text: "Change password",
              firsticon: Icons.key,
              secondicon: Icons.chevron_right_sharp,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChangePassScreen(),
                  ),
                );
              }),
          ProfileMenu(
            text: "Account Deletion",
            firsticon: Icons.person_off,
            secondicon: Icons.chevron_right_sharp,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountDelete(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
