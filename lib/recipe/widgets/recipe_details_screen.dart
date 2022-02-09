import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify_api/gibsonify_api.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final int recipeIndex;
  final String? assignedFoodItemId;
  const RecipeDetailsScreen(this.recipeIndex,
      {Key? key, this.assignedFoodItemId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Recipe details'),
          leading: BackButton(
              onPressed: () => {
                    context.read<RecipeBloc>().add(const RecipesSaved()),
                    Navigator.pop(context)
                  }),
        ),
        body: RecipeDetails(recipeIndex),
        floatingActionButton: FloatingActionButton.extended(
            heroTag: null,
            label: assignedFoodItemId == null
                ? const Text("Save Recipe")
                : const Text("Choose Recipe"),
            icon: assignedFoodItemId == null
                ? const Icon(Icons.save_sharp)
                : const Icon(Icons.check),
            onPressed: () {
              if (assignedFoodItemId == null) {
                context.read<RecipeBloc>().add(RecipeStatusChanged(
                    recipe: state.recipes[recipeIndex], recipeSaved: true));
                context.read<RecipeBloc>().add(const RecipesSaved());
                Navigator.pop(context);
              } else {
                context.read<CollectionBloc>().add(FoodItemRecipeChanged(
                    foodItemId: assignedFoodItemId!,
                    foodItemRecipe: state.recipes[recipeIndex]));
                context.read<RecipeBloc>().add(const RecipesSaved());
                Navigator.pop(context);
                Navigator.pop(context);
              }
            }),
      );
    });
  }
}

class RecipeDetails extends StatelessWidget {
  final int recipeIndex;
  const RecipeDetails(this.recipeIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          RecipeNameInput(recipeIndex),
          RecipeNumberInput(recipeIndex),
          const SizedBox(height: 10),
          RecipeMeasurements(recipeIndex),
        ],
      ),
    );
  }
}

class RecipeNumberInput extends StatelessWidget {
  final int recipeIndex;
  const RecipeNumberInput(this.recipeIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        return TextFormField(
          key: Key(state.recipes[recipeIndex].recipeNumber),
          initialValue: state.recipes[recipeIndex].recipeNumber,
          decoration: const InputDecoration(
            icon: Icon(Icons.format_list_numbered),
            labelText: 'Recipe Number',
          ),
          enabled: false,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
        );
      },
    );
  }
}

class RecipeMeasurements extends StatelessWidget {
  final int recipeIndex;
  const RecipeMeasurements(this.recipeIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Expanded(
        child: ListView.builder(
            padding: const EdgeInsets.all(2.0),
            itemCount: state.recipes[recipeIndex].measurements.length,
            itemBuilder: (context, index) {
              return Slidable(
                key: Key(state.recipes[recipeIndex].measurements[index].id),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                DeleteRecipeMeasurement(
                                    recipe: state.recipes[recipeIndex],
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
                                            .measurements[index]
                                            .measurementMethod !=
                                        null &&
                                    state
                                            .recipes[recipeIndex]
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
                              .add(RecipeMeasurementMethodChanged(
                                  measurementIndex: index,
                                  measurementMethod: answer!,
                                  recipe: state.recipes[recipeIndex])),
                          selectedItem: state.recipes[recipeIndex]
                              .measurements[index].measurementMethod),
                      TextFormField(
                        initialValue: state.recipes[recipeIndex]
                            .measurements[index].measurementVolume,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.format_list_numbered_rounded),
                          labelText: 'Measurement volume',
                          helperText: 'Input measurement volume',
                          errorText: (state
                                          .recipes[recipeIndex]
                                          .measurements[index]
                                          .measurementVolume !=
                                      null &&
                                  state.recipes[recipeIndex].measurements[index]
                                          .measurementVolume ==
                                      '')
                              ? 'Enter a measurement volume'
                              : null,
                        ),
                        onChanged: (value) {
                          context.read<RecipeBloc>().add(
                              RecipeMeasurementVolumeChanged(
                                  measurementIndex: index,
                                  measurementVolume: value,
                                  recipe: state.recipes[recipeIndex]));
                        },
                        textCapitalization: TextCapitalization.sentences,
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
                                            .measurements[index]
                                            .measurementUnit !=
                                        null &&
                                    state
                                            .recipes[recipeIndex]
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
                              .add(RecipeMeasurementUnitChanged(
                                  measurementIndex: index,
                                  measurementUnit: answer!,
                                  recipe: state.recipes[recipeIndex])),
                          selectedItem: state.recipes[recipeIndex]
                              .measurements[index].measurementUnit),
                      const Divider(),
                      ListTile(
                        title: const Text('Add measurement'),
                        leading: const Icon(Icons.add),
                        onTap: () => context.read<RecipeBloc>().add(
                            RecipeMeasurementAdded(
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

class DeleteRecipeMeasurement extends StatelessWidget {
  final Recipe recipe;
  final int measurementIndex;

  const DeleteRecipeMeasurement(
      {Key? key, required this.recipe, required this.measurementIndex})
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
              context.read<RecipeBloc>().add(RecipeMeasurementDeleted(
                  recipe: recipe, measurementIndex: measurementIndex)),
              Navigator.pop(context, 'OK')
            },
            child: const Text('OK'),
          ),
        ],
      );
    });
  }
}
