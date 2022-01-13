import 'package:flutter/material.dart';
import 'package:user_preferences/providers/shared_preferences.dart';
import 'package:user_preferences/shared/side_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: const SideMenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Dark Mode: ${Preferences.darkMode}'),
            Text('Selected: Option ${Preferences.optionSelected}'),
            Text('Stored: "${Preferences.testString}"'),
          ],
        ),
      ),
    );
  }
}
