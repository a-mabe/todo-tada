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
  final String listName;

  /// The hex color string associated with the list.
  /// 
  /// Used to color the tile for that list as well as the appbar when
  /// the list is opened.
  /// 
  /// e.g., "4287f5" which equates to Colors.blue
  /// 
  final String listColor;

  /// The type of list.
  /// 
  /// e.g., "regular" or "grocery" or "daily"
  /// 
  final String listType;

  /// The date and time that the list was created.
  /// 
  /// Stored in format "yyyy-mm-dd hh:mm:ss.00000"
  /// 
  /// e.g., "2021-10-13 15:47:03.788320"
  /// 
  final String creationDate;

  /// The date and time that the list was last updated.
  /// 
  /// Stored in format "yyyy-mm-dd hh:mm:ss.00000"
  /// 
  /// e.g., "2021-10-13 15:47:03.788320"
  /// 
  final String lastUpdated;

  /// Identifying string for the list.
  /// 
  /// e.g., '6c84fb90-12c4-11e1-840d-7b25c5ee775a'
  /// 
  final String id;

  /// The list of TodoItems that are considered still "to-do".
  /// 
  /// These items would appear on the to-do side of the list.
  /// 
  final List<TodoItem> itemsTodo = [];

  /// The list of TodoItems that are considered "done".
  /// 
  /// These items would appear on the done side of the list.
  /// 
  final List<TodoItem> itemsDone = [];

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

  TodoList({
    required this.listName,
    required this.listColor,
    required this.listType,
    required this.creationDate,
    required this.lastUpdated,
    required this.id
  });

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

  /// Convert a TodoList into a map.
  /// 
  /// Keys must correspond to the columns in the database.
  /// 
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'listName': listName,
      'listColor': listColor,
      'listType': listType,
      'creationDate': creationDate,
      'lastUpdated': lastUpdated
    };
  }

  /// Implement toString to print information about 
  /// each TodoList more easily.
  /// 
  @override
  String toString() {
    return 'TodoList{id: $id, listName: $listName, listColor: $listColor, listType: $listType, creationDate: $creationDate, lastUpdated: $lastUpdated, itemsTodo: $itemsTodo, itemsDone: $itemsDone}';
  }

  /// 
  /// -------------
  /// END FUNCTIONS
  /// -------------
  /// 
}