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
import 'package:uuid/uuid.dart';

import '../themenotifier/themenotifier.dart';
import '../database/databasemanager.dart';
import '../listdata/todolist.dart';
import '../listdata/todoitem.dart';

/// Define a custom Form widget.
/// 
class EditItem extends StatefulWidget {

  /// The to-do item icon that the user tapped on.
  /// 
  final String icon;

  /// The list to view.
  /// 
  final TodoList list;

  const EditItem({Key? key, required this.icon, required this.list}) : super(key: key);

  @override
  EditItemState createState() {
    return EditItemState();
  }
}

/// Define a corresponding State class.
/// This class holds data related to the form.
///
class EditItemState extends State<EditItem> {

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
        title: const Text('Add To-do Item'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            /// Display the selected icon.
            /// 
            /// This way the user knows which one they selected as they name it.
            ///
            Padding(
              padding: EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 24.0),
              child: FractionallySizedBox(
                widthFactor: 0.35,
                child: Image(
                  image: AssetImage(widget.icon),
                ),
              ),
            ),
            /// Text box so the user can name the item.
            /// 
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
                  hintText: 'To-do item name',
                ),
              ),
            ),
            /// Add item button.
            /// 
            ElevatedButton.icon(
              icon: Icon(
                Icons.add,
                color: textColor,
  
              ),
              label: Text('Add to list'),
              style: ElevatedButton.styleFrom(
                primary: primaryColor,
                onPrimary: textColor,
              ),
              onPressed: () async {
                
                /// Validate returns true if the form is valid, or false otherwise.
                /// 
                
                if (formKey.currentState!.validate()) {
                  /// If the form is valid, display a snackbar. In the real world,
                  /// you'd often call a server or save the information in a database.
                  /// 
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Adding item...')),
                  );

                  /// Open the database.
                  /// 
                  Future<Database> database = DatabaseManager().open();

                  /// Create the new item.
                  /// 
                  var newItem = TodoItem(
                    title: textController.text,
                    description: "",
                    icon: widget.icon,
                    status: 0,
                    id: Uuid().v1(),
                    listId: widget.list.id,
                  );

                  /// Insert the list into the database.
                  /// 
                  await DatabaseManager().insertItem(newItem, database);

                  /// Navigate to the ViewList route for the created list and clear
                  /// the CreateList route from the stack so that the user goes 
                  /// back to the home page, not the CreateList page.
                  ///
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ViewList(list: widget.list),
                    ),
                    ModalRoute.withName('/'),
                  );

                }
              },
            ),
          ],
        ),
      ),
    );
  }
}