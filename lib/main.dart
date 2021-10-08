import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:provider/provider.dart';
import 'package:todotada/createlist/createlist.dart';
import 'settings/settings.dart';
import 'themenotifier/themenotifier.dart';
import 'createlist/createlist.dart';

///
/// ---------
/// VARIABLES
/// ---------
///

/// The primary theme color.
/// 
/// e.g., Colors.blue
/// 
late final Color primaryColor;

/// The main text color.
/// 
/// e.g., Colors.blue
/// 
late final Color textColor;

/// The theme brightness.
/// 
/// e.g., Brightness.light (light theme)
/// 
late final Brightness brightness;

///
/// -------------
/// END VARIABLES
/// -------------
///


/// Start the root of the app.
/// 
/// Initiates the root ThemeNotifier so the user may dynamically
/// select their theme. Based off of the method from the following article:
/// https://betterprogramming.pub/how-to-create-a-dynamic-theme-in-flutter-using-provider-e6ad1f023899.
///
void main() {
  initSettings().then((_) {

    /// Grab the primary color string.
    /// 
    /// e.g, "4287f5"
    /// 
    primaryColor = getPrimaryColor();

    /// Grab the text color string.
    /// 
    /// e.g, "4287f5"
    /// 
    textColor = getTextColor();

    /// Get whether or not darkmode is enabled.
    /// 
    /// e.g., "true"
    /// 
    brightness = getBrightnessMode();

    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(ThemeData(
            primaryColor: primaryColor,
            brightness: brightness,
            backgroundColor: primaryColor,
            accentColor: primaryColor,
            accentIconTheme: IconThemeData(color: primaryColor),
            iconTheme: IconThemeData(
              color: primaryColor
            ),
            dividerColor: primaryColor,
            toggleableActiveColor: primaryColor,
            appBarTheme: AppBarTheme(
              backgroundColor: primaryColor,
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
            ),
          )
        ),
        child: Root(),
      ),
    );
  });
}


/// 
/// Initialize the settings plugin.
/// 
Future<void> initSettings() async {
  await Settings.init();
}


/// 
/// ---------------
/// ROOT OF THE APP
/// ---------------
/// 
class Root extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: 'Todo Tada',
      theme: themeNotifier.getTheme(),
      home: MainPage(title: 'All Lists'),
    );
  }
}
/// 
/// ---------------
/// END ROOT OF THE APP
/// ---------------
///


/// 
/// -------------
/// MAIN APP PAGE
/// -------------
/// 
class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.title}) : super(key: key);

  /// Title of the app.
  /// 
  /// e.g., "To-do, Tada"
  /// 
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {

    /// The theme notifier object.
    /// 
    /// Used to update the app on theme changes.
    /// 
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text(
                'To-do, Tada', 
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container (
              decoration: new BoxDecoration (
                  color: Colors.grey
              ),
              child: new ListTile (
                  leading: const Icon(Icons.list_alt),
                  title: Text('All Lists')
              )
            ),
            ListTile(
              leading: new Icon(Icons.today),
              title: const Text('Daily Lists'),
              onTap: () {

              },
            ),
            ListTile(
              leading: new Icon(Icons.checklist),
              title: const Text('Check Lists'),
              onTap: () {

              },
            ),
            ListTile(
              leading: new Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsRoute(
                      themeNotifier: themeNotifier, 
                    )),
                  );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(widget.title)
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createList,
        tooltip: 'Increment',
        child: Icon(Icons.add, color: Theme.of(context).textTheme.bodyText1?.color),
      ),
    );
  }

  void createList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateListForm()),
    );
  }

}
/// 
/// -----------------
/// END MAIN APP PAGE
/// -----------------
/// 
