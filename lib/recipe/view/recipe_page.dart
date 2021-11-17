import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/recipe/recipe.dart';

class RecipePage extends StatelessWidget {
  final int recipeIndex;

  const RecipePage(this.recipeIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: investigate nesting of BlocBuilders
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Scaffold(
        body: RecipeScreen(recipeIndex),
      );
    });
  }
}
