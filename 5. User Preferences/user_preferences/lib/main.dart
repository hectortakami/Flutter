// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_preferences/pages/home_page.dart';
import 'package:user_preferences/pages/settings_page.dart.dart';
import 'package:user_preferences/providers/shared_preferences.dart';
import 'package:user_preferences/providers/theme_provider.dart';

// ****************************************************
// main() convert  to async to support user preferences
// ****************************************************
void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Include to load preferences when app restart
  await Preferences.init(); // Include to load preferences when app restart
  runApp(
    // Include to load theme preferences when app restart
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(isDarkMode: Preferences.darkMode),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Preferences',
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomePage(),
        'settings': (_) => const SettingsPage(),
      },
      // Modifies the current theme mode
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}
