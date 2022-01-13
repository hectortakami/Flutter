import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_preferences/providers/shared_preferences.dart';
import 'package:user_preferences/providers/theme_provider.dart';
import 'package:user_preferences/shared/side_menu.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        drawer: const SideMenu(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SwitchListTile.adaptive(
                  value: Preferences.darkMode,
                  title: const Text('Dark Mode'),
                  onChanged: (bool selection) {
                    Preferences.darkMode = selection;

                    final themeProvider =
                        Provider.of<ThemeProvider>(context, listen: false);
                    selection
                        ? themeProvider.setDarkMode()
                        : themeProvider.setLightMode();

                    setState(() {});
                  }),
              const Divider(),
              RadioListTile(
                value: 1,
                groupValue: Preferences.optionSelected,
                title: const Text('Option 1'),
                onChanged: (selection) {
                  Preferences.optionSelected = 1;
                  setState(() {});
                },
              ),
              RadioListTile(
                value: 2,
                groupValue: Preferences.optionSelected,
                title: const Text('Option 2'),
                onChanged: (selection) {
                  Preferences.optionSelected = 2;
                  setState(() {});
                },
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  initialValue: Preferences.testString,
                  decoration: const InputDecoration(
                    labelText: 'Text value',
                    helperText: 'Insert some text to store',
                  ),
                  onChanged: (value) {
                    Preferences.testString = value;
                    setState(() {});
                  },
                ),
              )
            ],
          ),
        ));
  }
}
