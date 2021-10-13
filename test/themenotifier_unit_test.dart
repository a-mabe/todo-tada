/// Copyright (C) 2021 Abigail Mabe - All Rights Reserved
/// You may use, distribute and modify this code under the terms 
/// of the license.
///
/// You should have received a copy of the license with this file.
/// If not, please email <mabe.abby.a@gmail.com>
/// 
/// Tests methods for the ThemeNotifier.
/// 

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todotada/themenotifier/themenotifier.dart';

void main() {

  group('checkThemeSettings', () {
    test('Text color should be too light for light mode.', () {
      Color primaryColor = Colors.red;
      Color textColor = Colors.white;
      Brightness brightness = Brightness.light;
      String alertDialogContent = '';

      expect(checkThemeSettings(primaryColor, textColor, brightness, alertDialogContent), 'That text color won\'t be visible with dark mode disabled.');
    });

    test('Text color should be too dark for dark mode.', () {
      Color primaryColor = Colors.red;
      Color textColor = Colors.black;
      Brightness brightness = Brightness.dark;
      String alertDialogContent = '';

      expect(checkThemeSettings(primaryColor, textColor, brightness, alertDialogContent), 'That text color won\'t be visible with dark mode enabled.');
    });

    test('Text color should match primary color.', () {
      Color primaryColor = Colors.red;
      Color textColor = Colors.red;
      Brightness brightness = Brightness.dark;
      String alertDialogContent = '';

      expect(checkThemeSettings(primaryColor, textColor, brightness, alertDialogContent), 'The text color can\'t match the primary color.');
    });

    test('Text color should be accepted.', () {
      Color primaryColor = Colors.red;
      Color textColor = Colors.white;
      Brightness brightness = Brightness.dark;
      String alertDialogContent = '';

      expect(checkThemeSettings(primaryColor, textColor, brightness, alertDialogContent), '');
    });
  });

}