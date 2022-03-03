import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify/navigation/navigation.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class RecipeIngredientsScreen extends StatelessWidget {
  final int recipeIndex;
  final String? assignedFoodItemId;
  const RecipeIngredientsScreen(this.recipeIndex,
      {Key? key, this.assignedFoodItemId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Recipe ingredients'),
            leading: BackButton(
                onPressed: () => {
                      context.read<RecipeBloc>().add(const RecipesSaved()),
                      Navigator.pop(context)
                    }),
          ),
          body: RecipeForm(recipeIndex),
          floatingActionButton: FloatingActionButton.extended(
              heroTag: null,
              label: const Text("New Ingredient"),
              icon: const Icon(Icons.add),
              onPressed: () => {
                    context.read<RecipeBloc>().add(
                        IngredientAdded(recipe: state.recipes[recipeIndex])),
                    Navigator.pushNamed(context, PageRouter.ingredient,
                        arguments: {
                          'recipeIndex': recipeIndex,
                          'ingredientIndex':
                              state.recipes[recipeIndex].ingredients.length,
                        }),
                  }));
    });
  }
}

class RecipeForm extends StatelessWidget {
  final int recipeIndex;
  const RecipeForm(this.recipeIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            RecipeNameInput(recipeIndex),
            const SizedBox(height: 10),
            ListTile(
                title: (state.recipes[recipeIndex].ingredients.isNotEmpty)
                    ? const Text('Ingredients:')
                    : null),
            Ingredients(recipeIndex),
          ],
        ),
      );
    });
  }
}

class RecipeNameInput extends StatelessWidget {
  final int recipeIndex;
  const RecipeNameInput(this.recipeIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.recipes[recipeIndex].recipeName,
          decoration: InputDecoration(
            icon: const Icon(Icons.assignment_rounded),
            labelText: 'Recipe Name',
            helperText: 'A valid recipe name, e.g. Aloo bandhgobhi',
            // TODO: Refactor the error condition into a reusable method
            errorText: (state.recipes[recipeIndex].recipeName != null &&
                    state.recipes[recipeIndex].recipeName == '')
                ? 'Enter a valid recipe name, e.g. Aloo bandhgobhi'
                : null,
          ),
          onChanged: (value) {
            context.read<RecipeBloc>().add(RecipeNameChanged(
                recipeName: value, recipe: state.recipes[recipeIndex]));
          },
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class Ingredients extends StatelessWidget {
  final int recipeIndex;
  const Ingredients(this.recipeIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(2.0),
              itemCount: state.recipes[recipeIndex].ingredients.length,
              itemBuilder: (context, index) {
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  DeleteIngredientDialog(
                                      recipe: state.recipes[recipeIndex],
                                      ingredient: state.recipes[recipeIndex]
                                          .ingredients[index]));
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      )
                    ],
                  ),
                  child: Card(
                      child: ListTile(
                    title: (state
                                .recipes[recipeIndex].ingredients[index].name ==
                            "Other (please specify)")
                        // TODO: Implement a better implementation for this check
                        // possibly a flag to show customName is chosen
                        ? Text(state.recipes[recipeIndex].ingredients[index]
                                .customName ??
                            '')
                        : Text(state
                                .recipes[recipeIndex].ingredients[index].name ??
                            ''),
                    subtitle: Text(state.recipes[recipeIndex].ingredients[index]
                            .description ??
                        ''),
                    leading: const Icon(Icons.food_bank),
                    trailing:
                        state.recipes[recipeIndex].ingredients[index].saved
                            ? const Icon(Icons.done)
                            : const Icon(Icons.rotate_left_rounded),
                    onTap: () => {
                      Navigator.pushNamed(context, PageRouter.ingredient,
                          arguments: {
                            'recipeIndex': recipeIndex,
                            'ingredientIndex': index,
                          })
                    },
                  )),
                );
              }));
    });
  }
}

class DeleteIngredientDialog extends StatelessWidget {
  final Recipe recipe;
  final Ingredient ingredient;

  const DeleteIngredientDialog(
      {Key? key, required this.recipe, required this.ingredient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? ingredientName = ingredient.name;
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return AlertDialog(
        title: const Text('Delete ingredient'),
        content:
            Text('Would you like to delete the $ingredientName ingredient?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => {
              context.read<RecipeBloc>().add(
                  IngredientDeleted(recipe: recipe, ingredient: ingredient)),
              Navigator.pop(context, 'Delete')
            },
            child: const Text('Delete'),
          ),
        ],
      );
    });
  }
}
