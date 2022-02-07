import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify/recipe/recipe.dart';

class IngredientForm extends StatelessWidget {
  final int recipeIndex;
  final int ingredientIndex;
  IngredientForm(this.recipeIndex, this.ingredientIndex, {Key? key})
      : super(key: key);

  final List<String> cookingStates = [
    "Raw",
    "Boiled",
    "Boiled in water but retained water",
    "Boiled in water but removed water",
    "Steamed",
    "Roasted with oil",
    "Roasted without oil",
    "Fried",
    "Stir - fried",
    "Soaking and stir fried",
    "Boiled and fried",
    "Boiled and stir-fried",
    "Steamed and fried",
    "Roasted and boiled"
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: state
                  .recipes[recipeIndex].ingredients[ingredientIndex].name.value,
              decoration: InputDecoration(
                icon: const Icon(Icons.set_meal_rounded),
                labelText: 'Ingredient name',
                helperText: 'Ingredient name e.g. Rice',
                errorText: state.recipes[recipeIndex]
                        .ingredients[ingredientIndex].name.invalid
                    ? 'Enter an ingredient name e.g. Tomato'
                    : null,
              ),
              onChanged: (value) {
                context.read<RecipeBloc>().add(IngredientNameChanged(
                    ingredient:
                        state.recipes[recipeIndex].ingredients[ingredientIndex],
                    ingredientName: value,
                    recipe: state.recipes[recipeIndex]));
              },
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              initialValue: state.recipes[recipeIndex]
                  .ingredients[ingredientIndex].description.value,
              decoration: InputDecoration(
                icon: const Icon(Icons.description_rounded),
                labelText: 'Ingredient description',
                helperText: 'Ingredient description e.g. Big, dry, ripe etc.',
                errorText: state.recipes[recipeIndex]
                        .ingredients[ingredientIndex].description.invalid
                    ? 'Enter an ingredient description e.g. Ripe'
                    : null,
              ),
              onChanged: (value) {
                context.read<RecipeBloc>().add(IngredientDescriptionChanged(
                    ingredient:
                        state.recipes[recipeIndex].ingredients[ingredientIndex],
                    ingredientDescription: value,
                    recipe: state.recipes[recipeIndex]));
              },
              textInputAction: TextInputAction.next,
            ),
            DropdownSearch<String>(
                dropdownSearchDecoration: InputDecoration(
                  icon: const Icon(Icons.food_bank_rounded),
                  labelText: "Cooking state",
                  helperText: 'How the ingredient is prepared',
                  errorText: state.recipes[recipeIndex]
                          .ingredients[ingredientIndex].cookingState.invalid
                      ? 'Enter a cooking state'
                      : null,
                ),
                mode: Mode.MENU,
                showSelectedItems: true,
                showSearchBox: true,
                items: cookingStates,
                onChanged: (String? answer) => context.read<RecipeBloc>().add(
                    IngredientCookingStateChanged(
                        ingredient: state
                            .recipes[recipeIndex].ingredients[ingredientIndex],
                        cookingState: answer!,
                        recipe: state.recipes[recipeIndex])),
                selectedItem: state.recipes[recipeIndex]
                    .ingredients[ingredientIndex].cookingState.value),
            const SizedBox(height: 10),
            IngredientMeasurements(recipeIndex, ingredientIndex)
          ],
        ),
      );
    });
  }
}

