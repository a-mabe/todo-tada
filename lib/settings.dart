import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'themenotifier.dart';

class SettingsRoute extends StatefulWidget {

  // In the constructor, require a Todo.
  const SettingsRoute({Key? key, required this.themeNotifier}) : super(key: key);

  // Declare a field that holds the Todo.
  final ThemeNotifier themeNotifier;

  @override
  _SettingsRouteState createState() => _SettingsRouteState(themeNotifier: themeNotifier);
}

class _SettingsRouteState extends State<SettingsRoute> {

  // In the constructor, require a Todo.
  _SettingsRouteState({required this.themeNotifier});

  // Declare a field that holds the Todo.
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
              ColorPickerSettingsTile(
                settingKey: 'key-color-picker',
                title: 'Accent Color',
                defaultValue: Colors.blue,
                onChange: (value) {
                  debugPrint('key-color-picker: $value');

                  onThemeChanged(false, this.themeNotifier, ThemeData(
                      primaryColor: value,
                      brightness: Brightness.light,
                      backgroundColor: value,
                      accentColor: value,
                      accentIconTheme: IconThemeData(color: value),
                      dividerColor: value,
                      toggleableActiveColor: value,
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
