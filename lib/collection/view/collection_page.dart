import 'package:flutter/material.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('New Recipe')),
        body: const Center(
          child: Text('New Recipe Items'),
        ));
  }
}
