import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:provider/provider.dart';
import 'hexcolor.dart';
import 'settings.dart';
import 'themenotifier.dart';

///
/// ---------
/// VARIABLES
/// ---------
///

late final Color primaryColor;
late final Color textColor;
late final Brightness brightness;

///
/// -------------
/// END VARIABLES
/// -------------
///


///
/// Start the root of the app.
/// 
/// Initiates the root ThemeNotifier so the user may dynamically
/// select their theme. Based off of the method from the following article:
/// https://betterprogramming.pub/how-to-create-a-dynamic-theme-in-flutter-using-provider-e6ad1f023899.
/// 
/// 
///
void main() {
  initSettings().then((_) {
    final String primaryColorString = Settings.getValue<String>('primary-color-picker', "");
    if (primaryColorString != "") {
      primaryColor = HexColor.fromHex(primaryColorString);
    } else {
      primaryColor = Colors.blue; // Default
    }

    final String textColorString = Settings.getValue<String>('text-color-picker', "");
    if (textColorString != "") {
      textColor = HexColor.fromHex(textColorString);
    } else {
      textColor = Colors.black; // Default
    }

    if (Settings.getValue<bool>('dark-mode', true) == true) {
      brightness = Brightness.dark;
    } else {
      brightness = Brightness.light; // Default
    }

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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  //final ThemeChanger themeChanger;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text(
                'To-do, Tada', 
                style: TextStyle(fontSize: 18),

              ),
            ),
            ListTile(
              leading: new Icon(Icons.list_alt),
              title: const Text('All Lists'),
              onTap: () {
                // Update the state of the app.
                // ...
                // onThemeChanged(false, themeNotifier, );
              },
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title)
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how iFt sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add, color: Theme.of(context).textTheme.bodyText1?.color),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
/// 
/// -----------------
/// END MAIN APP PAGE
/// -----------------
/// 
