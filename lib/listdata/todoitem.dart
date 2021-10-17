/// Copyright (C) 2021 Abigail Mabe - All Rights Reserved
/// You may use, distribute and modify this code under the terms 
/// of the license.
///
/// You should have received a copy of the license with this file.
/// If not, please email <mabe.abby.a@gmail.com>
/// 
/// Defines a single item on a to-do list that needs to be done.
/// 

class TodoItem {  

  ///
  /// -------------
  /// FIELDS
  /// -------------
  ///

  /// The name of the to-do item.
  /// 
  /// e.g., "Vacuum"
  /// 
  final String title;

  /// Description for the to-do item.
  /// 
  /// e.g., "I need to do X but do it in Y way"
  /// 
  final String description;

  /// Icon to display for the to-do item.
  /// 
  /// e.g., "broom"
  /// 
  final String icon;

  /// Whether or not the to-do item is done.
  /// 
  /// i.e., 1 (true) for completed, 0 (false) for incomplete.
  /// 
  final int status;

  /// Identifying string for the item.
  /// 
  /// e.g., '6c84fb90-12c4-11e1-840d-7b25c5ee775a'
  /// 
  final String id;

  /// Identifying string for the list this item belongs to.
  /// 
  /// e.g., '6c84fb90-12c4-11e1-840d-7b25c5ee775a'
  /// 
  final String listId;

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

  TodoItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.status,
    required this.id,
    required this.listId
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

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'icon': icon,
      'status': status,
      'id': id,
      'listId': listId
    };
  }

  /// Implement toString to print information about 
  /// each TodoItem more easily.
  /// 
  @override
  String toString() {
    return 'TodoItem{id: $id, listId: $listId, title: $title, description: $description, icon: $icon, status: $status}';
  }

  /// 
  /// -------------
  /// END FUNCTIONS
  /// -------------
  /// 

}