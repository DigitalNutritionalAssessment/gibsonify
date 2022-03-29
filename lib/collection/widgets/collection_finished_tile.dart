import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/collection/collection.dart';

class CollectionFinishedTile extends StatelessWidget {
  const CollectionFinishedTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return state.gibsonsForm.finished
            ? const ListTile(
                title: Text('This collection is finished'),
                subtitle: Text('Finished collections can no longer be edited'),
                tileColor: Colors.blue,
              )
            : const SizedBox.shrink();
      },
    );
  }
}
