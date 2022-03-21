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
              body: ListView.builder(
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
                                        gibsonsForm:
                                            homeState.gibsonsForms[index]!)),
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
                          title: Text(homeState
                              .gibsonsForms[index]!.respondentName.value),
                          subtitle: Text(homeState
                              .gibsonsForms[index]!.interviewDate.value),
                          // TODO: add trailing icon depending on whether collection is saved or not
                          onTap: () {
                            context.read<CollectionBloc>().add(
                                GibsonsFormProvided(
                                    gibsonsForm:
                                        homeState.gibsonsForms[index]!));
                            Navigator.pushNamed(context, PageRouter.collection);
                          },
                          onLongPress: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  DeleteCollectionDialog(
                                      gibsonsForm:
                                          homeState.gibsonsForms[index]!)),
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
                          context.read<CollectionBloc>().add(GibsonsFormCreated(
                              employeeNumber:
                                  loginState.loginInfo.employeeId!));
                          Navigator.pushNamed(context, PageRouter.collection);
                        })
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
    String? respondentName = gibsonsForm.respondentName.value;
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Delete collection'),
          content: Text(
              'Would you like to delete the collection of $respondentName?'),
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
