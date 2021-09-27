import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/collection/collection.dart';

class SecondPassScreen extends StatefulWidget {
  const SecondPassScreen({Key? key}) : super(key: key);

  @override
  _SecondPassScreenState createState() => _SecondPassScreenState();
}

class _SecondPassScreenState extends State<SecondPassScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(title: const Text('Second Pass')),
            body: Center(
                child:
                    Text('Collection id: ' + state.collection.id.toString())));
      },
    );
  }
}
