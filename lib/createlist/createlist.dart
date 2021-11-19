/// Copyright (C) 2021 Abigail Mabe - All Rights Reserved
/// You may use, distribute and modify this code under the terms 
/// of the license.
///
/// You should have received a copy of the license with this file.
/// If not, please email <mabe.abby.a@gmail.com>
/// 
/// Route to create a new list and set its name and other attributes.
/// 

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todotada/viewlist/viewlist.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:uuid/uuid.dart';

import '../themenotifier/themenotifier.dart';
import '../database/databasemanager.dart';
import '../listdata/todolist.dart';
import '../themenotifier/hexcolor.dart';

/// Define a custom Form widget.
/// 
class CreateListForm extends StatefulWidget {

  const CreateListForm({Key? key}) : super(key: key);

  @override
  CreateListFormState createState() {
    return CreateListFormState();
  }
}

/// Define a corresponding State class.
/// This class holds data related to the form.
///
class CreateListFormState extends State<CreateListForm> {

  /// 
  /// ---------------
  /// FIELDS
  /// ---------------
  /// 

  /// Create a global key that uniquely identifies the Form widget
  /// and allows validation of the form.
  ///
  /// Note: This is a `GlobalKey<FormState>`,
  /// not a GlobalKey<MyCustomFormState>.
  ///
  final formKey = GlobalKey<FormState>();

  /// Text controller to retrieve the current value
  /// of the TextField.
  /// 
  final textController = TextEditingController();

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

  /// Color to associate with this list.
  /// 
  /// Will be used when displaying the list in the grid as well
  /// as on the appbar when the list is viewed.
  /// 
  /// e.g., Colors.blue
  /// 
  Color listColor = Colors.blue;

  /// 
  /// ---------------
  /// END FIELDS
  /// ---------------
  /// 

  /// 
  /// ---------------
  /// FUNCTIONS
  /// ---------------
  /// 

  /// Clean up the controller when the widget is disposed.
  /// 
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  /// 
  /// ---------------
  /// END FUNCTIONS
  /// ---------------
  /// 
  
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    //
    return new Scaffold(
      appBar: AppBar(
        title: const Text('Create List'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: textController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }

                  return null;
                },
                style: TextStyle(color: textColor), // Change the color of the input text
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor, width: 1),
                  ),
                  hintText: 'List name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 24.0),
              child: ColorPickerSettingsTile(
                settingKey: 'last-color',
                title: 'List Color',
                defaultValue: Colors.blue,
                onChange: (value) {

                  listColor = value;
                  
                },
              ),
            ),
            ElevatedButton.icon(
              icon: Icon(
                Icons.add,
                color: textColor,
  
              ),
              label: Text('Create'),
              style: ElevatedButton.styleFrom(
                primary: primaryColor,
                onPrimary: textColor,
              ),
              onPressed: () async {
                // Validate returns true if the form is valid, or false otherwise.
                //
                if (formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  //
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Creating list...')),
                  );

                  /// Open the database.
                  /// 
                  Future<Database> database = DatabaseManager().open();

                  /// Create the TodoList object.
                  ///
                  var newList = TodoList(
                    listName: textController.text,
                    listColor: listColor.toHex(),
                    listType: "regular",
                    creationDate: DateTime.now().toString(),
                    lastUpdated: DateTime.now().toString(),
                    id: Uuid().v1(),
                  );

                  /// Insert the list into the database.
                  /// 
                  await DatabaseManager().insertList(newList, database);

                  Navigator.pop(context);

                }
              },
            ),
          ],
        ),
      ),
    );
  }
}