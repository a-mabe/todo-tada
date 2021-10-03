import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'themenotifier.dart';
import 'settingsalert.dart';


///
/// ---------
/// VARIABLES
/// ---------
///

/// The primary theme color.
/// 
/// e.g., Colors.blue
/// 
late Color primaryColor;

/// The main text color.
/// 
/// e.g., Colors.blue
/// 
late Color textColor;

/// The theme brightness.
/// 
/// e.g., Brightness.light (light theme)
/// 
late Brightness brightness;

/// The content for the settings alert dialog that
/// pops up if the user tries to set an invalid
/// theme.
/// 
/// e.g., 'You are about to leave this page without saving.'
/// 
String alertDialogContent = '';

/// The title for the settings alert dialog that
/// pops up if the user tries to set an invalid
/// theme.
/// 
/// e.g., 'Alert'
/// 
const String alertDialogTitle = 'Whoa!';

/// The continue button text for the settings alert dialog.
/// 
/// e.g., 'Continue'
/// 
const String continueButtonText = "I'll change it";

///
/// -------------
/// END VARIABLES
/// -------------
///

/// An app settings route.
/// 
/// Takes [themeNotifier] as a parameter to notify a theme update when theme
/// settings (primary color, brightness) are changed.
///
class SettingsRoute extends StatefulWidget {

  const SettingsRoute({Key? key, this.themeNotifier}) : super(key: key);

  final ThemeNotifier? themeNotifier;

  @override
  _SettingsRouteState createState() => _SettingsRouteState(themeNotifier: themeNotifier);
}

class _SettingsRouteState extends State<SettingsRoute> {

  _SettingsRouteState({this.themeNotifier});

  final ThemeNotifier? themeNotifier;
  
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: SettingsScreen(
        title: 'Application Settings',
        children: [
          SettingsGroup(
            title: 'Theme Settings',
            children: <Widget>[
              
              /// Brightness Selector
              /// 
              SwitchSettingsTile(
                settingKey: 'dark-mode',
                title: 'Dark mode',
                subtitle: 'Enable or disable dark mode.',
                enabledLabel: 'Enabled',
                disabledLabel: 'Disabled',
                leading: Icon(Icons.dark_mode_sharp),
                onChange: (value) {

                  /// Grab the primary color string.
                  /// 
                  /// e.g, '4287f5'
                  /// 
                  primaryColor = getPrimaryColor();

                  /// Grab the text color string.
                  /// 
                  /// e.g, '4287f5'
                  /// 
                  textColor = getTextColor();

                  /// Convert the value to a brightness setting.
                  /// 
                  /// e.g., Brightness.light
                  /// 
                  if (value == true)
                    brightness = Brightness.dark;
                  else
                    brightness = Brightness.light; // Default

                  enforceThemeSettingsRules();
                  
                },
              ),
              /// 
              /// Primary Color Selector
              /// 
              ColorPickerSettingsTile(
                settingKey: 'primary-color-picker',
                title: 'Primary Color',
                defaultValue: Colors.blue,
                onChange: (value) {

                  /// Grab the text color string.
                  /// 
                  /// e.g, '4287f5'
                  /// 
                  textColor = getTextColor();

                  /// Get whether or not darkmode is enabled.
                  /// 
                  /// e.g., 'true'
                  /// 
                  brightness = getBrightnessMode();

                  primaryColor = value;

                  enforceThemeSettingsRules();
                },
              ),
              /// 
              /// Text Color Selector
              /// 
              ColorPickerSettingsTile(
                settingKey: 'text-color-picker',
                title: 'Secondary Color',
                defaultValue: Colors.black,
                onChange: (value) {

                  /// Grab the primary color string.
                  /// 
                  /// e.g, '4287f5'
                  /// 
                  primaryColor = getPrimaryColor();

                  /// Get whether or not darkmode is enabled.
                  /// 
                  /// e.g., 'true'
                  /// 
                  brightness = getBrightnessMode();

                  textColor = value;

                  enforceThemeSettingsRules();
                },
              )
            ],
          ),
        ],
      ),
    ); 
  }

  /// Checks theme settings and changes theme based on result.
  /// 
  void enforceThemeSettingsRules() async {
    alertDialogContent = checkThemeSettings(primaryColor, textColor, brightness, alertDialogContent);
    if (alertDialogContent.length == 0) {
      runOnThemeChanged(primaryColor, textColor, brightness, this.themeNotifier);
    } else {

      new SettingsAlertDialog.namedConst(
        '',
        continueButtonText, 
        alertDialogTitle,
        alertDialogContent,
        true,
        true,
        false
      ).showAlertDialog(context);

      /// Reset theme text color based off of brightness so that the text is
      /// visible and the user can see to update the theme settings themselves.
      ///
      if (Settings.getValue<bool>('dark-mode', false) == false) {
        await Settings.setValue<String>('text-color-picker', '#000000');
        runOnThemeChanged(primaryColor, Colors.black, brightness, this.themeNotifier);
      }
      else {
        await Settings.setValue<String>('text-color-picker', '#ffffff');
        runOnThemeChanged(primaryColor, Colors.white, brightness, this.themeNotifier);
      }
    }
  }

}
