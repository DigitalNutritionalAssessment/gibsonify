import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/collection/collection.dart';

class FirstPassScreen extends StatefulWidget {
  const FirstPassScreen({Key? key}) : super(key: key);

  @override
  _FirstPassScreenState createState() => _FirstPassScreenState();
}

class _FirstPassScreenState extends State<FirstPassScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(title: const Text('First Pass')),
            body: Center(
                child:
                    Text('Collection id: ' + state.collection.id.toString())));
      },
    );
  }
}
