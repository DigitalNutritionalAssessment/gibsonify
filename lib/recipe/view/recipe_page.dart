import 'package:flutter/material.dart';

import 'package:gibsonify/recipe/recipe.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final List<Widget> _screens = [
    const RecipeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[0],
    );
  }
}
