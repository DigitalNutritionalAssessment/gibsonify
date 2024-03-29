import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify_api/gibsonify_api.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final int recipeIndex;
  final bool viewedFromCollection;
  final String? assignedFoodItemId;
  const RecipeDetailsScreen(this.recipeIndex,
      {Key? key, required this.viewedFromCollection, this.assignedFoodItemId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: const Text('Recipe details')),
        body: RecipeDetails(recipeIndex),
        floatingActionButton: Visibility(
          visible: !state.recipes[recipeIndex].saved || viewedFromCollection,
          child: FloatingActionButton.extended(
              heroTag: null,
              label: !viewedFromCollection
                  ? const Text("Save Recipe")
                  : const Text("Choose Recipe"),
              icon: !viewedFromCollection
                  ? const Icon(Icons.save_sharp)
                  : const Icon(Icons.check),
              onPressed: () {
                if (state.recipes[recipeIndex].areMeasurementsFilled() ||
                    state.recipes[recipeIndex].type == 'Standard Recipe') {
                  if (!viewedFromCollection) {
                    context.read<RecipeBloc>().add(RecipeStatusChanged(
                        recipe: state.recipes[recipeIndex], recipeSaved: true));
                    context.read<RecipeBloc>().add(const RecipesSaved());
                    Navigator.pop(context);
                  } else {
                    context.read<RecipeBloc>().add(const RecipesSaved());
                    Navigator.pop(context);
                    Navigator.pop(
                        context,
                        FoodItemRecipeChanged(
                            foodItemId: assignedFoodItemId!,
                            foodItemRecipe: state.recipes[recipeIndex]));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Each measurement must be filled')));
                }
              }),
        ),
      );
    });
  }
}

class RecipeDetails extends StatelessWidget {
  final int recipeIndex;

  const RecipeDetails(this.recipeIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Visibility(
                visible: state.recipes[recipeIndex].saved,
                child: const SavedRecipeListTile()),
            AbsorbPointer(
                absorbing: state.recipes[recipeIndex].saved,
                child: RecipeNameInput(recipeIndex)),
            RecipeNumberInput(recipeIndex),
            const SizedBox(height: 10),
            ListTile(
                onTap: () => {
                      context.read<RecipeBloc>().add(
                          RecipeShowMeasurementsChanged(
                              showMeasurements: !state.showMeasurements)),
                    },
                title: (state.showMeasurements)
                    ? const Text('Hide measurements')
                    : const Text('Show measurements')),
            Visibility(
                visible: state.showMeasurements,
                child: RecipeMeasurements(recipeIndex)),
          ],
        ),
      );
    });
  }
}

class SavedRecipeListTile extends StatelessWidget {
  const SavedRecipeListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text('This recipe is saved'),
      subtitle: Text(
          'Saved recipes can no longer be edited. Duplicate this recipe to edit it.'),
      tileColor: Colors.teal,
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
          key: Key(state.recipes[recipeIndex].number),
          initialValue: state.recipes[recipeIndex].number,
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
                enabled: !state.recipes[recipeIndex].saved,
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        if (state.recipes[recipeIndex].measurements.length >
                            1) {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  DeleteRecipeMeasurementDialog(
                                      recipe: state.recipes[recipeIndex],
                                      measurementIndex: index));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'A recipe must have at least one measurement')));
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
                            measurement:
                                state.recipes[recipeIndex].measurements[index],
                            onMeasurementMethodChangedOthersNulled:
                                (measurementMethod) => context
                                    .read<RecipeBloc>()
                                    .add(RecipeMeasurementMethodChangedOthersNulled(
                                        measurementIndex: index,
                                        measurementMethod: measurementMethod,
                                        recipe: state.recipes[recipeIndex])),
                            onMeasurementUnitChanged: (measurementUnit) =>
                                context.read<RecipeBloc>().add(
                                    RecipeMeasurementUnitChanged(
                                        measurementIndex: index,
                                        measurementUnit: measurementUnit,
                                        recipe: state.recipes[recipeIndex])),
                            onMeasurementValueChanged: (measurementValue) =>
                                context.read<RecipeBloc>().add(
                                    RecipeMeasurementValueChanged(
                                        measurementIndex: index,
                                        measurementValue: measurementValue,
                                        recipe: state.recipes[recipeIndex]))),
                        // TODO: Move the Add Measurement Visibility ListTile
                        // out of the ListView.builder() so that it is not
                        // repeated after each measurement (fix bottom overflow)
                        Visibility(
                          visible: !state.recipes[recipeIndex].saved,
                          child: ListTile(
                            title: const Text('Add measurement'),
                            leading: const Icon(Icons.add),
                            onTap: () => context.read<RecipeBloc>().add(
                                RecipeMeasurementAdded(
                                    recipe: state.recipes[recipeIndex])),
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              );
            }),
      );
    });
  }
}

class DeleteRecipeMeasurementDialog extends StatelessWidget {
  final Recipe recipe;
  final int measurementIndex;

  const DeleteRecipeMeasurementDialog(
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
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => {
              context.read<RecipeBloc>().add(RecipeMeasurementDeleted(
                  recipe: recipe, measurementIndex: measurementIndex)),
              Navigator.pop(context),
            },
            child: const Text('Delete'),
          ),
        ],
      );
    });
  }
}
