import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify/home/home.dart';
import 'dart:convert';

class SyncScreen extends StatelessWidget {
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
            appBar: AppBar(title: const Text('Export Data via Email')),
            body: Center(
                child: ElevatedButton.icon(
              onPressed: () async {
                final directory = await getApplicationDocumentsDirectory();
                final path = directory.path;

                final _recipefilePath = '$path/recipe_data.txt';
                final _recipefile = File(_recipefilePath);
                _recipefile.writeAsString(recipeJson);

                final _collectionfilePath = '$path/collection_data.txt';
                final _collectionfile = File(_collectionfilePath);
                _collectionfile.writeAsString(collectionJson);

                await Share.shareFiles([_recipefilePath, _collectionfilePath]);
              },
              icon: const Icon(Icons.send, size: 18),
              label: const Text("Export saved data as JSON"),
            )));
      });
    });
  }
}
