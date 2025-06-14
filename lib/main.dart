import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'themes/light_mode.dart';
import 'themes/dark_mode.dart';
import 'pages/welcome_page.dart';

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

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('theme_mode') ?? 'light';
    setState(() {
      _themeData = themeString == 'dark' ? darkTheme : lightTheme;
    });
  }

  Future<void> setTheme(ThemeData theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', theme == darkTheme ? 'dark' : 'light');
    setState(() {
      _themeData = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aserdev Chat',
      theme: _themeData,
      home: WelcomePage(onThemeChanged: setTheme),
      debugShowCheckedModeBanner: false,
    );
  }
}