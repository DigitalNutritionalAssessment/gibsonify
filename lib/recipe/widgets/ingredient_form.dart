import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gibsonify/fct/fct.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify/collection/collection.dart';
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
    "Roasted and boiled",
    "Other (please specify)"
  ];

  @override
  Widget build(BuildContext context, [bool mounted = true]) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            AbsorbPointer(
              absorbing: state.recipes[recipeIndex].saved,
              child: Column(
                children: [
                  TextFormField(
                    key: UniqueKey(),
                    initialValue: state.recipes[recipeIndex]
                                .ingredients[ingredientIndex].fctFoodItemName !=
                            null
                        ? '${state.recipes[recipeIndex].ingredients[ingredientIndex].fctFoodItemName} (${state.recipes[recipeIndex].ingredients[ingredientIndex].fctFoodItemId})'
                        : null,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.set_meal_rounded),
                      labelText: 'Ingredient name',
                      helperText: 'Tap to select a food item from the FCT',
                    ),
                    readOnly: true,
                    onTap: () async {
                      if (state.recipes[recipeIndex].fctId != null) {
                        final FCTFoodItem? item = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectItemScreen(
                                fctId: state.recipes[recipeIndex].fctId!),
                          ),
                        );

                        if (mounted && item != null) {
                          context.read<RecipeBloc>().add(
                              IngredientFCTFoodItemChanged(
                                  ingredientFCTFoodItem: item,
                                  ingredient: state.recipes[recipeIndex]
                                      .ingredients[ingredientIndex],
                                  recipe: state.recipes[recipeIndex]));
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar
                          ..showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Please select a survey for this recipe first'),
                            ),
                          );
                      }
                    },
                  ),
                  TextFormField(
                    initialValue: state.recipes[recipeIndex]
                        .ingredients[ingredientIndex].description,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.description_rounded),
                      labelText: 'Ingredient description',
                      helperText:
                          'e.g. big, dry, ripe etc, and comments on FCT item suitability',
                      errorText: (isFieldModifiedAndEmpty(state
                              .recipes[recipeIndex]
                              .ingredients[ingredientIndex]
                              .description))
                          ? 'Enter an ingredient description e.g. Ripe'
                          : null,
                    ),
                    onChanged: (value) {
                      context.read<RecipeBloc>().add(
                          IngredientDescriptionChanged(
                              ingredient: state.recipes[recipeIndex]
                                  .ingredients[ingredientIndex],
                              ingredientDescription: value,
                              recipe: state.recipes[recipeIndex]));
                    },
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                  ),
                  DropdownSearch<String>(
                      popupProps: const PopupProps.menu(
                        showSelectedItems: true,
                        constraints: BoxConstraints(maxHeight: 645.0),
                      ),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          icon: Icon(Icons.food_bank_rounded),
                          labelText: "Cooking state",
                          helperText: 'How the ingredient is prepared',
                        ),
                      ),
                      items: cookingStates,
                      onChanged: (String? answer) => context
                          .read<RecipeBloc>()
                          .add(IngredientCookingStateChanged(
                              ingredient: state.recipes[recipeIndex]
                                  .ingredients[ingredientIndex],
                              cookingState: answer!,
                              recipe: state.recipes[recipeIndex])),
                      selectedItem: state.recipes[recipeIndex]
                          .ingredients[ingredientIndex].cookingState),
                  Visibility(
                    visible: (state.recipes[recipeIndex]
                            .ingredients[ingredientIndex].cookingState ==
                        "Other (please specify)"),
                    child: TextFormField(
                      initialValue: state.recipes[recipeIndex]
                          .ingredients[ingredientIndex].customCookingState,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.food_bank_rounded),
                        labelText: 'Specify cooking state',
                        helperText: 'Cooking state e.g. Barbequed',
                        errorText: (state
                                    .recipes[recipeIndex]
                                    .ingredients[ingredientIndex]
                                    .customCookingState ==
                                null)
                            ? 'Enter a cooking state e.g. Barbequed'
                            : null,
                      ),
                      onChanged: (value) {
                        context.read<RecipeBloc>().add(
                            IngredientCustomCookingStateChanged(
                                ingredient: state.recipes[recipeIndex]
                                    .ingredients[ingredientIndex],
                                customCookingState: value,
                                recipe: state.recipes[recipeIndex]));
                      },
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                ],
              ),
            ),
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
      return ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(2.0),
          itemCount: state.recipes[recipeIndex].ingredients[ingredientIndex]
              .measurements.length,
          itemBuilder: (context, index) {
            return Slidable(
              key: Key(state.recipes[recipeIndex].ingredients[ingredientIndex]
                  .measurements[index].id),
              enabled: !state.recipes[recipeIndex].saved,
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      if (state
                              .recipes[recipeIndex]
                              .ingredients[ingredientIndex]
                              .measurements
                              .length >
                          1) {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                DeleteIngredientMeasurementDialog(
                                    recipe: state.recipes[recipeIndex],
                                    ingredient: state.recipes[recipeIndex]
                                        .ingredients[ingredientIndex],
                                    measurementIndex: index));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'An ingredient must have at least one measurement')));
                      }
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  )
                ],
              ),
              child: AbsorbPointer(
                absorbing: state.recipes[recipeIndex].saved,
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      MeasurementCard(
                          measurement: state.recipes[recipeIndex]
                              .ingredients[ingredientIndex].measurements[index],
                          onMeasurementMethodChangedOthersNulled: (measurementMethod) => context
                              .read<RecipeBloc>()
                              .add(IngredientMeasurementMethodChangedOthersNulled(
                                  measurementIndex: index,
                                  ingredient: state.recipes[recipeIndex]
                                      .ingredients[ingredientIndex],
                                  measurementMethod: measurementMethod,
                                  recipe: state.recipes[recipeIndex])),
                          onMeasurementUnitChanged: (measurementUnit) => context
                              .read<RecipeBloc>()
                              .add(IngredientMeasurementUnitChanged(
                                  measurementIndex: index,
                                  ingredient: state.recipes[recipeIndex]
                                      .ingredients[ingredientIndex],
                                  measurementUnit: measurementUnit,
                                  recipe: state.recipes[recipeIndex])),
                          onMeasurementValueChanged: (measurementValue) =>
                              context.read<RecipeBloc>().add(IngredientMeasurementValueChanged(measurementIndex: index, ingredient: state.recipes[recipeIndex].ingredients[ingredientIndex], measurementValue: measurementValue, recipe: state.recipes[recipeIndex]))),
                      // TODO: Move the Add Measurement Visibility ListTile
                      // out of the ListView.builder() so that it is not
                      // repeated after each measurement (fix bottom overflow)
                      Visibility(
                        visible: !state.recipes[recipeIndex].saved,
                        child: ListTile(
                          title: const Text('Add measurement'),
                          leading: const Icon(Icons.add),
                          onTap: () => context.read<RecipeBloc>().add(
                              IngredientMeasurementAdded(
                                  ingredient: state.recipes[recipeIndex]
                                      .ingredients[ingredientIndex],
                                  recipe: state.recipes[recipeIndex])),
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            );
          });
    });
  }
}

class DeleteIngredientMeasurementDialog extends StatelessWidget {
  final Recipe recipe;
  final Ingredient ingredient;
  final int measurementIndex;

  const DeleteIngredientMeasurementDialog(
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
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => {
              context.read<RecipeBloc>().add(IngredientMeasurementDeleted(
                  recipe: recipe,
                  ingredient: ingredient,
                  measurementIndex: measurementIndex)),
              Navigator.pop(context),
            },
            child: const Text('Delete'),
          ),
        ],
      );
    });
  }
}
