import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodandnutrition/main.dart';
import 'package:foodandnutrition/provider/darkthemeprov.dart';
import 'package:provider/provider.dart';

class Appsetting extends StatefulWidget {
  const Appsetting({super.key});

  @override
  State<Appsetting> createState() => _AppsettingState();
}

class _AppsettingState extends State<Appsetting> {
  bool notification = false;

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? androidNotification =
            message.notification?.android;
        if (notification != null && androidNotification != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.teal,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ),
          );
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("A new onMessageOpendApp event was published.");
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      if (notification != null && androidNotification != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: Text(notification.body!),
              );
            });
      }
    });
  }

  void showNotification() {
    flutterLocalNotificationsPlugin.show(
        0,
        "Stay Hydrated",
        "A drink for a wise man is only water.",
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            color: Colors.teal,
            importance: Importance.high,
            playSound: true,
            icon: '@mipmap/ic_launcher_foreground',
          ),
        ));
  }

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: SwitchListTile(
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: SwitchListTile(
                value: notification,
                onChanged: (bool value) {
                  setState(() {
                    notification = value;
                  });
                  if (notification) {
                    showNotification();
                  }
                },
                title: const Text(
                  "Notification",
                  style: TextStyle(
                    fontSize: 18,
                    //color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                secondary: Icon(
                  notification
                      ? Icons.notifications_active
                      : Icons.notifications_none,
                  size: 30,
                  //color: Colors.teal,
                ),
                activeColor: Colors.teal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