class IngredientMeasurements extends StatelessWidget {
  final int recipeIndex;
  final int ingredientIndex;
  const IngredientMeasurements(this.recipeIndex, this.ingredientIndex,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Expanded(
        child: ListView.builder(
            padding: const EdgeInsets.all(2.0),
            itemCount: state.recipes[recipeIndex].ingredients[ingredientIndex]
                .measurements.length,
            itemBuilder: (context, index) {
              return Slidable(
                key: Key(state.recipes[recipeIndex].ingredients[ingredientIndex]
                    .measurements[index].id),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                DeleteIngredientMeasurement(
                                    recipe: state.recipes[recipeIndex],
                                    ingredient: state.recipes[recipeIndex]
                                        .ingredients[ingredientIndex],
                                    measurementIndex: index));
                      },
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    )
                  ],
                ),
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      DropdownSearch<String>(
                          dropdownSearchDecoration: InputDecoration(
                            icon: const Icon(Icons.food_bank_rounded),
                            labelText: "Measurement method",
                            helperText: 'How the measurement is measured',
                            errorText: (state
                                            .recipes[recipeIndex]
                                            .ingredients[ingredientIndex]
                                            .measurements[index]
                                            .measurementMethod !=
                                        null &&
                                    state
                                            .recipes[recipeIndex]
                                            .ingredients[ingredientIndex]
                                            .measurements[index]
                                            .measurementMethod ==
                                        '')
                                ? 'Enter a measurement method'
                                : null,
                          ),
                          mode: Mode.MENU,
                          showSelectedItems: true,
                          showSearchBox: true,
                          items: Measurement.measurementMethods,
                          onChanged: (String? answer) => context
                              .read<RecipeBloc>()
                              .add(IngredientMeasurementMethodChanged(
                                  measurementIndex: index,
                                  ingredient: state.recipes[recipeIndex]
                                      .ingredients[ingredientIndex],
                                  measurementMethod: answer!,
                                  recipe: state.recipes[recipeIndex])),
                          selectedItem: state
                              .recipes[recipeIndex]
                              .ingredients[ingredientIndex]
                              .measurements[index]
                              .measurementMethod),
                      TextFormField(
                        initialValue: state
                            .recipes[recipeIndex]
                            .ingredients[ingredientIndex]
                            .measurements[index]
                            .measurementVolume,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.format_list_numbered_rounded),
                          labelText: 'Measurement volume',
                          helperText: 'Input measurement volume',
                          errorText: (state
                                          .recipes[recipeIndex]
                                          .ingredients[ingredientIndex]
                                          .measurements[index]
                                          .measurementVolume !=
                                      null &&
                                  state
                                          .recipes[recipeIndex]
                                          .ingredients[ingredientIndex]
                                          .measurements[index]
                                          .measurementVolume ==
                                      '')
                              ? 'Enter a measurement volume'
                              : null,
                        ),
                        onChanged: (value) {
                          context.read<RecipeBloc>().add(
                              IngredientMeasurementVolumeChanged(
                                  measurementIndex: index,
                                  ingredient: state.recipes[recipeIndex]
                                      .ingredients[ingredientIndex],
                                  measurementVolume: value,
                                  recipe: state.recipes[recipeIndex]));
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                      ),
                      DropdownSearch<String>(
                          dropdownSearchDecoration: InputDecoration(
                            icon: const Icon(Icons.local_dining_rounded),
                            labelText: "Measurement unit",
                            helperText: 'The size of each measurement value',
                            errorText: (state
                                            .recipes[recipeIndex]
                                            .ingredients[ingredientIndex]
                                            .measurements[index]
                                            .measurementUnit !=
                                        null &&
                                    state
                                            .recipes[recipeIndex]
                                            .ingredients[ingredientIndex]
                                            .measurements[index]
                                            .measurementUnit ==
                                        '')
                                ? 'Select the measurement unit'
                                : null,
                          ),
                          mode: Mode.MENU,
                          showSelectedItems: true,
                          showSearchBox: true,
                          items: Measurement.measurementUnits,
                          onChanged: (String? answer) => context
                              .read<RecipeBloc>()
                              .add(IngredientMeasurementUnitChanged(
                                  measurementIndex: index,
                                  ingredient: state.recipes[recipeIndex]
                                      .ingredients[ingredientIndex],
                                  measurementUnit: answer!,
                                  recipe: state.recipes[recipeIndex])),
                          selectedItem: state
                              .recipes[recipeIndex]
                              .ingredients[ingredientIndex]
                              .measurements[index]
                              .measurementUnit),
                      const Divider(),
                      ListTile(
                        title: const Text('Add measurement'),
                        leading: const Icon(Icons.add),
                        onTap: () => context.read<RecipeBloc>().add(
                            IngredientMeasurementAdded(
                                ingredient: state.recipes[recipeIndex]
                                    .ingredients[ingredientIndex],
                                recipe: state.recipes[recipeIndex])),
                      ),
                    ],
                  ),
                )),
              );
            }),
      );
    });
  }
}

class DeleteIngredientMeasurement extends StatelessWidget {
  final Recipe recipe;
  final Ingredient ingredient;
  final int measurementIndex;

  const DeleteIngredientMeasurement(
      {Key? key,
      required this.recipe,
      required this.ingredient,
      required this.measurementIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return AlertDialog(
        title: const Text('Delete measurement'),
        content: const Text('Would you like to delete the measurement?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => {
              context.read<RecipeBloc>().add(IngredientMeasurementDeleted(
                  recipe: recipe,
                  ingredient: ingredient,
                  measurementIndex: measurementIndex)),
              Navigator.pop(context, 'OK')
            },
            child: const Text('OK'),
          ),
        ],
      );
    });
  }
}
