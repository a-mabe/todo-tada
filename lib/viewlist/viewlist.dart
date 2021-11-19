/// Copyright (C) 2021 Abigail Mabe - All Rights Reserved
/// You may use, distribute and modify this code under the terms 
/// of the license.
///
/// You should have received a copy of the license with this file.
/// If not, please email <mabe.abby.a@gmail.com>
/// 
/// Route that shows the selected to-do list.
/// 

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todotada/viewlist/additem.dart';
import '../listdata/todolist.dart';
import 'additem.dart';

/// Define a custom Form widget.
///
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

/// Define a corresponding State class.
/// This class holds data related to the form.
///
class ViewListState extends State<ViewList> {

  /// The list to view.
  /// 
  final TodoList list;

  ViewListState({required this.list});

  @override
  Widget build(BuildContext context) {
    /// Build a Form widget using the _formKey created above.
    ///
    return new Scaffold(
      appBar: AppBar(
        title: Text(list.listName),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                addItem();
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

  /// Adapted from https://stackoverflow.com/a/66434157
  /// 
  Future<List> fetchIconList() async {
    // Load as String.
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    // Decode to Map
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    // Filter by path.
    final filtered = manifestMap.keys
        .where((path) => path.startsWith('assets/icons/'))
        .toList();
    
    return filtered;
  }

  /// Navigates to the AddItem route.
  /// 
  void addItem() async {

    List images = await fetchIconList();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddItem(images: images, list: widget.list)),
    );
  }

}