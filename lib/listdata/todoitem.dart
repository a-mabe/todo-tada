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
  String title = "To-do";

  /// Description for the to-do item.
  /// 
  /// e.g., "I need to do X but do it in Y way"
  /// 
  String description = "I need to do X but do it in Y way";

  /// Icon to display for the to-do item.
  /// 
  /// e.g., "broom"
  /// 
  String icon = "vacuum";

  /// Whether or not the to-do item is done.
  /// 
  /// i.e., true for completed, false for incomplete.
  /// 
  bool status = false;

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
  
  TodoItem.namedConst(String title,
                      String description,
                      String icon,
                      bool status) {
    this.title = title;
    this.description = description;
    this.icon = icon;
    this.status = status;
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