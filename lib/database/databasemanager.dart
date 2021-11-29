/// Copyright (C) 2021 Abigail Mabe - All Rights Reserved
/// You may use, distribute and modify this code under the terms 
/// of the license.
///
/// You should have received a copy of the license with this file.
/// If not, please email <mabe.abby.a@gmail.com>
/// 
/// Defines the Database Manager class which defines the database
/// and its helper functions.
/// 

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../listdata/todolist.dart';
import '../listdata/todoitem.dart';

class DatabaseManager {

  ///
  /// -------------
  /// FIELDS
  /// -------------
  ///

  /// The name of the database.
  /// 
  /// e.g., "database.db"
  /// 
  static final String databaseName = "todo-tada.db";

  /// The name of the table in the database where lists are stored.
  /// 
  /// e.g., "lists"
  /// 
  static final String listTableName = "lists";

  /// The name of the table in the database where items are stored.
  /// 
  /// e.g., "items"
  /// 
  static final String itemTableName = "items";

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

  /// Opens the database.
  /// 
  Future<Database> open() async {
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), databaseName),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        db.execute(
          '''
          CREATE TABLE lists(id TEXT PRIMARY KEY,
          listName TEXT,
          listColor TEXT,
          listType TEXT,
          creationDate TEXT,
          lastUpdated TEXT,
          itemsTodo TEXT,
          itemsDone TEXT
          )
          ''',
        );
        db.execute(
          '''
          CREATE TABLE items(listId TEXT PRIMARY KEY,
          id TEXT,
          title TEXT,
          description TEXT,
          icon TEXT,
          status INTEGER
          )
          ''',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  /// Inserts the given list into the given database.
  /// 
  Future<void> insertList(TodoList todoList, Future<Database> database) async {

    /// Get a reference to the database.
    /// 
    final db = await database;

    /// Insert the TodoList into the correct table.
    ///
    /// In this case, replace any previous data.
    /// 
    await db.insert(
      listTableName,
      todoList.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Inserts the given item into the given database.
  /// 
  Future<void> insertItem(TodoItem todoItem, Future<Database> database) async {

    /// Get a reference to the database.
    /// 
    final db = await database;

    /// Insert the TodoList into the correct table.
    ///
    /// In this case, replace any previous data.
    /// 
    await db.insert(
      itemTableName,
      todoItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Update the given list in the given database.
  /// 
  Future<void> updateList(TodoList todoList, Future<Database> database) async {

    /// Get a reference to the database.
    /// 
    final db = await database;

    await db.update(
      listTableName,
      todoList.toMap(),
      where: 'id = ?',  // Ensure that the List has a matching id.
      whereArgs: [todoList.id], // Pass the id as a whereArg to prevent SQL injection.
    );
  }

  /// Update the given list in the given database.
  /// 
  Future<void> updateItems(TodoItem todoItem, Future<Database> database) async {

    /// Get a reference to the database.
    /// 
    final db = await database;

    await db.update(
      listTableName,
      todoItem.toMap(),
      where: 'id = ?',  // Ensure that the List has a matching id.
      whereArgs: [todoItem.id], // Pass the id as a whereArg to prevent SQL injection.
    );
  }

  Future<void> deleteList(int id, Future<Database> database) async {
    
    /// Get a reference to the database.
    /// 
    final db = await database;

    await db.delete(
      listTableName,
      where: 'id = ?', // Use a `where` clause to delete a specific list.
      whereArgs: [id], // Pass the List's id as a whereArg to prevent SQL injection.
    );
  }

  Future<void> deleteItem(int id, Future<Database> database) async {
    
    /// Get a reference to the database.
    /// 
    final db = await database;

    await db.delete(
      listTableName,
      where: 'id = ?', // Use a `where` clause to delete a specific list.
      whereArgs: [id], // Pass the List's id as a whereArg to prevent SQL injection.
    );
  }

  Future<List<TodoList>> lists(Future<Database> database, List<TodoList>? lists) async {

    if (lists != null) 
      return lists;
    else {

      /// Get a reference to the database.
      /// 
      final db = await database;

      /// Query the table for all the TodoLists.
      /// 
      final List<Map<String, dynamic>> maps = await db.query(listTableName);

      return List.generate(maps.length, (i) {
        return TodoList(
          listName: maps[i]['listName'], 
          listColor: maps[i]['listColor'], 
          listType: maps[i]['listType'], 
          creationDate: maps[i]['creationDate'], 
          lastUpdated: maps[i]['lastUpdated'], 
          id: maps[i]['id'],
          );
        });

    }
    
  }

  Future<List<TodoItem>> items(Future<Database> database) async {
    
    /// Get a reference to the database.
    /// 
    final db = await database;

    /// Query the table for all the TodoItems.
    /// 
    final List<Map<String, dynamic>> maps = await db.query(itemTableName);

    /// Convert the List<Map<String, dynamic> into a List<TodoItem>.
    /// 
    return List.generate(maps.length, (i) {
      return TodoItem(
        title: maps[i]['title'],
        description: maps[i]['description'],
        icon: maps[i]['icon'],
        status: maps[i]['status'],
        id: maps[i]['id'],
        listId: maps[i]['listId'],
      );
    });
  }

  /// 
  /// -------------
  /// END FUNCTIONS
  /// -------------
  /// 

}
