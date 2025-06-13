import 'package:aserdev_chat/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:aserdev_chat/themes/dark_mode.dart';
import 'package:aserdev_chat/pages/login_page.dart';
import 'package:aserdev_chat/pages/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aserdev_chat/pages/home_menu.dart';

class WelcomePage extends StatefulWidget {
  final void Function(ThemeData) onThemeChanged;
  const WelcomePage({super.key, required this.onThemeChanged});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    _checkPreviousLogin();
  }

  Future<void> _checkPreviousLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('ever_logged_in') ?? false;
    if (loggedIn) {
      // Replace this with your actual HomePage widget
      Navigator.push(
        
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            onThemeChanged: widget.onThemeChanged,
          ),
          
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightTheme.appBarTheme.backgroundColor,
        title: Text('Aserdev_chat', style: lightTheme.textTheme.titleLarge),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Aserdev Chat',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(
                      onThemeChanged: widget.onThemeChanged,
                    ),
                  ),
                );
              },
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupPage(
                      onThemeChanged: widget.onThemeChanged,
                    ),
                  ),
                );
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Settings'),
              content: Text('Choose a theme:'),
              actions: [
                TextButton(
                  onPressed: () {
                    widget.onThemeChanged(lightTheme);
                    Navigator.of(context).pop();
                  },
                  child: Text('Light mode'),
                ),
                TextButton(
                  onPressed: () {
                    widget.onThemeChanged(darkTheme);
                    Navigator.of(context).pop();
                  },
                  child: Text('Dark mode'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.settings),
        tooltip: 'Settings',
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}