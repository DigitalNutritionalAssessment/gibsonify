import 'package:flutter/material.dart';

import 'package:gibsonify/navigation/navigation.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  _RecipesScreenState createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Recipes')),
        body: const Center(child: Text('List of Recipes')),
        floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () =>
                      Navigator.pushNamed(context, ScreenRouter.newRecipe))
            ]));
  }
}
