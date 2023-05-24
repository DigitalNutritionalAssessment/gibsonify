import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/login/login.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify/import_export/import_export.dart';

class SyncScreen extends StatelessWidget {
  const SyncScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImportExportBloc, ImportExportState>(
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
                  content:
                      Text('There are no collections or recipes to be saved')),
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

        if (state.dataShareStatus == DataShareStatus.success) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  duration: const Duration(seconds: 10),
                  content: Text('Successfully shared '
                      '${state.exportedGibsonsFormsNumber} collection(s) and '
                      '${state.exportedRecipesNumber} recipe(s)')),
            );
        }

        if (state.dataShareStatus == DataShareStatus.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  duration: Duration(seconds: 10),
                  content: Text('Error: data could not be shared')),
            );
        }

        if (state.dataShareStatus == DataShareStatus.noData) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  duration: Duration(seconds: 10),
                  content:
                      Text('There are no collections or recipes to be shared')),
            );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Import & Export Data')),
        body:
            Column(children: const [RecipeImport(), DataExport(), DataShare()]),
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
              ..showSnackBar(
                  SnackBar(content: Text(state.recipeImportStatus!)));
          }
        },
        child: ListTile(
          leading: const Icon(Icons.download),
          title: const Text('Import recipe(s) from file'),
          onTap: () {
            context.read<RecipeBloc>().add(const RecipesImported());
          },
        ));
  }
}

class DataExport extends StatelessWidget {
  const DataExport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.upload),
      title: const Text('Export all data to Gibsonify data file'),
      onTap: () => context.read<ImportExportBloc>().add(DataFileExported(
            employeeId: context.read<LoginBloc>().state.loginInfo.employeeId!,
          )),
    );
  }
}

class DataShare extends StatelessWidget {
  const DataShare({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.share),
      title: const Text('Export and share Gibsonify data file'),
      onTap: () => context.read<ImportExportBloc>().add(DataFileShared(
            employeeId: context.read<LoginBloc>().state.loginInfo.employeeId!,
          )),
    );
  }
}
