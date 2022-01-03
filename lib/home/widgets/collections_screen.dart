import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:gibsonify/navigation/navigation.dart';
import 'package:gibsonify/collection/collection.dart';

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
        body: Center(
            child: Column(
          children: [
            // TODO: Implement dynamic Listview with multiple collections
            const Divider(),
            BlocBuilder<CollectionBloc, CollectionState>(
              builder: (context, state) {
                return ListTile(
                    leading: const Icon(Icons.description),
                    title: Text(state.gibsonsForm.respondentName.value),
                    subtitle: Text(state.gibsonsForm.interviewDate.value),
                    // TODO: Change to state.fourthPassStatus.isSubmissionSuccess
                    trailing: state
                            .gibsonsForm.sensitizationStatus.isSubmissionSuccess
                        ? const Icon(Icons.done)
                        : const Icon(Icons.pause),
                    // TODO: Implement switching to last opened page
                    onTap: () {
                      // TODO: Refactor into the Collection Page accepting a
                      // nullable instance of GibsonsForm as argument.
                      // In this case the given GIbsonsForm will be passed, so
                      // that no loading from API will be necessary.
                      context.read<CollectionBloc>().add(GibsonsFormLoaded());
                      Navigator.pushNamed(context, PageRouter.collection);
                    });
              },
            ),
            const Divider()
          ],
        )),
        floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    // TODO: Refactor into the Collection Page accepting a
                    // nullable instance of GibsonsForm as argument.
                    // In this case it will be null so a new GibsonsForm
                    // will be initialized
                    context.read<CollectionBloc>().add(GibsonsFormCreated());
                    Navigator.pushNamed(context, PageRouter.collection);
                  })
            ]));
  }
}
