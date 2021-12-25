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
import 'package:sqflite/sqflite.dart';
import 'package:todotada/database/databasemanager.dart';
import 'package:todotada/listdata/todoitem.dart';
import 'package:todotada/viewlist/additem.dart';
import '../listdata/todolist.dart';
import '../utility/loadingmessages.dart';
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

  /// The future list of lists from the database.
  /// 
  /// e.g., Future<List<TodoList>>
  /// 
  late Future<List<TodoItem>> _items;

  ViewListState({required this.list});

  @override
  Widget build(BuildContext context) {
    /// Build a Form widget using the _formKey created above.
    ///
    return new Scaffold(
      /// 
      /// -------------
      /// APPBAR
      /// -------------
      /// 
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
      /// 
      /// -------------
      /// END APPBAR
      /// -------------
      /// 

      /// 
      /// -------------
      /// BODY
      /// -------------
      /// 
      body: FutureBuilder<List<TodoItem>>(
        future: _items,
        builder: (BuildContext context, AsyncSnapshot<List<TodoItem>> snapshot) {

          // If the async event has completed.
          if(snapshot.connectionState == ConnectionState.done) {
            // Future async event has finsihed retrieving data.
            if (snapshot.hasData)
              return displayList(snapshot);
            // Event results in error.
            else if (snapshot.hasError)
              return loadingError(snapshot);
            // Has not completed or resulted in error.
            else
              return loading();
          } 
          // Async event is not executing.
          else
            return loading();
        },
      ),
    );
    /// 
    /// -------------
    /// END BODY
    /// -------------
    /// 
  }

  /// Load from the database on initState.
  /// 
  void initState() {
    super.initState();
    reloadLists(list.id);
  }

  /// Fetches the lists from the database.
  /// 
  void reloadLists(listId) async {
    _items = Future<List<TodoItem>>.delayed(
      Duration.zero,
      () {
        Future<Database> database = DatabaseManager().open();

        return DatabaseManager().getItemsByList(database, listId);
      },
    );
    print(await _items);
  }

  Widget displayList(snapshot) {
    return Center(
      child: GridView.count(
        // Create a grid with 2 columns.
        crossAxisCount: 2,
        // Generate the boxes in the grid from the stored lists.
        children: List.generate(snapshot.data!.length, (index) {
          return Text(snapshot.data![index].title);
        }),
      ),
    );
  }

  /// Navigates to the AddItem route.
  /// 
  void addItem() {

    // List images = await fetchIconList();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddItem(list: widget.list)),
    );
  }

}