import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify/home/home.dart';

class SyncScreen extends StatelessWidget {
  const SyncScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
          listener: (context, state) async {
            // TODO: add conditions for failure and other statuses
            if (state.gibsonsFormsExportStatus ==
                GibsonsFormsExportStatus.externalSaveSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Successfully saved '
                        '${state.exportedGibsonsFormsNumber} collection(s) '
                        'to downloads folder')),
              );
            }

            if (state.gibsonsFormsExportStatus ==
                GibsonsFormsExportStatus.noCsvForms) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                      content:
                          Text('There are no finished collections to save!')),
                );
            }

            if (state.gibsonsFormsExportStatus ==
                GibsonsFormsExportStatus.internalSaveSuccess) {
              // TODO: move share into BLoC
              await Share.shareFiles([state.lastInternalExportPath!])
                  .then((value) => ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                          // TODO: fix snackbar to show after share dialog
                          duration: const Duration(seconds: 10),
                          content: Text(
                              'Successfully shared ${state.exportedGibsonsFormsNumber} collection(s)')),
                    ));
            }
          },
        ),
        BlocListener<RecipeBloc, RecipeState>(listener: (context, state) {
          // TODO: add conditions for failure and other statuses
          // TODO: Figure out a way to use only one snackbar to display
          // number of exported collections and recipes
          // Probably rather implement a StreamSubscription of HomeBloc on
          // RecipeBloc and use a single Listener here
          if (state.recipesExportStatus ==
              RecipesExportStatus.externalSaveSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Successfully saved '
                    '${state.exportedRecipesNumber} recipe(s) '
                    'to downloads folder')));
          }
        }),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Import & Export Data')),
        floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton.extended(
                  heroTag: null,
                  label: const Text("Save data to device"),
                  icon: const Icon(Icons.save),
                  onPressed: () {
                    context
                        .read<HomeBloc>()
                        .add(const FinishedGibsonsFormsSavedToFile());
                    context.read<RecipeBloc>().add(const RecipesSavedToFile());
                  }),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton.extended(
                heroTag: null,
                label: const Text("Share data as csv files"),
                icon: const Icon(Icons.share),
                onPressed: () {
                  context
                      .read<HomeBloc>()
                      .add(const FinishedGibsonsFormsShared());
                },
              )
            ]),
        body: const RecipeImport(),
      ),
    );
  }
}

class RecipeImport extends StatelessWidget {
  const RecipeImport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecipeBloc, RecipeState>(
      listenWhen: (previous, current) =>
          previous.recipeImportStatus != current.recipeImportStatus,
      listener: (context, state) {
        context.read<RecipeBloc>().add(const RecipesSaved());
        if (state.recipeImportStatus != '') {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.recipeImportStatus!)));
        }
      },
      child: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          return ListTile(
            leading: const Icon(Icons.download_for_offline),
            title: const Text('Import recipe(s) from file'),
            onTap: () {
              context.read<RecipeBloc>().add(const RecipesImported());
            },
          );
        },
      ),
    );
  }
}
