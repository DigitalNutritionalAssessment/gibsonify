import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:gibsonify/home/home.dart';
import 'package:gibsonify/navigation/navigation.dart';
import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify_api/gibsonify_api.dart';

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(title: const Text('Collections')),
            body: ListView.builder(
                padding: const EdgeInsets.all(2.0),
                itemCount: state.gibsonsForms.length,
                itemBuilder: (context, index) {
                  // TODO: Refactor to a standalone widget
                  return Slidable(
                    key: Key(state.gibsonsForms[index]!.id),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  DeleteCollectionDialog(
                                      gibsonsForm: state.gibsonsForms[index]!)),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        )
                      ],
                    ),
                    child: Card(
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(
                            // TODO: refactor
                            isFieldUnmodifiedOrEmpty(
                                    state.gibsonsForms[index]!.respondentName)
                                ? 'Unnamed respondent'
                                : state.gibsonsForms[index]!.respondentName!),
                        subtitle: Text(isFieldUnmodifiedOrEmpty(
                                state.gibsonsForms[index]!.interviewDate)
                            ? 'Unspecified date'
                            : state.gibsonsForms[index]!.interviewDate!),
                        // TODO: add trailing icon depending on whether collection is saved or not
                        onTap: () {
                          context.read<CollectionBloc>().add(
                              GibsonsFormProvided(
                                  gibsonsForm: state.gibsonsForms[index]!));
                          Navigator.pushNamed(context, PageRouter.collection);
                        },
                        onLongPress: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                DeleteCollectionDialog(
                                    gibsonsForm: state.gibsonsForms[index]!)),
                      ),
                    ),
                  );
                }),
            floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton.extended(
                      heroTag: null,
                      label: const Text("New Collection"),
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        // TODO: Refactor into the Collection Page accepting a
                        // nullable instance of GibsonsForm as argument.
                        // In this case it will be null so a new GibsonsForm
                        // will be initialized
                        context
                            .read<CollectionBloc>()
                            .add(const GibsonsFormCreated());
                        Navigator.pushNamed(context, PageRouter.collection);
                      })
                ]));
      },
    );
  }
}

class DeleteCollectionDialog extends StatelessWidget {
  final GibsonsForm gibsonsForm;
  const DeleteCollectionDialog({Key? key, required this.gibsonsForm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String displayRespondentName =
        isFieldUnmodifiedOrEmpty(gibsonsForm.respondentName)
            ? 'unnamed respondent'
            : gibsonsForm.respondentName!;
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Delete collection'),
          content: Text(
              'Would you like to delete the collection of $displayRespondentName?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context
                    .read<HomeBloc>()
                    .add(GibsonsFormDeleted(id: gibsonsForm.id));
                Navigator.pop(context, 'Delete');
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
