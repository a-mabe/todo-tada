import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter/material.dart';
import 'hexcolor.dart';

/// 
/// Based off of the method from the following article:
/// https://betterprogramming.pub/how-to-create-a-dynamic-theme-in-flutter-using-provider-e6ad1f023899.
/// 


/// 
/// ------------
/// HELPER FUNCTIONS
/// ------------
/// 

/// Calls theme notifier with the given values.
/// 
void onThemeChanged(bool value, ThemeNotifier themeNotifier, ThemeData newTheme) async {
  themeNotifier.setTheme(newTheme);
}

/// Returns a Color object.
/// 
/// Gets the primary color string from settings and converts it to a Color. If
/// no primary color stored, defaults to blue.
/// 
/// e.g., Colors.blue
/// 
Color getPrimaryColor() {
  final String primaryColorString = Settings.getValue<String>('primary-color-picker', '');
  if (primaryColorString != '') {
    return HexColor.fromHex(primaryColorString); // Stored color
  } else {
    return Colors.blue; // Default color
  }
}

/// Returns a Color object.
/// 
/// Gets the text color string from settings and converts it to a Color. If
/// no text color stored, defaults to blue.
/// 
/// e.g., Colors.black
/// 
Color getTextColor() {
  final String textColorString = Settings.getValue<String>('text-color-picker', '');
  if (textColorString != '') {
    return HexColor.fromHex(textColorString); // Stored color
  } else {
    return Colors.black; // Default color
  }
}

/// Returns a Brightness object.
/// 
/// Gets the brightness mode boolean from settings and converts it to Brightness.
/// 
/// e.g., Brightness.light
/// 
Brightness getBrightnessMode() {
  if (Settings.getValue<bool>('dark-mode', false) == true) {
    return Brightness.dark;
  } else {
    return Brightness.light; // Default
  }
}

/// 
/// ------------
/// END HELPER FUNCTIONS
/// ------------
/// 



/// 
/// ------------
/// THEME NOTIFIER CLASS
/// ------------
/// 
class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}

void runOnThemeChanged(_primaryColor, _textColor, _brightness, _themeNotifier) {
  onThemeChanged(false, _themeNotifier, ThemeData(
      primaryColor: _primaryColor,
      brightness: _brightness,
      backgroundColor: _primaryColor,
      accentColor: _primaryColor,
      accentIconTheme: IconThemeData(color: _primaryColor),
      iconTheme: IconThemeData(
        color: _primaryColor
      ),
      dividerColor: _primaryColor,
      toggleableActiveColor: _primaryColor,
      appBarTheme: AppBarTheme(
        backgroundColor: _primaryColor, // This should match the primary color
        backwardsCompatibility: false,
        iconTheme: IconThemeData(color: _textColor), // This should be the same as titleTextStyle
        titleTextStyle: TextStyle(color: _textColor), // This should be the same as iconTheme
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          color: _textColor,
        ),
        headline2: TextStyle(
          color: _textColor,
        ),
        headline3: TextStyle(
          color: _textColor,
        ),
        headline4: TextStyle(
          color: _textColor,
        ),
        headline5: TextStyle(
          color: _textColor,
        ),
        headline6: TextStyle(
          color: _textColor,
        ),
        subtitle1: TextStyle(
          color: _textColor,
        ),
        subtitle2: TextStyle(
          color: _textColor,
        ),
        bodyText1: TextStyle(
          color: _textColor,
        ),
        bodyText2: TextStyle(
          color: _textColor,
        ),
      )
    )
  );
}
/// 
/// ----------------
/// END THEME NOTIFIER CLASS
/// ----------------
/// 