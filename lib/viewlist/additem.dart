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
import 'dart:convert';

import 'package:todotada/viewlist/edititem.dart';

class AddItem extends StatefulWidget {

  final List images;

  AddItem({Key? key, required this.images}) : super(key: key);

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
          // Create a grid with 2 columns.
          crossAxisCount: 4,
          // Generate the items in the grid from the stored lists.
          children: List.generate(widget.images.length, (index) {
            return Center(
              child: createListBox(index, widget.images),
            );
          }),
        ),
        // child: GridView.count(
        //   // Create a grid with 2 columns.
        //   crossAxisCount: 2,
        //   // Generate the items in the grid from the stored lists.
        //   children: List.generate(lists.length, (index) {
        //     return createListBox(index);
        //   }),
        // ),
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

            // var subset = items.where((item) => item.listId == lists[index].id);

            // print(subset.length);

            // viewList(lists[index]);

            debugPrint("Icon Tap");

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => EditItem(),
                ),
                ModalRoute.withName('/'),
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

    // return Padding(
    //   padding: EdgeInsets.all(15.0),
    //   child: Image(
    //       image: AssetImage(images[index],
    //     ),
    //   ),
    // );
    // return Padding( 
    //   /// Add padding around each grid box.
    //   /// 
    //   padding: EdgeInsets.all(15.0),
    //   /// Create the Ink widget to set the border radius.
    //   /// 
    //   child: Ink(
    //     decoration: BoxDecoration(
    //       color: HexColor.fromHex(lists[index].listColor),
    //       borderRadius: BorderRadius.all(Radius.circular(20.0)),
    //     ),
    //     /// Handle the onTap with InkWell.
    //     /// 
    //     child: InkWell(
    //       splashColor: Colors.white,
    //       customBorder: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(20),
    //       ),
    //       onTap: () {

    //         // var subset = items.where((item) => item.listId == lists[index].id);

    //         // print(subset.length);

    //         viewList(lists[index]);
    //       },
    //       /// Display list name, color, etc., in a Container.
    //       /// 
    //       child: Container(
    //         height: 80,
    //         width: 10,
    //         child: Center(child: Text(
    //           lists[index].listName,
    //           /// For now hardcode the textstyle.
    //           /// 
    //           style: TextStyle(
    //               color: Colors.white,
    //               fontWeight: FontWeight.bold,
    //               fontSize: 16.0,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}