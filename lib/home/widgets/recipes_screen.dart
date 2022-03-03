import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/navigation/navigation.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class RecipesScreen extends StatelessWidget {
  final String? assignedFoodItemId;
  final String? foodItemDescription;

  const RecipesScreen(
      {Key? key, this.assignedFoodItemId, this.foodItemDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
              title: assignedFoodItemId == null
                  ? const Text('Recipes')
                  : const Text('Choose a Recipe')),
          body: ListView.builder(
              padding: const EdgeInsets.all(2.0),
              itemCount: state.recipes.length,
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
                                  DeleteRecipeDialog(
                                      recipe: state.recipes[index]));
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      )
                    ],
                  ),
                  child: Card(
                      child: ListTile(
                    title: Text(state.recipes[index].recipeName ?? ''),
                    subtitle: Text(state.recipes[index].recipeType),
                    trailing: state.recipes[index].saved
                        ? const Icon(Icons.done)
                        : const Icon(Icons.rotate_left_rounded),
                    onTap: () => {
                      context.read<RecipeBloc>().add(
                          RecipeProbesCleared(recipe: state.recipes[index])),
                      Navigator.pushNamed(context, PageRouter.recipe,
                          arguments: (assignedFoodItemId == null ||
                                  state.recipes[index].probes.isEmpty ||
                                  state.recipes[index].recipeType !=
                                      'Standard Recipe')
                              ? {
                                  'recipeIndex': index,
                                  'assignedFoodItemId': assignedFoodItemId,
                                  'foodItemDescription': foodItemDescription,
                                  'selectedScreen':
                                      SelectedRecipeScreen.ingredientScreen
                                }
                              : {
                                  'recipeIndex': index,
                                  'assignedFoodItemId': assignedFoodItemId,
                                  'foodItemDescription': foodItemDescription,
                                  'selectedScreen':
                                      SelectedRecipeScreen.probeScreen
                                })
                    },
                  )),
                );
              }),
          floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton.extended(
                    heroTag: null,
                    label: const Text("Standard Recipe"),
                    icon: const Icon(Icons.add),
                    onPressed: () => {
                          context.read<RecipeBloc>().add(
                              const RecipeAdded(recipeType: "Standard Recipe")),
                          Navigator.pushNamed(context, PageRouter.recipe,
                              arguments: {
                                'recipeIndex': state.recipes.length,
                                'assignedFoodItemId': assignedFoodItemId,
                                'foodItemDescription': foodItemDescription,
                                'selectedScreen':
                                    SelectedRecipeScreen.ingredientScreen
                              }),
                        }),
                const SizedBox(
                  height: 10,
                ),
                FloatingActionButton.extended(
                    heroTag: null,
                    label: const Text("Non-standard Recipe"),
                    icon: const Icon(Icons.add),
                    onPressed: () => {
                          context.read<RecipeBloc>().add(const RecipeAdded(
                              recipeType: "Non-standard Recipe")),
                          Navigator.pushNamed(context, PageRouter.recipe,
                              arguments: {
                                'recipeIndex': state.recipes.length,
                                'assignedFoodItemId': assignedFoodItemId,
                                'foodItemDescription': foodItemDescription,
                                'selectedScreen':
                                    SelectedRecipeScreen.ingredientScreen
                              }),
                        })
              ]));
    });
  }
}

class DeleteRecipeDialog extends StatelessWidget {
  final Recipe recipe;

  const DeleteRecipeDialog({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? recipeName = recipe.recipeName;
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return AlertDialog(
        title: const Text('Delete recipe'),
        content: Text('Would you like to delete the $recipeName recipe?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => {
              context.read<RecipeBloc>().add(RecipeDeleted(recipe: recipe)),
              context.read<RecipeBloc>().add(const RecipesSaved()),
              Navigator.pop(context, 'OK')
            },
            child: const Text('OK'),
          ),
        ],
      );
    });
  }
}
