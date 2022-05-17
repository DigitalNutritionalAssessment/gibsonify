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
          appBar: AppBar(title: const Text('View Ingredient')),
          floatingActionButton: Visibility(
            visible: !state.recipes[recipeIndex].saved,
            child: FloatingActionButton.extended(
                label: const Text("Save"),
                icon: const Icon(Icons.save_sharp),
                onPressed: () => {
                      if (state
                              .recipes[recipeIndex].ingredients[ingredientIndex]
                              .areMeasurementsFilled() ||
                          state.recipes[recipeIndex].type == 'Standard Recipe')
                        {
                          context.read<RecipeBloc>().add(
                              IngredientStatusChanged(
                                  recipe: state.recipes[recipeIndex],
                                  ingredient: state.recipes[recipeIndex]
                                      .ingredients[ingredientIndex],
                                  ingredientSaved: true)),
                          Navigator.pop(context)
                        }
                      else
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Each measurement must be filled')))
                        }
                    }),
          ),
          body: IngredientForm(recipeIndex, ingredientIndex));
    });
  }
}
