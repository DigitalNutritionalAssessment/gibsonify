import 'package:flutter/material.dart';

class RecipesHelpPage extends StatelessWidget {
  const RecipesHelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Recipes Help')),
        body: Column(children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            // TODO: refactor into something nicer
            child: Text('Recipes page shows all recipes currently present on '
                'the device, along with their type (standard, modified, '
                'non-standard), their ingredients, and an indicator of whether '
                'the recipe is saved (tick) or not (exclamation mark).'
                '\n\n'
                'Long-pressing a recipe allows it to be deleted, duplicated or '
                'to create a modified recipe if the given recipe is standard.'),
          ),
        ]));
  }
}
