import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'dart:async';
//import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';

//This file is created so that the probe list can be changed according to which recipe is used
//In addition

// MyApp is a StatefulWidget. This allows updating the state of the
// widget when an item is removed.

class SwipeToDelete extends StatefulWidget {
  SwipeToDelete({Key key}) : super(key: key);

  @override
  DeleteState createState() {
    return DeleteState();
  }
}

class DeleteState extends State<SwipeToDelete> {
  final items = List<String>.generate(20, (i) => 'Item ${i + 1}');

  @override
  Widget build(BuildContext context) {
    final title = 'Dismissing Items';

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify widgets.
              key: Key(item),
              // Provide a function that tells the app
              // what to do after an item has been swiped away.
              onDismissed: (direction) {
                // Remove the item from the data source.
                setState(() {
                  items.removeAt(index);
                });

                // Then show a snackbar.
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('$item deleted')));
              },
              // Show a red background as the item is swiped away.
              background: Container(color: Colors.red[300]),
              child: ListTile(title: Text('$item')),
            );
          },
        ),
      ),
    );
  }
}