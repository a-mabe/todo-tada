// Import the test package and Counter class
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todotada/themenotifier.dart';

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



      //expect(counter.value, 1);
    });

    test('Text color should match primary color.', () {



      //expect(counter.value, 1);
    });

    test('Text color should be accepted.', () {



      //expect(counter.value, 1);
    });
  });

}