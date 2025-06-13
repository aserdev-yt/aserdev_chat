import 'package:flutter/material.dart';
import 'package:aserdev_chat/themes/light_mode.dart';
import 'package:aserdev_chat/themes/dark_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aserdev_chat/pages/home_menu.dart';

class SignupPage extends StatefulWidget {
  final void Function(ThemeData)? onThemeChanged;
  const SignupPage({super.key, this.onThemeChanged});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _confirmPassword = '';

  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      // Save login status to device storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('ever_logged_in', true);

      // Show a success message or navigate to home page
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signup successful!')),
      );
      // Optionally navigate to home page here
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => HomePage(
          onThemeChanged: widget.onThemeChanged ?? (theme) {},
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
                Image.asset('images/logo.png', width: 100, height: 100, fit: BoxFit.contain),
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
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  onChanged: (value) => _confirmPassword = value,
                  validator: (value) =>
                      value != _password ? 'Passwords do not match' : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _handleSignup,
                  child: const Text('Sign Up'),
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
        child: const Icon(Icons.brush),
        tooltip: 'theme settings',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}