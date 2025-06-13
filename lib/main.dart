import 'package:flutter/material.dart';
import 'themes/light_mode.dart';
import 'themes/dark_mode.dart';
import 'pages/loginpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _themeData = lightTheme;

  void setTheme(ThemeData theme) {
    setState(() {
      _themeData = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _themeData,
      home: LoginPage(onThemeChanged: setTheme),
    );
  }
}