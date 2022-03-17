import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify/home/home.dart';
import 'dart:convert';

class SyncScreen extends StatelessWidget {
  final _exportSubject = 'Gibsonify collection and recipe data';
  final _exportText = 'Gibsonify collection and recipe data attached as a JSON '
      'string. Data can be pasted into '
      'https://www.convertcsv.com/json-to-csv.htm to obtain a csv file.';
  const SyncScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, homeState) {
      return BlocBuilder<RecipeBloc, RecipeState>(
          builder: (context, recipeState) {
        String recipeJson = recipeState.toJson();
        String collectionJson = json.encode({
          'collections':
              homeState.gibsonsForms.map((x) => x!.toJson()).toList(),
        });
        return Scaffold(
          appBar: AppBar(title: const Text('Export Data')),
          floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton.extended(
                    heroTag: null,
                    label: const Text("Save data to file"),
                    icon: const Icon(Icons.save),
                    onPressed: () async {
                      try {
                        final directory = await getExternalStorageDirectory();

                        if (directory == null) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'No permission to save data to file!')),
                            );
                        } else {
                          final path = directory.path;

                          final _recipefilePath = '$path/recipe_data.txt';
                          final _recipefile = File(_recipefilePath);
                          _recipefile.writeAsString(recipeJson);

                          final _collectionfilePath =
                              '$path/collection_data.txt';
                          final _collectionfile = File(_collectionfilePath);
                          _collectionfile.writeAsString(collectionJson);

                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Data successfully saved to: ' + path)),
                            );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(
                                content: Text('Error, cannot save data!')),
                          );
                      }
                    }),
                const SizedBox(
                  height: 10,
                ),
                FloatingActionButton.extended(
                  heroTag: null,
                  label: const Text("Share data as JSON"),
                  icon: const Icon(Icons.share),
                  onPressed: () async {
                    final directory = await getApplicationDocumentsDirectory();
                    final path = directory.path;

                    final _recipefilePath = '$path/recipe_data.txt';
                    final _recipefile = File(_recipefilePath);
                    _recipefile.writeAsString(recipeJson);

                    final _collectionfilePath = '$path/collection_data.txt';
                    final _collectionfile = File(_collectionfilePath);
                    _collectionfile.writeAsString(collectionJson);

                    await Share.shareFiles(
                        [_recipefilePath, _collectionfilePath],
                        subject: _exportSubject, text: _exportText);
                  },
                )
              ]),
          body: const RecipeImport(),
        );
      });
    });
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
