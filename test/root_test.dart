// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:todotada/themenotifier.dart';
import 'package:todotada/main.dart';

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

Widget createRoot() => ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(ThemeData(
            primaryColor: primaryColor,
            brightness: Brightness.light,
            backgroundColor: primaryColor,
            accentColor: primaryColor,
            accentIconTheme: IconThemeData(color: primaryColor),
            iconTheme: IconThemeData(
              color: Colors.pink
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
      );

void main() {
  group('Root Page Widget Test', () {
    testWidgets('Testing Root Page Load', (tester) async {
      // Create root page
      await tester.pumpWidget(createRoot());

      // Find the title
      expect(find.text('All Lists'), findsOneWidget);

      // Find the Add List floating action button
      expect(find.widgetWithIcon(FloatingActionButton, Icons.add), findsOneWidget);

      // Find the menu button
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('Testing Menu Drawer Opening on Root Page', (tester) async {
      // Create root page
      await tester.pumpWidget(createRoot());

      // Open the drawer
      final ScaffoldState state = tester.firstState(find.byType(Scaffold));
      state.openDrawer();

      // Wait for the drawer to open
      await tester.pumpAndSettle();

      // Check that the drawer is open
      expect(find.text('To-do, Tada'), findsOneWidget);
    });

  });
}
