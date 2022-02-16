import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:convert';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify/recipe/recipe.dart';

class IngredientForm extends StatefulWidget {
  final int recipeIndex;
  final int ingredientIndex;
  const IngredientForm(this.recipeIndex, this.ingredientIndex, {Key? key})
      : super(key: key);

  @override
  State<IngredientForm> createState() => _IngredientFormState();
}

class _IngredientFormState extends State<IngredientForm> {
  Future<String>? _ingredients;

  @override
  void initState() {
    super.initState();
    _ingredients = Ingredient.getIngredients();
    // TODO: Evaluate if loading asset into RecipeBloc is a better approach to
    // make IngredientForm a StatelessWidget
  }

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
            FutureBuilder(
                future: _ingredients,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return DropdownSearch<String>(
                        dropdownSearchDecoration: const InputDecoration(
                          icon: Icon(Icons.food_bank_rounded),
                          labelText: 'Ingredient name',
                          helperText: 'Ingredient name e.g. Potato',
                        ),
                        mode: Mode.MENU,
                        showSelectedItems: true,
                        showSearchBox: true,
                        items: json.decode(snapshot.data!).keys.toList(),
                        onChanged: (String? answer) => context
                            .read<RecipeBloc>()
                            .add(IngredientNameChanged(
                                ingredient: state.recipes[widget.recipeIndex]
                                    .ingredients[widget.ingredientIndex],
                                ingredientName: answer!,
                                recipe: state.recipes[widget.recipeIndex])),
                        selectedItem: state.recipes[widget.recipeIndex]
                            .ingredients[widget.ingredientIndex].name);
                  } else {
                    return DropdownSearch<String>(
                        dropdownSearchDecoration: const InputDecoration(
                          icon: Icon(Icons.food_bank_rounded),
                          labelText: 'Ingredient name',
                          helperText: 'Ingredient name e.g. Potato',
                        ),
                        enabled: false,
                        mode: Mode.MENU,
                        showSelectedItems: true,
                        selectedItem: state.recipes[widget.recipeIndex]
                            .ingredients[widget.ingredientIndex].name);
                  }
                }),
            Visibility(
              visible: (state.recipes[widget.recipeIndex]
                      .ingredients[widget.ingredientIndex].name ==
                  "Other (please specify)"),
              child: TextFormField(
                initialValue: state.recipes[widget.recipeIndex]
                    .ingredients[widget.ingredientIndex].customName,
                decoration: InputDecoration(
                  icon: const Icon(Icons.set_meal_rounded),
                  labelText: 'Specify ingredient',
                  helperText: 'Ingredient name e.g. Black rice',
                  errorText: (state.recipes[widget.recipeIndex]
                              .ingredients[widget.ingredientIndex].customName ==
                          null)
                      ? 'Enter an ingredient name e.g. Black rice'
                      : null,
                ),
                onChanged: (value) {
                  context.read<RecipeBloc>().add(IngredientCustomNameChanged(
                      ingredient: state.recipes[widget.recipeIndex]
                          .ingredients[widget.ingredientIndex],
                      ingredientCustomName: value,
                      recipe: state.recipes[widget.recipeIndex]));
                },
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            TextFormField(
              initialValue: state.recipes[widget.recipeIndex]
                  .ingredients[widget.ingredientIndex].description,
              decoration: InputDecoration(
                icon: const Icon(Icons.description_rounded),
                labelText: 'Ingredient description',
                helperText: 'Ingredient description e.g. Big, dry, ripe etc.',
                errorText: (state
                                .recipes[widget.recipeIndex]
                                .ingredients[widget.ingredientIndex]
                                .description !=
                            null &&
                        state
                                .recipes[widget.recipeIndex]
                                .ingredients[widget.ingredientIndex]
                                .description ==
                            '')
                    ? 'Enter an ingredient description e.g. Ripe'
                    : null,
              ),
              onChanged: (value) {
                context.read<RecipeBloc>().add(IngredientDescriptionChanged(
                    ingredient: state.recipes[widget.recipeIndex]
                        .ingredients[widget.ingredientIndex],
                    ingredientDescription: value,
                    recipe: state.recipes[widget.recipeIndex]));
              },
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
            ),
            DropdownSearch<String>(
                dropdownSearchDecoration: const InputDecoration(
                  icon: Icon(Icons.food_bank_rounded),
                  labelText: "Cooking state",
                  helperText: 'How the ingredient is prepared',
                ),
                mode: Mode.MENU,
                showSelectedItems: true,
                showSearchBox: true,
                items: cookingStates,
                onChanged: (String? answer) => context.read<RecipeBloc>().add(
                    IngredientCookingStateChanged(
                        ingredient: state.recipes[widget.recipeIndex]
                            .ingredients[widget.ingredientIndex],
                        cookingState: answer!,
                        recipe: state.recipes[widget.recipeIndex])),
                selectedItem: state.recipes[widget.recipeIndex]
                    .ingredients[widget.ingredientIndex].cookingState),
            const SizedBox(height: 10),
            IngredientMeasurements(widget.recipeIndex, widget.ingredientIndex)
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
                        if (state
                                .recipes[recipeIndex]
                                .ingredients[ingredientIndex]
                                .measurements
                                .length >
                            1) {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  DeleteIngredientMeasurement(
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
                            .measurementValue,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.format_list_numbered_rounded),
                          labelText: 'Measurement value',
                          helperText: 'Input measurement value',
                          errorText: (state
                                          .recipes[recipeIndex]
                                          .ingredients[ingredientIndex]
                                          .measurements[index]
                                          .measurementValue !=
                                      null &&
                                  state
                                          .recipes[recipeIndex]
                                          .ingredients[ingredientIndex]
                                          .measurements[index]
                                          .measurementValue ==
                                      '')
                              ? 'Enter a measurement value'
                              : null,
                        ),
                        onChanged: (value) {
                          context.read<RecipeBloc>().add(
                              IngredientMeasurementValueChanged(
                                  measurementIndex: index,
                                  ingredient: state.recipes[recipeIndex]
                                      .ingredients[ingredientIndex],
                                  measurementValue: value,
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
              Navigator.pop(context, 'OK'),
            },
            child: const Text('OK'),
          ),
        ],
      );
    });
  }
}
