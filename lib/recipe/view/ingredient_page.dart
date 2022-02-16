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
          appBar: AppBar(title: const Text('Edit Ingredient')),
          floatingActionButton: FloatingActionButton.extended(
              label: const Text("Save"),
              icon: const Icon(Icons.save_sharp),
              onPressed: () => {
                    context.read<RecipeBloc>().add(IngredientStatusChanged(
                        recipe: state.recipes[recipeIndex],
                        ingredient: state
                            .recipes[recipeIndex].ingredients[ingredientIndex],
                        ingredientSaved: true)),
                    Navigator.pop(context)
                  }),
          body: IngredientForm(recipeIndex, ingredientIndex));
    });
  }
}
