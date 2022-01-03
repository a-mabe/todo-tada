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
              return Stack(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: FractionallySizedBox(
                          heightFactor: 1, widthFactor: 1,
                          child: DragTarget<String>(
                            builder: (
                              BuildContext context,
                              List<dynamic> accepted,
                              List<dynamic> rejected,
                            ) {
                              return Container(color: Colors.orange);
                            },
                            onAccept: (data) {
                              debugPrint('hi $data');
                              setState(() {
                                print('Dropped in orange!');
                              });
                            },
                            onWillAccept: (data) {
                              return true;
                            },
                            onLeave: (data) {
                              print('Missed');
                            },
                          ),
                        ),
                      ),
                      
                      Flexible(
                        child: FractionallySizedBox(
                          heightFactor: 1, widthFactor: 1,
                          child: DragTarget<String>(
                            builder: (
                              BuildContext context,
                              List<dynamic> accepted,
                              List<dynamic> rejected,
                            ) {
                              return Container(color: Colors.green);
                            },
                            onAccept: (data) {
                              debugPrint('hi $data');
                              setState(() {
                                print('Dropped in green!');
                              });
                            },
                            onWillAccept: (data) {
                              return true;
                            },
                            onLeave: (data) {
                              print('Missed');
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: List.generate(snapshot.data!.length, (index) {
                      // return Text(snapshot.data![index].title);
                      return Positioned(
                        left: snapshot.data![index].dx,
                        top: snapshot.data![index].dy,
                        child: Draggable<String>(
                          // Data is the value this Draggable stores.
                          data: snapshot.data![index].icon,
                          maxSimultaneousDrags: 1,
                          onDragEnd: (details) => setState(() {

                            var updatedItem = TodoItem(
                              title: snapshot.data![index].title,
                              description: "",
                              icon: snapshot.data![index].icon,
                              status: 0,
                              id: snapshot.data![index].id,
                              listId: snapshot.data![index].listId,
                              dx: details.offset.dx + 5.0,
                              dy: details.offset.dy - 60.0,
                            );

                            Future<Database> database = DatabaseManager().open();

                            DatabaseManager().updateItems(updatedItem, database).then((_) {
                              setState(() {
                                snapshot.data![index].dx = details.offset.dx + 5.0;
                                snapshot.data![index].dy = details.offset.dy - 60.0;
                              });
                            });

                            print(details.offset);
                          }),
                          child: Container(
                            height: 50.0,
                            width: 50.0,
                            child: Image.asset(
                                snapshot.data![index].icon,
                              ),
                            ),
                          feedback: Container(
                              height: 70.0,
                              width: 70.0,
                              child: Image.asset(
                                snapshot.data![index].icon,
                              ),
                            ),
                          childWhenDragging: ColorFiltered(
                          /// Color matrix from https://medium.com/@samarth_agarwal/turn-images-to-grayscale-in-flutter-the-colorfiltered-widget-16de44cf8045
                          /// 
                          /// Used to gray out the PNG image that is left behind when dragging the
                          /// icon without having a gray box around the image.
                          /// 
                          colorFilter: ColorFilter.matrix(<double>[
                            0.2126,0.7152,0.0722,0,0,
                            0.2126,0.7152,0.0722,0,0,
                            0.2126,0.7152,0.0722,0,0,
                            0,0,0,1,0,
                          ]),
                          child: Container(
                          height: 50.0,
                          width: 50.0,
                          child: Image.asset(
                            snapshot.data![index].icon,
                            opacity: AlwaysStoppedAnimation<double>(0.4),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
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