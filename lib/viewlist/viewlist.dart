import 'package:flutter/material.dart';
import 'package:todotada/main.dart';
import '../themenotifier/themenotifier.dart';

// Define a custom Form widget.
//
class ViewList extends StatefulWidget {
  const ViewList({Key? key}) : super(key: key);

  @override
  ViewListState createState() {
    return ViewListState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
//
class ViewListState extends State<ViewList> {

  /// Grab the primary color string.
  /// 
  /// e.g, "4287f5"
  /// 
  final Color primaryColor = getPrimaryColor();

  /// Grab the text color string.
  /// 
  /// e.g, "4287f5"
  /// 
  final Color textColor = getTextColor();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    //
    return new Scaffold(
      appBar: AppBar(
        title: const Text('Create List'),
      ),
    );
  }
}