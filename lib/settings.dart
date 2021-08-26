import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class SettingsRoute extends StatefulWidget {
  @override
  _SettingsRouteState createState() => _SettingsRouteState();
}

class _SettingsRouteState extends State<SettingsRoute> {
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
                },
              )
            ],
          ),
          ModalSettingsTile(
            title: 'Other settings',
            subtitle: 'Other Settings in a Dialog',
            children: <Widget>[
              SliderSettingsTile(
                title: 'Custom Ratio',
                settingKey: 'key-custom-ratio-slider-2',
                defaultValue: 2.5,
                min: 1,
                max: 5,
                step: 0.1,
                leading: Icon(Icons.aspect_ratio),
                onChange: (value) {
                  debugPrint('\n===== on change =====\n'
                      'key-custom-ratio-slider-2: $value'
                      '\n==========\n');
                },
                onChangeStart: (value) {
                  debugPrint('\n===== on change start =====\n'
                      'key-custom-ratio-slider-2: $value'
                      '\n==========\n');
                },
                onChangeEnd: (value) {
                  debugPrint('\n===== on change end =====\n'
                      'key-custom-ratio-slider-2: $value'
                      '\n==========\n');
                },
              ),
              ColorPickerSettingsTile(
                settingKey: 'key-color-picker-2',
                title: 'Accent Picker',
                defaultValue: Colors.blue,
                onChange: (value) {
                  debugPrint('key-color-picker-2: $value');
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
