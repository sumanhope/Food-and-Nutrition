import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodandnutrition/Verification/emailverification_page.dart';
import 'package:foodandnutrition/Welcome/welcome_page.dart';
import 'package:foodandnutrition/allpages/appsetting.dart';
import 'package:foodandnutrition/utils/themes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Food and Nutrition',
      debugShowCheckedModeBanner: false,
      theme: Styles.themeData(true, context),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const EmailVerifyScreen();
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}
