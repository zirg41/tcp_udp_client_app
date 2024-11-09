import "package:flutter/material.dart";

abstract class AppTheme {
  static ThemeData themeData = ThemeData(
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromARGB(255, 4, 100, 164),
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(),
    ),
  );
}
