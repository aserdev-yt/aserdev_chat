import 'package:flutter/material.dart';
import 'package:aserdev_chat/themes/dark_mode.dart';
import 'package:aserdev_chat/themes/light_mode.dart';
import 'package:aserdev_chat/pages/welcome_page.dart';

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
                  width: 300,
                  height: 300,
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle login logic here
                    }
                  },
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
