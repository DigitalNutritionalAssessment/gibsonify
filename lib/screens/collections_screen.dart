import 'package:flutter/material.dart';

import 'package:gibsonify/navigation/navigation.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({Key? key}) : super(key: key);

  @override
  _CollectionsScreenState createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Collections')),
        body: const Center(child: Text('List of Collections')),
        floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () =>
                      Navigator.pushNamed(context, ScreenRouter.newCollection))
            ]));
  }
}
