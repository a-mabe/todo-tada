/// Copyright (C) 2021 Abigail Mabe - All Rights Reserved
/// You may use, distribute and modify this code under the terms 
/// of the license.
///
/// You should have received a copy of the license with this file.
/// If not, please email <mabe.abby.a@gmail.com>
/// 
/// Defines a to-do list.
/// 

import "todoitem.dart";

class TodoList {  
   
  ///
  /// -------------
  /// FIELDS
  /// -------------
  ///

  /// The name of the to-do list.
  /// 
  /// e.g., "Tuesday's Cleaning List"
  /// 
  String listName = "To-do List";

  /// The hex color string associated with the list.
  /// 
  /// Used to color the tile for that list as well as the appbar when
  /// the list is opened.
  /// 
  /// e.g., "4287f5" which equates to Colors.blue
  /// 
  String listColor = "4287f5";

  /// The type of list.
  /// 
  /// e.g., "regular" or "grocery" or "daily"
  /// 
  String listType = "regular";

  /// The date and time that the list was created.
  /// 
  /// Stored in format "yyyy-mm-dd hh:mm:ss.00000"
  /// 
  /// e.g., "2021-10-13 15:47:03.788320"
  /// 
  String creationDate = DateTime.now().toString();

  /// The date and time that the list was last updated.
  /// 
  /// Stored in format "yyyy-mm-dd hh:mm:ss.00000"
  /// 
  /// e.g., "2021-10-13 15:47:03.788320"
  /// 
  String lastUpdated = DateTime.now().toString();

  /// Identifying number for the list.
  /// 
  /// e.g., 9
  /// 
  int id = 0;

  /// The list of TodoItems that are considered still "to-do".
  /// 
  /// These items would appear on the to-do side of the list.
  /// 
  List<TodoItem> itemsTodo = [];

  /// The list of TodoItems that are considered "done".
  /// 
  /// These items would appear on the done side of the list.
  /// 
  List<TodoItem> itemsDone = [];

  /// 
  /// -------------
  /// END FIELDS
  /// -------------
  /// 

  ///
  /// -------------
  /// GETTERS/SETTERS
  /// -------------
  ///

  /// 
  /// -------------
  /// END GETTERS/SETTERS
  /// -------------
  /// 

  ///
  /// -------------
  /// CONSTRUCTORS
  /// -------------
  ///

  TodoList.namedConst(String listName,
                      String listColor,
                      String listType,
                      String creationDate,
                      String lastUpdated,
                      int id,
                      List<TodoItem> itemsTodo,
                      List<TodoItem> itemsDone) {
    this.listName = listName;
    this.listColor = listColor;
    this.listType = listType;
    this.creationDate = creationDate;
    this.lastUpdated = lastUpdated;
    this.id = id;
    this.itemsTodo = itemsTodo;
    this.itemsDone = itemsDone;
  }

  /// 
  /// -------------
  /// END CONSTRUCTORS
  /// -------------
  /// 

  ///
  /// -------------
  /// FUNCTIONS
  /// -------------
  ///

  /// 
  /// -------------
  /// END FUNCTIONS
  /// -------------
  /// 
}