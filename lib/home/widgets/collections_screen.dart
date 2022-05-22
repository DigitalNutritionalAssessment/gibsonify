import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              appBar: AppBar(
                title: const Text('Collections'),
                actions: [
                  IconButton(
                      onPressed: () => Navigator.pushNamed(
                          context, PageRouter.collectionsHelp),
                      icon: const Icon(Icons.help))
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(2.0),
                        itemCount: homeState.gibsonsForms.length,
                        itemBuilder: (context, index) {
                          // TODO: Refactor to a standalone widget
                          return Card(
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
                                  context.read<CollectionBloc>().add(
                                      GibsonsFormProvided(
                                          gibsonsForm:
                                              homeState.gibsonsForms[index]!));
                                  Navigator.pushNamed(
                                      context, PageRouter.collection);
                                },
                                onLongPress: () => showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return CollectionOptions(
                                          gibsonsForm:
                                              homeState.gibsonsForms[index]!,
                                          employeeNumber:
                                              loginState.loginInfo.employeeId!);
                                    })),
                          );
                        }),
                  ),
                ],
              ),
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
                        }),
                  ]));
        },
      );
    });
  }
}

class CollectionOptions extends StatelessWidget {
  const CollectionOptions(
      {Key? key, required this.gibsonsForm, required this.employeeNumber})
      : super(key: key);

  final GibsonsForm gibsonsForm;
  final String employeeNumber;

  @override
  Widget build(BuildContext context) {
    String displayRespondentName =
        isFieldUnmodifiedOrEmpty(gibsonsForm.respondentName)
            ? 'unnamed respondent'
            : gibsonsForm.respondentName!;
    SnackBar collectionDuplicatedSnackBar = SnackBar(
        content: Text('Collection of $displayRespondentName has been '
            'duplicated, use it as a template '
            'and rewrite appropriate fields'));
    SnackBar collectionDeletedSnackBar = SnackBar(
        content: Text('Collection of $displayRespondentName has been deleted'));
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        final List<Widget> options = [
          ListTile(
              title: Text(('Options of $displayRespondentName collection'))),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.copy),
            title: const Text('Duplicate'),
            onTap: () {
              // TODO: Place the duplicated collection under the original
              // This requires modifying how collections are saved
              context.read<CollectionBloc>().add(GibsonsFormDuplicated(
                  employeeNumber: employeeNumber, gibsonsForm: gibsonsForm));
              ScaffoldMessenger.of(context)
                  .showSnackBar(collectionDuplicatedSnackBar);
              context.read<HomeBloc>().add(const GibsonsFormsLoaded());
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () {
              context
                  .read<HomeBloc>()
                  .add(GibsonsFormDeleted(id: gibsonsForm.id));
              ScaffoldMessenger.of(context)
                  .showSnackBar(collectionDeletedSnackBar);
              Navigator.pop(context);
            },
          )
        ];
        return Wrap(children: options);
      },
    );
  }
}
