/// Copyright (C) 2021 Abigail Mabe - All Rights Reserved
/// You may use, distribute and modify this code under the terms 
/// of the license.
///
/// You should have received a copy of the license with this file.
/// If not, please email <mabe.abby.a@gmail.com>
/// 
/// Route to add an item to the list.
/// 

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todotada/utility/loadingmessages.dart';
import 'package:todotada/viewlist/edititem.dart';
import '../listdata/todolist.dart';

class AddItem extends StatefulWidget {

  /// The list to view.
  /// 
  final TodoList list;

  AddItem({Key? key, required this.list}) : super(key: key);

  @override
  AddItemState createState() {
    return AddItemState();
  }
}

class AddItemState extends State<AddItem> {

  /// The future list of images from the icon folder.
  /// 
  /// e.g., Future<List>
  /// 
  late Future<List> _images;

  /// Load from the database on initState.
  /// 
  void initState() {
    super.initState();
    fetchIconList();
  }

  @override
  Widget build(BuildContext context) {
    /// Build a Form widget using the _formKey created above.
    ///
    return new Scaffold(
      appBar: AppBar(
        title: Text("Add an Item"),
      ),
      body: FutureBuilder<List>(
        future: _images,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

          // If the async event has completed.
          if(snapshot.connectionState == ConnectionState.done) {
            // Future async event has finsihed retrieving data.
            if (snapshot.hasData)
              return displayIcons(snapshot);
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
  }

  /// Adapted from https://stackoverflow.com/a/66434157
  /// 
  void fetchIconList() async {
    _images = Future<List<String>>.delayed(
      Duration.zero,
      () async {
        // Load as String.
        final manifestContent = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

        // Decode to Map.
        final Map<String, dynamic> manifestMap = json.decode(manifestContent);

        // Filter by path.
        final filtered = manifestMap.keys
            .where((path) => path.startsWith('assets/icons/'))
            .toList();
        
        return filtered;
      },
    );
  }

  Widget displayIcons(snapshot) {
    return Center(
        child: GridView.count(
          /// Create a grid with 2 columns.
          /// 
          crossAxisCount: 4,
          /// Generate the items in the grid from the stored lists.
          /// 
          children: List.generate(snapshot.data!.length, (index) {
            return Center(
              child: createListBox(index, snapshot.data!),
            );
          }),
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