import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify/home/home.dart';
import 'package:gibsonify/import_export/import_export.dart';

class SyncScreen extends StatelessWidget {
  const SyncScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
          listener: (context, state) async {
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
        // TODO: remove multibloc listener and only listen to ImportExportBloc
        BlocListener<ImportExportBloc, ImportExportState>(
            listener: (context, state) {
          if (state.dataSaveStatus == DataSaveStatus.success) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                    content: Text('Successfully saved '
                        '${state.exportedGibsonsFormsNumber} collection(s) and '
                        '${state.exportedRecipesNumber} recipe(s) '
                        'to downloads folder')),
              );
          }
          if (state.dataSaveStatus == DataSaveStatus.error) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Error: data could not be saved')),
              );
          }

          if (state.dataSaveStatus == DataSaveStatus.noData) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                    content: Text(
                        'There are no collections or recipes to be saved')),
              );
          }

          if (state.dataSaveStatus == DataSaveStatus.noPermissionToSaveFiles) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                    content: Text('No permission to save data: '
                        'please allow data access in settings')),
              );
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
                        .read<ImportExportBloc>()
                        .add(const DataSavedToFiles());
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
