/// Copyright (C) 2021 Abigail Mabe - All Rights Reserved
/// You may use, distribute and modify this code under the terms 
/// of the license.
///
/// You should have received a copy of the license with this file.
/// If not, please email <mabe.abby.a@gmail.com>
/// 
/// Tests the main route.
/// 

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:todotada/listdata/todolist.dart';
import 'package:uuid/uuid.dart';

import 'package:todotada/themenotifier/themenotifier.dart';
import 'package:todotada/main.dart';
import 'package:todotada/themenotifier/hexcolor.dart';

///
/// ---------
/// VARIABLES
/// ---------
///

final Color primaryColor = Colors.blue;
final Color textColor = Colors.black;

///
/// -------------
/// END VARIABLES
/// -------------
///

Widget createRoot(
    lists,
  ) => ChangeNotifierProvider<ThemeNotifier>(
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
              brightness: Brightness.light,
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
        child: Root(
          primaryColor, 
          textColor,
          Brightness.light,
          lists,
        ),
      );

void main() {
  group('Root Page Widget Test:', () {
    testWidgets('Testing Root Page Load and Empty Lists', (tester) async {

      List<TodoList> lists = [];

      // Create root page.
      await tester.pumpWidget(createRoot(
        lists,
      ));

      // Push past the loading spinner.
      await tester.pump(Duration(seconds: 1));

      // Find the title.
      expect(find.text('All Lists'), findsOneWidget);

      // Find the Add List floating action button.
      expect(find.widgetWithIcon(FloatingActionButton, Icons.add), findsOneWidget);

      // Find the menu button.
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('Testing Menu Drawer Opening on Root Page and Empty Lists', (tester) async {

      List<TodoList> lists = [];

      // Create root page.
      await tester.pumpWidget(createRoot(
        lists,
      ));

      // Push past the loading spinner.
      await tester.pump(Duration(seconds: 1));

      // Open the drawer.
      final ScaffoldState state = tester.firstState(find.byType(Scaffold));
      state.openDrawer();

      // Wait for the drawer.
      await tester.pump(Duration(seconds: 1));

      // Check that the drawer is open.
      expect(find.text('To-do, Tada'), findsOneWidget);
    });

    testWidgets('Root Page Displaying One List in the Grid', (tester) async {

      TodoList list_one = TodoList(
        listName: "Test List 1",
        listColor: Colors.orange.toHex(),
        listType: "regular",
        creationDate: DateTime.now().toString(),
        lastUpdated: DateTime.now().toString(),
        id: Uuid().v1(),
      );

      // Create root page.
      await tester.pumpWidget(createRoot(
        [list_one],
      ));

      // Push past the loading spinner.
      await tester.pump(Duration(seconds: 1));

      // Title of the list should be shown in the grid.
      expect(find.text('Test List 1'), findsOneWidget);

      // Should be 2 Inkwells, one is for the list, other is for the FAB.
      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('Root Page Displaying Multiple Lists in the Grid', (tester) async {

      TodoList list_one = TodoList(
        listName: "Test List 1",
        listColor: Colors.orange.toHex(),
        listType: "regular",
        creationDate: DateTime.now().toString(),
        lastUpdated: DateTime.now().toString(),
        id: Uuid().v1(),
      );

      TodoList list_two = TodoList(
        listName: "Test List 2",
        listColor: Colors.orange.toHex(),
        listType: "regular",
        creationDate: DateTime.now().toString(),
        lastUpdated: DateTime.now().toString(),
        id: Uuid().v1(),
      );

      TodoList list_three = TodoList(
        listName: "Test List 3",
        listColor: Colors.orange.toHex(),
        listType: "regular",
        creationDate: DateTime.now().toString(),
        lastUpdated: DateTime.now().toString(),
        id: Uuid().v1(),
      );

      List<TodoList> lists = [list_one, list_two, list_three];

      // Create root page.
      await tester.pumpWidget(createRoot(
        lists,
      ));

      // Push past the loading spinner.
      await tester.pump(Duration(seconds: 1));

      // Title of each list should be displayed in the grid.
      expect(find.text('Test List 1'), findsOneWidget);
      expect(find.text('Test List 2'), findsOneWidget);
      expect(find.text('Test List 3'), findsOneWidget);

      // Should be 4 Inkwells, 3 for the lists, other is for the FAB.
      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('Root Page Allow Tap to View List', (tester) async {

      TodoList list_one = TodoList(
        listName: "Test List 1",
        listColor: Colors.orange.toHex(),
        listType: "regular",
        creationDate: DateTime.now().toString(),
        lastUpdated: DateTime.now().toString(),
        id: Uuid().v1(),
      );

      List<TodoList> lists = [list_one];

      // Create root page.
      await tester.pumpWidget(createRoot(
        lists,
      ));

      // Push past the loading spinner.
      await tester.pump(Duration(seconds: 1));

      // Title of the list should be shown in the grid.
      expect(find.text('Test List 1'), findsOneWidget);

      // Should be 2 Inkwells, one is for the list, other is for the FAB.
      expect(find.byType(InkWell), findsWidgets);

      // Tap on the list to view it.
      await tester.tap(find.byType(InkWell).first);

      // Wait for the View List route to load.
      await tester.pumpAndSettle();

      // Should be moved off of the Root Page.
      expect(find.text('All Lists'), findsNothing);

      // Expect to find the list title on the AppBar.
      find.ancestor(of: find.byType(AppBar), matching: find.text("Test List 1"));

      // Should no longer be an Inkwell for the list.
      expect(find.byType(InkWell), findsNothing);
    });

  });
}
