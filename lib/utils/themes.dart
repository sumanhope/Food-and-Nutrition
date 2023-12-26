import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDark, BuildContext context) {
    return ThemeData(
      canvasColor: Colors.white,
      highlightColor: isDark ? const Color(0xFF9C9C9C) : Colors.teal,
      scaffoldBackgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
      primarySwatch: Colors.teal,
      primaryColor: isDark ? Colors.black : Colors.teal,
      hoverColor: isDark ? Colors.grey.shade800 : Colors.teal.shade800,

      // backgroundColor:
      //     isDark ? const Color.fromARGB(184, 0, 0, 0) : Colors.teal,
      focusColor: isDark ? Colors.teal : Colors.white,
      // toggleableActiveColor:
      //     isDark ? Colors.grey.shade800 : Colors.teal.shade800,
      unselectedWidgetColor: isDark ? Colors.white : Colors.black,
      indicatorColor: isDark ? Colors.white : const Color(0xFF009688),
      // colorScheme: ThemeData().colorScheme.copyWith(
      //       secondary: isDark ? Color.fromARGB(255, 108, 16, 16) : Colors.teal,
      //       brightness: isDark ? Brightness.dark : Brightness.light,
      //     ),
      cardColor: isDark
          ? const Color.fromARGB(255, 48, 48, 48)
          : const Color.fromARGB(102, 0, 150, 135),
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            buttonColor: isDark ? Colors.grey : Colors.teal,
            colorScheme:
                isDark ? const ColorScheme.dark() : const ColorScheme.light(),
          ),
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: isDark ? Colors.white : Colors.teal,
            displayColor: isDark ? Colors.pink : Colors.teal,
          ),
      iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.teal),
      listTileTheme:
          ListTileThemeData(iconColor: isDark ? Colors.white : Colors.teal),
      appBarTheme: AppBarTheme(
          backgroundColor: isDark ? Colors.black : Colors.teal,
          iconTheme:
              IconThemeData(color: isDark ? Colors.white : Colors.white)),
    );
  }
}
