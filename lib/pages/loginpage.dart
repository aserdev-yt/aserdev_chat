import 'package:aserdev_chat/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:aserdev_chat/themes/dark_mode.dart';
class LoginPage extends StatelessWidget {
  final void Function(ThemeData) onThemeChanged;
  const LoginPage({super.key, required this.onThemeChanged});

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
                // Add your login logic here
              },
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Add your registration logic here
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
                    onThemeChanged(lightTheme); // Switch to light theme
                    Navigator.of(context).pop();
                  },
                  child: Text('Light mode'),
                ),
                TextButton(
                  onPressed: () {
                    onThemeChanged(darkTheme); // Switch to dark theme
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