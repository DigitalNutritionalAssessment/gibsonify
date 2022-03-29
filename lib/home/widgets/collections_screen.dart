import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:gibsonify/home/home.dart';
import 'package:gibsonify/login/login.dart';
import 'package:gibsonify/navigation/navigation.dart';
import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify_api/gibsonify_api.dart';

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, loginState) {
      return BlocBuilder<HomeBloc, HomeState>(
        builder: (context, homeState) {
          return Scaffold(
              appBar: AppBar(title: const Text('Collections')),
              body: Column(
                children: [
                  homeState.collectionDuplicationMode
                      ? const ListTile(
                          title: Text(
                              'Please choose the collection for duplication'),
                          subtitle:
                              Text('Tap on the collection to be duplicated'),
                          tileColor: Colors.blue,
                        )
                      : const SizedBox.shrink(),
                  Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(2.0),
                        itemCount: homeState.gibsonsForms.length,
                        itemBuilder: (context, index) {
                          // TODO: Refactor to a standalone widget
                          return Slidable(
                            key: Key(homeState.gibsonsForms[index]!.id),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) => showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          DeleteCollectionDialog(
                                              gibsonsForm: homeState
                                                  .gibsonsForms[index]!)),
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                )
                              ],
                            ),
                            child: Card(
                              child: ListTile(
                                title: Text(
                                    // TODO: refactor
                                    isFieldUnmodifiedOrEmpty(homeState
                                            .gibsonsForms[index]!
                                            .respondentName)
                                        ? 'Unnamed respondent'
                                        : homeState.gibsonsForms[index]!
                                            .respondentName!),
                                subtitle: Row(
                                  children: [
                                    Text(isFieldUnmodifiedOrEmpty(homeState
                                            .gibsonsForms[index]!.interviewDate)
                                        ? 'Unspecified date'
                                        : homeState.gibsonsForms[index]!
                                            .interviewDate!),
                                    const VerticalDivider(),
                                    Text(homeState.gibsonsForms[index]!
                                            .interviewOutcome ??
                                        'Unspecified outcome')
                                  ],
                                ),
                                trailing: Column(
                                  children: [
                                    homeState.gibsonsForms[index]!.finished
                                        ? const Icon(Icons.done)
                                        : const Icon(Icons.pause),
                                    homeState.gibsonsForms[index]!.finished
                                        ? const Text('Finished')
                                        : const Text('Paused'),
                                  ],
                                ),
                                onTap: () {
                                  // TODO: remove this and allow read-only collection mode
                                  const collectionCompletedSnackBar = SnackBar(
                                      content: Text(
                                          'Selected collection is finished '
                                          'and can no longer be edited'));
                                  const collectionDuplicatedSnackBar = SnackBar(
                                      content: Text(
                                          'Selected collection has been '
                                          'duplicated, use it as a template '
                                          'and rewrite appropriate fields'));
                                  if (homeState.collectionDuplicationMode) {
                                    context.read<CollectionBloc>().add(
                                        GibsonsFormDuplicated(
                                            employeeNumber: loginState
                                                .loginInfo.employeeId!,
                                            gibsonsForm: homeState
                                                .gibsonsForms[index]!));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        collectionDuplicatedSnackBar);
                                    context
                                        .read<HomeBloc>()
                                        .add(const GibsonsFormsLoaded());
                                    context.read<HomeBloc>().add(
                                        const CollectionDuplicationModeToggled());
                                    return;
                                  }
                                  if (homeState.gibsonsForms[index]!.finished) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        collectionCompletedSnackBar);
                                  } else {
                                    context.read<CollectionBloc>().add(
                                        GibsonsFormProvided(
                                            gibsonsForm: homeState
                                                .gibsonsForms[index]!));
                                    Navigator.pushNamed(
                                        context, PageRouter.collection);
                                  }
                                },
                                onLongPress: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        DeleteCollectionDialog(
                                            gibsonsForm: homeState
                                                .gibsonsForms[index]!)),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
              floatingActionButton: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Visibility(
                      visible: !homeState.collectionDuplicationMode,
                      child: FloatingActionButton.extended(
                          heroTag: null,
                          label: const Text("New Collection"),
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            // TODO: Refactor into the Collection Page accepting a
                            // nullable instance of GibsonsForm as argument.
                            // In this case it will be null so a new GibsonsForm
                            // will be initialized
                            context.read<CollectionBloc>().add(
                                GibsonsFormCreated(
                                    employeeNumber:
                                        loginState.loginInfo.employeeId!));
                            Navigator.pushNamed(context, PageRouter.collection);
                          }),
                    ),
                    const SizedBox(height: 10),
                    FloatingActionButton.extended(
                        heroTag: null,
                        backgroundColor: homeState.collectionDuplicationMode
                            ? Colors.red
                            : null,
                        label: homeState.collectionDuplicationMode
                            ? const Text("Cancel Duplication Mode")
                            : const Text("Duplicate Collection"),
                        icon: homeState.collectionDuplicationMode
                            ? const Icon(Icons.cancel_outlined)
                            : const Icon(Icons.control_point_duplicate),
                        onPressed: () => context
                            .read<HomeBloc>()
                            .add(const CollectionDuplicationModeToggled())),
                  ]));
        },
      );
    });
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
