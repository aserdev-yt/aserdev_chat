import 'package:flutter/material.dart';
import 'package:aserdev_chat/themes/dark_mode.dart';
import 'package:aserdev_chat/themes/light_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aserdev_chat/pages/home_menu.dart';

class LoginPage extends StatefulWidget {
  final void Function(ThemeData)? onThemeChanged;
  const LoginPage({super.key, this.onThemeChanged});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {

      // Save login status to device storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('ever_logged_in', true);

      // You can navigate to the home page here if you want
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => HomePage(
          onThemeChanged: widget.onThemeChanged ?? (theme) {},
        ),
      ));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text('Login', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'images/logo.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  onChanged: (value) => _username = value,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter username' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onChanged: (value) => _password = value,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter password' : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _handleLogin,
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Settings'),
              content: const Text('Choose a theme:'),
              actions: [
                TextButton(
                  onPressed: () {
                    widget.onThemeChanged?.call(lightTheme);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Light Mode'),
                ),
                TextButton(
                  onPressed: () {
                    widget.onThemeChanged?.call(darkTheme);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Dark Mode'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.settings, color: Theme.of(context).iconTheme.color),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}