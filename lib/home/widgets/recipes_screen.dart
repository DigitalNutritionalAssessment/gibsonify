import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/navigation/navigation.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify/login/login.dart';
import 'package:gibsonify_api/gibsonify_api.dart';

class RecipesScreen extends StatelessWidget {
  final bool viewedFromCollection;
  final String? assignedFoodItemId;
  final String? foodItemDescription;

  const RecipesScreen(
      {Key? key,
      required this.viewedFromCollection,
      this.assignedFoodItemId,
      this.foodItemDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, loginState) {
      return BlocBuilder<RecipeBloc, RecipeState>(
          builder: (context, recipeState) {
        return Scaffold(
            appBar: AppBar(
                title: !viewedFromCollection
                    ? const Text('Recipes')
                    : const Text('Choose a Recipe'),
                actions: !viewedFromCollection
                    ? [
                        IconButton(
                            onPressed: () => Navigator.pushNamed(
                                context, PageRouter.recipesHelp),
                            icon: const Icon(Icons.help))
                      ]
                    // TODO: add help page when viewed from Collection
                    : []),
            body: ListView.builder(
                padding: const EdgeInsets.all(2.0),
                itemCount: recipeState.recipes.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 10.0),
                          title: Text(
                              recipeState.recipes[index].recipeNameDisplay()),
                          subtitle: Text(recipeState.recipes[index].type +
                              recipeState.recipes[index]
                                  .ingredientNamesDisplay()),
                          trailing: recipeState.recipes[index].saved
                              ? const Icon(Icons.done)
                              : const Icon(Icons.new_releases),
                          onTap: () => {
                                context.read<RecipeBloc>().add(
                                    RecipeProbesCleared(
                                        recipe: recipeState.recipes[index])),
                                if (viewedFromCollection &&
                                    recipeState.recipes[index].type ==
                                        'Standard Recipe')
                                  {
                                    context.read<RecipeBloc>().add(
                                        const RecipeShowMeasurementsChanged(
                                            showMeasurements: false)),
                                    context.read<RecipeBloc>().add(
                                        const RecipeShowIngredientsChanged(
                                            showIngredients: false)),
                                  }
                                else
                                  {
                                    context.read<RecipeBloc>().add(
                                        const RecipeShowMeasurementsChanged(
                                            showMeasurements: true)),
                                    context.read<RecipeBloc>().add(
                                        const RecipeShowIngredientsChanged(
                                            showIngredients: true)),
                                  },
                                Navigator.pushNamed(context, PageRouter.recipe,
                                    arguments: (recipeState
                                                .recipes[index].type !=
                                            'Standard Recipe')
                                        ? {
                                            'recipeIndex': index,
                                            'viewedFromCollection':
                                                viewedFromCollection,
                                            'assignedFoodItemId':
                                                assignedFoodItemId,
                                            'foodItemDescription':
                                                foodItemDescription,
                                            'selectedScreen':
                                                SelectedRecipeScreen
                                                    .ingredientScreen
                                          }
                                        : {
                                            'recipeIndex': index,
                                            'viewedFromCollection':
                                                viewedFromCollection,
                                            'assignedFoodItemId':
                                                assignedFoodItemId,
                                            'foodItemDescription':
                                                foodItemDescription,
                                            'selectedScreen':
                                                SelectedRecipeScreen.probeScreen
                                          })
                              },
                          onLongPress: () => showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return RecipeOptions(
                                    recipe: recipeState.recipes[index],
                                    employeeNumber:
                                        loginState.loginInfo.employeeId!);
                              })));
                }),
            floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Visibility(
                    visible: !viewedFromCollection,
                    child: Column(
                      children: [
                        FloatingActionButton.extended(
                            heroTag: null,
                            label: const Text("Standard Recipe"),
                            icon: const Icon(Icons.add),
                            onPressed: () => {
                                  context.read<RecipeBloc>().add(RecipeAdded(
                                      employeeNumber:
                                          loginState.loginInfo.employeeId!,
                                      type: "Standard Recipe")),
                                  Navigator.pushNamed(
                                      context, PageRouter.recipe,
                                      arguments: {
                                        'recipeIndex':
                                            recipeState.recipes.length,
                                        'viewedFromCollection':
                                            viewedFromCollection,
                                        'assignedFoodItemId':
                                            assignedFoodItemId,
                                        'foodItemDescription':
                                            foodItemDescription,
                                        'selectedScreen':
                                            SelectedRecipeScreen.probeScreen
                                      }),
                                }),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
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
                                  'viewedFromCollection': viewedFromCollection,
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

class RecipeOptions extends StatelessWidget {
  final Recipe recipe;
  final String employeeNumber;

  const RecipeOptions(
      {Key? key, required this.recipe, required this.employeeNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      final List<Widget> options = [
        ListTile(title: Text('${recipe.recipeNameDisplay()} options')),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.copy),
          title: const Text('Duplicate'),
          onTap: () => {
            context.read<RecipeBloc>().add(RecipeDuplicated(
                recipe: recipe, employeeNumber: employeeNumber)),
            context.read<RecipeBloc>().add(const RecipesSaved()),
            Navigator.pop(context)
          },
        ),
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text('Delete'),
          onTap: () => {
            context.read<RecipeBloc>().add(RecipeDeleted(recipe: recipe)),
            context.read<RecipeBloc>().add(const RecipesSaved()),
            Navigator.pop(context)
          },
        )
      ];
      if (recipe.type == "Standard Recipe") {
        options.add(ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Create modified recipe'),
          onTap: () => {
            context.read<RecipeBloc>().add(ModifiedRecipeCreated(
                recipe: recipe, employeeNumber: employeeNumber)),
            context.read<RecipeBloc>().add(const RecipesSaved()),
            Navigator.pop(context)
          },
        ));
      }
      return Wrap(children: options);
    });
  }
}
