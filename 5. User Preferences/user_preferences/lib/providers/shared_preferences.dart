import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ***************************************
  // Variables to store in user preferences
  // ***************************************

  // 1. 'darkmode' value
  static bool _darkMode = false;
  static bool get darkMode {
    return _prefs.getBool('darkmode') ?? _darkMode;
  }

  static set darkMode(bool value) {
    _darkMode = value;
    _prefs.setBool('darkmode', _darkMode);
  }

  // 2. 'optionSelected' value
  static int _optionSelected = 1;
  static int get optionSelected {
    return _prefs.getInt('selected') ?? _optionSelected;
  }

  static set optionSelected(int value) {
    _optionSelected = value;
    _prefs.setInt('selected', _optionSelected);
  }

  // 3. 'testString' value
  static String _testString = 'test value!';
  static String get testString {
    return _prefs.getString('teststring') ?? _testString;
  }

  static set testString(String value) {
    _testString = value;
    _prefs.setString('teststring', _testString);
  }
}
