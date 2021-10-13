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
import 'package:todotada/viewlist/viewlist.dart';
import '../themenotifier/themenotifier.dart';

// Define a custom Form widget.
//
class CreateListForm extends StatefulWidget {
  const CreateListForm({Key? key}) : super(key: key);

  @override
  CreateListFormState createState() {
    return CreateListFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
//
class CreateListFormState extends State<CreateListForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  //
  final _formKey = GlobalKey<FormState>();

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
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
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
            ElevatedButton.icon(
              icon: Icon(
                Icons.add,
                color: textColor,
  
              ),
              label: Text('Create'),
              style: ElevatedButton.styleFrom(
                primary: primaryColor,
                onPrimary: textColor
              ),
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                //
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  //
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Creating list...')),
                  );

                  /// Navigate to the ViewList route for the created list and clear
                  /// the CreateList route from the stack so that the user goes 
                  /// back to the home page, not the CreateList page.
                  ///
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ViewList(),
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