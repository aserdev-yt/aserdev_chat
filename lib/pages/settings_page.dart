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

  Future<void> _setThemeAndSave(ThemeData theme, String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', mode);
    widget.onThemeChanged(theme);
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
              onPressed: () async {
                await _setThemeAndSave(lightTheme, 'light');
              },
              child: const Text('Light Theme'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _setThemeAndSave(darkTheme, 'dark');
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