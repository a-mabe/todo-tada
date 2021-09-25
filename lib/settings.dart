import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'themenotifier.dart';
import 'hexcolor.dart';


///
/// ---------
/// VARIABLES
/// ---------
///

late Color primaryColor;
late Color textColor;

///
/// -------------
/// END VARIABLES
/// -------------
///


class SettingsRoute extends StatefulWidget {

  const SettingsRoute({Key? key, required this.themeNotifier}) : super(key: key);

  final ThemeNotifier themeNotifier;

  @override
  _SettingsRouteState createState() => _SettingsRouteState(themeNotifier: themeNotifier);
}

class _SettingsRouteState extends State<SettingsRoute> {

  _SettingsRouteState({required this.themeNotifier});

  final ThemeNotifier themeNotifier;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsScreen(
        title: 'Application Settings',
        children: [
          SettingsGroup(
            title: 'Theme Settings',
            children: <Widget>[
              /// 
              /// Brightness Selector
              /// 
              // SwitchSettingsTile(
              //   settingKey: 'dark-mode',
              //   title: 'Dark mode',
              //   subtitle: 'Enable or disable dark mode.',
              //   enabledLabel: 'Enabled',
              //   disabledLabel: 'Disabled',
              //   leading: Icon(Icons.star),
              //   onChange: (value) {
              //     debugPrint('dark-mode: $value');
              //   },
              // ),
              /// 
              /// Primary Color Selector
              /// 
              ColorPickerSettingsTile(
                settingKey: 'primary-color-picker',
                title: 'Primary Color',
                defaultValue: Colors.blue,
                onChange: (value) {
                  final String textColorString = Settings.getValue<String>('text-color-picker', "");
                  if (textColorString != "") {
                    textColor = HexColor.fromHex(textColorString);
                  } else {
                    textColor = Colors.black; // Default
                  }
                  onThemeChanged(false, this.themeNotifier, ThemeData(
                      primaryColor: value,
                      brightness: Brightness.light,
                      backgroundColor: value,
                      accentColor: value,
                      accentIconTheme: IconThemeData(color: value),
                      dividerColor: value,
                      toggleableActiveColor: value,
                      appBarTheme: AppBarTheme(
                        backgroundColor: value, // This should match the primary color
                        backwardsCompatibility: false,
                        iconTheme: IconThemeData(color: textColor), // This should be the same as titleTextStyle
                        titleTextStyle: TextStyle(color: textColor), // This should be the same as iconTheme
                      ),
                      textTheme: TextTheme(
                        headline1: TextStyle(
                          color: textColor,
                        ),
                        headline2: TextStyle(
                          color: textColor,
                        ),
                        headline3: TextStyle(
                          color: textColor,
                        ),
                        headline4: TextStyle(
                          color: textColor,
                        ),
                        headline5: TextStyle(
                          color: textColor,
                        ),
                        headline6: TextStyle(
                          color: textColor,
                        ),
                        subtitle1: TextStyle(
                          color: textColor,
                        ),
                        subtitle2: TextStyle(
                          color: textColor,
                        ),
                        bodyText1: TextStyle(
                          color: textColor,
                        ),
                        bodyText2: TextStyle(
                          color: textColor,
                        ),
                      )
                    )
                  );
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
                  final String primaryColorString = Settings.getValue<String>('primary-color-picker', "");
                  if (primaryColorString != "") {
                    primaryColor = HexColor.fromHex(primaryColorString);
                  } else {
                    primaryColor = Colors.blue; // Default
                  }
                  onThemeChanged(false, this.themeNotifier, ThemeData(
                      primaryColor: primaryColor,
                      brightness: Brightness.light,
                      backgroundColor: primaryColor,
                      accentColor: primaryColor,
                      accentIconTheme: IconThemeData(color: primaryColor),
                      dividerColor: primaryColor,
                      toggleableActiveColor: primaryColor,
                      appBarTheme: AppBarTheme(
                        backgroundColor: primaryColor, // This should match the primary color
                        backwardsCompatibility: false,
                        iconTheme: IconThemeData(color: value), // This should be the same as titleTextStyle
                        titleTextStyle: TextStyle(color: value), // This should be the same as iconTheme
                      ),
                      textTheme: TextTheme(
                        headline1: TextStyle(
                          color: value,
                        ),
                        headline2: TextStyle(
                          color: value,
                        ),
                        headline3: TextStyle(
                          color: value,
                        ),
                        headline4: TextStyle(
                          color: value,
                        ),
                        headline5: TextStyle(
                          color: value,
                        ),
                        headline6: TextStyle(
                          color: value,
                        ),
                        subtitle1: TextStyle(
                          color: value,
                        ),
                        subtitle2: TextStyle(
                          color: value,
                        ),
                        bodyText1: TextStyle(
                          color: value,
                        ),
                        bodyText2: TextStyle(
                          color: value,
                        ),
                      )
                    )
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
