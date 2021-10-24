/// Copyright (C) 2021 Abigail Mabe - All Rights Reserved
/// You may use, distribute and modify this code under the terms 
/// of the license.
///
/// You should have received a copy of the license with this file.
/// If not, please email <mabe.abby.a@gmail.com>
/// 
/// Route to add an item to the list.
/// 

import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {

  const AddItem({Key? key}) : super(key: key);

  @override
  AddItemState createState() {
    return AddItemState();
  }
}

class AddItemState extends State<AddItem> {

  @override
  Widget build(BuildContext context) {
    /// Build a Form widget using the _formKey created above.
    ///
    return new Scaffold(
      appBar: AppBar(
        title: Text("Add an Item"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                print("Tappity tap");
              },
              child: Icon(
                Icons.add,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}