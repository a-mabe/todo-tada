import 'package:flutter/material.dart';

/// 
/// ------------
/// THEME CHANGE
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
/// END THEME CHANGE
/// ----------------
/// 