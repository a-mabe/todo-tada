/// Copyright (C) 2021 Abigail Mabe - All Rights Reserved
/// You may use, distribute and modify this code under the terms 
/// of the license.
///
/// You should have received a copy of the license with this file.
/// If not, please email <mabe.abby.a@gmail.com>
/// 
/// Route that shows the selected to-do list.
/// 

import 'package:flutter/material.dart';
import '../themenotifier/themenotifier.dart';
import '../listdata/todolist.dart';

// Define a custom Form widget.
//
class ViewList extends StatefulWidget {

  /// The list to view.
  /// 
  final TodoList list;

  const ViewList({Key? key, required this.list}) : super(key: key);

  @override
  ViewListState createState() {
    return ViewListState(list: list);
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
//
class ViewListState extends State<ViewList> {

  ViewListState({required this.list});

  /// The list to view.
  /// 
  final TodoList list;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    //
    return new Scaffold(
      appBar: AppBar(
        title: Text(list.listName),
      ),
    );
  }
}