import 'package:flutter/material.dart';
import 'package:todotada/main.dart';
import 'themenotifier.dart';

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
              child: TextField(
                style: TextStyle(color: textColor),
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
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}