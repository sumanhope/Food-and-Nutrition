import 'package:flutter/cupertino.dart';
import 'package:foodandnutrition/services/darkthemeperf.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePrefs darkThemePrefs = DarkThemePrefs();
  bool _darkTheme = false;
  bool get getDarkTheme => _darkTheme;
  set setDarkTheme(bool value) {
    _darkTheme = value;
    darkThemePrefs.setDarkTheme(value);
    notifyListeners();
  }
}

class UsernameProvider with ChangeNotifier {
  UsernamePerfs usernamePerfs = UsernamePerfs();
  String _username = "";
  String get getUsername => _username;
  set setUsername(String value) {
    _username = value;
    usernamePerfs.setUsername(value);
    notifyListeners();
  }
}

class NotificationProvider with ChangeNotifier {
  Notificatonperfs noti = Notificatonperfs();
  bool _notification = false;
  bool get getNotification => _notification;
  set setNotification(bool value) {
    _notification = value;
    noti.setNotification(value);
    notifyListeners();
  }
}
