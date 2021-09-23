import 'package:flutter/material.dart';

class NewCollectionScreen extends StatelessWidget {
  const NewCollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('New Collection')),
        body: const Center(
          child: Text('New Collection Items'),
        ));
  }
}
