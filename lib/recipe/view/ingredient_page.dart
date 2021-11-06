import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/recipe/recipe.dart';

class IngredientPage extends StatelessWidget {
  final int recipeIndex;
  final int ingredientIndex;
  const IngredientPage(this.recipeIndex, this.ingredientIndex, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(title: const Text('New Ingredient')),
          floatingActionButton: FloatingActionButton.extended(
              label: const Text("Save Ingredient"),
              icon: const Icon(Icons.save_sharp),
              onPressed: () {}), // TODO: Implement save button logic,
          body: IngredientForm(recipeIndex, ingredientIndex));
    });
  }
}
