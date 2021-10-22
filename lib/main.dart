/// Copyright (C) 2021 Abigail Mabe - All Rights Reserved
/// You may use, distribute and modify this code under the terms 
/// of the license.
///
/// You should have received a copy of the license with this file.
/// If not, please email <mabe.abby.a@gmail.com>
/// 
/// Route for the Root Page that loads on startup.
/// 

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todotada/createlist/createlist.dart';
import 'package:todotada/listdata/todolist.dart';
import 'package:todotada/viewlist/viewlist.dart';
import 'settings/settings.dart';
import 'themenotifier/themenotifier.dart';
import 'createlist/createlist.dart';
import 'database/databasemanager.dart';
import 'listdata/todolist.dart';
import 'listdata/todoitem.dart';
import 'themenotifier/hexcolor.dart';


///
/// ---------
/// FIELDS
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

/// The number of lists in the database.
/// 
/// e.g., 3
/// 
late int numberOfLists;

/// The List of TodoLists in the database.
/// 
/// e.g., List<TodoLists>
/// 
late List<TodoList> lists;

/// The List of TodoItems in the database.
/// 
/// e.g., List<TodoItems>
/// 
late List<TodoItem> items;

/// The amount of padding around a grid block.
/// 
/// e.g., 8.0
/// 
final double gridPadding = 40.0;

///
/// -------------
/// END FIELDS
/// -------------
///


/// Start the root of the app.
/// 
/// Initiates the root ThemeNotifier so the user may dynamically
/// select their theme. Based off of the method from the following article:
/// https://betterprogramming.pub/how-to-create-a-dynamic-theme-in-flutter-using-provider-e6ad1f023899.
///
void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Future<Database> database = DatabaseManager().open();

  lists = await DatabaseManager().lists(database);
  items = await DatabaseManager().items(database);
  numberOfLists = lists.length;

  /// Run app once settings are initialized.
  /// 
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
            colorScheme: ColorScheme(
              primary: primaryColor,
              onPrimary: primaryColor,
              primaryVariant: primaryColor,
              background: primaryColor,
              onBackground: primaryColor,
              secondary: primaryColor,
              onSecondary: primaryColor,
              secondaryVariant: primaryColor,
              error: primaryColor,
              onError: primaryColor,
              surface: primaryColor,
              onSurface: primaryColor,
              brightness: brightness,
            ),
            iconTheme: IconThemeData(
              color: primaryColor,
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              foregroundColor: primaryColor,
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: primaryColor,
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
          ),
        ),
        child: Root(),
      ),
    );
  });
}


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
                  color: Colors.grey,
              ),
              child: new ListTile (
                  leading: const Icon(Icons.list_alt),
                  title: Text('All Lists'),
              ),
            ),
            ListTile(
              leading: new Icon(Icons.today),
              title: const Text('Daily Lists'),
              // onTap: () {

              // },
            ),
            ListTile(
              leading: new Icon(Icons.checklist),
              title: const Text('Check Lists'),
              // onTap: () {

              // },
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
        title: Text(widget.title),
      ),
      body: Center(
        child: GridView.count(
          // Create a grid with 2 columns.
          crossAxisCount: 2,
          // Generate the items in the grid from the stored lists.
          children: List.generate(lists.length, (index) {
            return createListBox(index);
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createList,
        tooltip: 'Create new list',
        child: Icon(Icons.add, color: Theme.of(context).textTheme.bodyText1?.color),
      ),
    );
  }

  /// Navigates to the CreateListForm route.
  /// 
  void createList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateListForm()),
    );
  }

  /// Navigates to the ViewList route for the selected list.
  /// 
  void viewList(selectedList) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewList(list: selectedList)),
    );
  }

  /// Constructs the grid box to display a list item.
  /// 
  Widget createListBox(index) {
    return Padding( // Add padding.
            padding: EdgeInsets.all(15.0),
            // Create the Ink widget to set the border radius.
            child: Ink(
              decoration: BoxDecoration(
                color: HexColor.fromHex(lists[index].listColor),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                  ),
              ),
              // Handle the onTap with InkWell.
              child: InkWell(
                splashColor: Colors.white,
                customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                ),
                onTap: () {
                  viewList(lists[index]);
                },
                // Display list name, etc., in a Container.
                child: Container(
                  height: 80,
                  width: 10,
                  child: Center(child: Text(
                    lists[index].listName,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }

}
/// 
/// -----------------
/// END MAIN APP PAGE
/// -----------------
/// 
