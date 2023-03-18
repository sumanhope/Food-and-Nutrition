import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodandnutrition/Verification/emailverification_page.dart';
import 'package:foodandnutrition/Welcome/welcome_page.dart';
import 'package:foodandnutrition/provider/darkthemeprov.dart';
import 'package:foodandnutrition/utils/themes.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeProvider = DarkThemeProvider();
  UsernameProvider usernameProvider = UsernameProvider();
  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  // This widget is the root of your application.
  void getCurrentAppTheme() async {
    themeProvider.setDarkTheme = await themeProvider.darkThemePrefs.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeProvider;
        }),
        ChangeNotifierProvider(create: (_) {
          return usernameProvider;
        })
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Food and Nutrition',
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(value.getDarkTheme, context),
            home: const MainPage(),
          );
        },
      ),
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
