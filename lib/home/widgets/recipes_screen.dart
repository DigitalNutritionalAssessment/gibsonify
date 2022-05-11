import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/navigation/navigation.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify/login/login.dart';
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
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, loginState) {
      return BlocBuilder<RecipeBloc, RecipeState>(
          builder: (context, recipeState) {
        return Scaffold(
            appBar: AppBar(
                title: assignedFoodItemId == null
                    ? const Text('Recipes')
                    : const Text('Choose a Recipe')),
            body: ListView.builder(
                padding: const EdgeInsets.all(2.0),
                itemCount: recipeState.recipes.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  DeleteRecipeDialog(
                                      recipe: recipeState.recipes[index])),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        )
                      ],
                    ),
                    child: Card(
                        child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 10.0),
                      title: isFieldNotNullAndNotEmpty(
                              recipeState.recipes[index].name)
                          ? Text(recipeState.recipes[index].name!)
                          : const Text('Unnamed Recipe'),
                      subtitle: Text(recipeState.recipes[index].type +
                          recipeState.recipes[index].ingredientNamesString()),
                      trailing: recipeState.recipes[index].saved
                          ? const Icon(Icons.done)
                          : const Icon(Icons.rotate_left_rounded),
                      onTap: () => {
                        context.read<RecipeBloc>().add(RecipeProbesCleared(
                            recipe: recipeState.recipes[index])),
                        Navigator.pushNamed(context, PageRouter.recipe,
                            arguments: (recipeState.recipes[index].type !=
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
                      onLongPress: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => DeleteRecipeDialog(
                              recipe: recipeState.recipes[index])),
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
                            context.read<RecipeBloc>().add(RecipeAdded(
                                employeeNumber:
                                    loginState.loginInfo.employeeId!,
                                type: "Standard Recipe")),
                            Navigator.pushNamed(context, PageRouter.recipe,
                                arguments: {
                                  'recipeIndex': recipeState.recipes.length,
                                  'assignedFoodItemId': assignedFoodItemId,
                                  'foodItemDescription': foodItemDescription,
                                  'selectedScreen':
                                      SelectedRecipeScreen.probeScreen
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
                            context.read<RecipeBloc>().add(RecipeAdded(
                                employeeNumber:
                                    loginState.loginInfo.employeeId!,
                                type: "Non-standard Recipe")),
                            Navigator.pushNamed(context, PageRouter.recipe,
                                arguments: {
                                  'recipeIndex': recipeState.recipes.length,
                                  'assignedFoodItemId': assignedFoodItemId,
                                  'foodItemDescription': foodItemDescription,
                                  'selectedScreen':
                                      SelectedRecipeScreen.ingredientScreen
                                }),
                          })
                ]));
      });
    });
  }
}

class DeleteRecipeDialog extends StatelessWidget {
  final Recipe recipe;

  const DeleteRecipeDialog({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return AlertDialog(
        title: const Text('Delete recipe'),
        content: Text('Would you like to delete the ${recipe.name} recipe?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => {
              context.read<RecipeBloc>().add(RecipeDeleted(recipe: recipe)),
              context.read<RecipeBloc>().add(const RecipesSaved()),
              Navigator.pop(context, 'Delete')
            },
            child: const Text('Delete'),
          ),
        ],
      );
    });
  }
}
