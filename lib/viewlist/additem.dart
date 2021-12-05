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
import 'package:todotada/viewlist/edititem.dart';
import '../listdata/todolist.dart';

class AddItem extends StatefulWidget {

  /// The list of icons.
  /// 
  final List images;

  /// The list to view.
  /// 
  final TodoList list;

  AddItem({Key? key, required this.images, required this.list}) : super(key: key);

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
      ),
      body: Center(
        child: GridView.count(
          /// Create a grid with 2 columns.
          /// 
          crossAxisCount: 4,
          /// Generate the items in the grid from the stored lists.
          /// 
          children: List.generate(widget.images.length, (index) {
            return Center(
              child: createListBox(index, widget.images),
            );
          }),
        ),
      ),
    );
  }

  /// Constructs the grid box to display a list.
  /// 
  Widget createListBox(index, images) {

    return Padding( 
      /// Add padding around each grid box.
      /// 
      padding: EdgeInsets.all(15.0),
      /// Create the Ink widget to set the border radius.
      /// 
      child: Ink(
        /// Handle the onTap with InkWell.
        /// 
        child: InkWell(
          splashColor: Colors.white,
          customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => EditItem(icon: images[index], list: widget.list),
                ),
              );
          },
          /// Display list name, color, etc., in a Container.
          /// 
          child: Image(
              image: AssetImage(images[index],
            ),
          ),
        ),
      ),
    );
  }
}