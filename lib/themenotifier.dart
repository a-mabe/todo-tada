import 'package:flutter/material.dart';

/// 
/// Based off of the method from the following article:
/// https://betterprogramming.pub/how-to-create-a-dynamic-theme-in-flutter-using-provider-e6ad1f023899.
/// 

/// 
/// ------------
/// THEME NOTIFIER
/// ------------
/// 
void onThemeChanged(bool value, ThemeNotifier themeNotifier, ThemeData newTheme) async {
  themeNotifier.setTheme(newTheme);
}

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}
/// 
/// ----------------
/// END THEME NOTIFIER
/// ----------------
/// 