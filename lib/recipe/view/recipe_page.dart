import 'package:flutter/material.dart';

import 'package:gibsonify/recipe/recipe.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RecipeScreen(),
    );
  }
}
