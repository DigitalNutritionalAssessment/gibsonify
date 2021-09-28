import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/collection/collection.dart';

class SensitizationScreen extends StatelessWidget {
  const SensitizationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Sensitization')),
          body: Center(
              child: Text('Collection id: ' + state.collection.id.toString())),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.edit),
            onPressed: () => context.read<CollectionBloc>().add(
                CollectionUpdated(state.collection
                    .copyWith(id: _changeIdDemo(state.collection.id)))),
          ),
        );
      },
    );
  }

  // TODO: delete
  int _changeIdDemo(int id) {
    int _id = 0;
    if (id == 1) {
      _id = 2;
    } else {
      _id = 1;
    }
    return _id;
  }
}
