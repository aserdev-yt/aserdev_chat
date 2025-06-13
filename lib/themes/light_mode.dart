import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.green,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
    centerTitle: true,
    elevation: 2,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black, fontSize: 18),
    bodyMedium: TextStyle(color: Colors.black87),
    titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  ),
);