import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/navigation/navigation.dart';

class SecondPassScreen extends StatelessWidget {
  const SecondPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('First Pass'),
              actions: [
                IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, PageRouter.secondPassHelp),
                    icon: const Icon(Icons.help))
              ],
            ),
            body: Center(
                child: Text(
                    'DEMO Respondent name: ' + state.respondentName.value)));
      },
    );
  }
}

// TODO: second pass help
// TODO: second pass cards
