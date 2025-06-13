import 'package:flutter/material.dart';
import 'package:aserdev_chat/themes/light_mode.dart';
import 'package:aserdev_chat/themes/dark_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aserdev_chat/pages/welcome_page.dart';

class SettingsPage extends StatefulWidget {
  final void Function(ThemeData) onThemeChanged;
  const SettingsPage({super.key, required this.onThemeChanged});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> _removeLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('ever_logged_in');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login info removed!')),
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomePage(
          onThemeChanged: widget.onThemeChanged,
        ),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                widget.onThemeChanged(lightTheme);
              },
              child: const Text('Light Theme'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.onThemeChanged(darkTheme);
              },
              child: const Text('Dark Theme'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _removeLoginInfo,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Remove Login Info'),
            ),
          ],
        ),
      ),
    );
  }
}