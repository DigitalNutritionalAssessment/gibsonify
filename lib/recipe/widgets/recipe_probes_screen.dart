import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gibsonify/navigation/navigation.dart';
import 'package:dropdown_search/dropdown_search.dart';

class RecipeProbesScreen extends StatelessWidget {
  final int recipeIndex;
  final String? assignedFoodItemId;
  final String? foodItemDescription;
  const RecipeProbesScreen(this.recipeIndex,
      {Key? key, this.assignedFoodItemId, this.foodItemDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Recipe probes list'),
            leading: BackButton(
                onPressed: () => {
                      context.read<RecipeBloc>().add(const RecipesSaved()),
                      Navigator.pop(context)
                    }),
          ),
          floatingActionButton: Visibility(
            visible:
                (state.recipes[recipeIndex].recipeType == 'Standard Recipe' &&
                    assignedFoodItemId == null),
            child: FloatingActionButton.extended(
                label: const Text("Add probe"),
                icon: const Icon(Icons.add),
                onPressed: () => {
                      context
                          .read<RecipeBloc>()
                          .add(ProbeAdded(recipe: state.recipes[recipeIndex])),
                      Navigator.pushNamed(context, PageRouter.editProbe,
                          arguments: [
                            recipeIndex,
                            state.recipes[recipeIndex].probes.length
                          ])
                    }),
          ),
          body: ProbeList(
            recipeIndex: recipeIndex,
            assignedFoodItemId: assignedFoodItemId,
            foodItemDescription: foodItemDescription,
          ));
    });
  }
}

class ProbeList extends StatelessWidget {
  final int recipeIndex;
  final String? assignedFoodItemId;
  final String? foodItemDescription;

  const ProbeList(
      {Key? key,
      required this.recipeIndex,
      this.assignedFoodItemId,
      this.foodItemDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Column(
        children: [
          ProbesPrompt(
              recipeIndex: recipeIndex, assignedFoodItemId: assignedFoodItemId),
          Visibility(
            visible:
                (state.recipes[recipeIndex].recipeType == 'Standard Recipe' &&
                    assignedFoodItemId != null),
            child: ListTile(
              title: const Text('Food item description'),
              subtitle: Text(foodItemDescription ?? ''),
              leading: const Icon(Icons.description),
            ),
          ),
          Visibility(
            visible:
                (state.recipes[recipeIndex].recipeType == 'Standard Recipe'),
            child: Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(2.0),
                  itemCount: state.recipes[recipeIndex].probes.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      DeleteProbe(
                                          recipe: state.recipes[recipeIndex],
                                          probe: state.recipes[recipeIndex]
                                              .probes[index]));
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
                            ListTile(
                              title: Text(state.recipes[recipeIndex]
                                      .probes[index].probeName ??
                                  ''),
                              leading: const Icon(Icons.live_help),
                              trailing: Visibility(
                                visible: (assignedFoodItemId != null),
                                child: Checkbox(
                                  value: state.recipes[recipeIndex]
                                      .probes[index].checked,
                                  onChanged: (bool? value) {
                                    context.read<RecipeBloc>().add(ProbeChecked(
                                        recipe: state.recipes[recipeIndex],
                                        probeCheck: value!,
                                        probeIndex: index));
                                  },
                                ),
                              ),
                              onTap: () => {
                                if (assignedFoodItemId == null)
                                  {
                                    Navigator.pushNamed(
                                        context, PageRouter.editProbe,
                                        arguments: [recipeIndex, index])
                                  }
                              },
                            ),
                            Visibility(
                              visible: (assignedFoodItemId != null),
                              child: DropdownSearch<String>(
                                  mode: Mode.MENU,
                                  showSelectedItems: true,
                                  showSearchBox: true,
                                  items: state.recipes[recipeIndex].probes[index]
                                      .optionsList(),
                                  onChanged: (String? answer) => context
                                      .read<RecipeBloc>()
                                      .add(ProbeOptionSelected(
                                          recipe: state.recipes[recipeIndex],
                                          probeIndex: index,
                                          answer: answer!)),
                                  selectedItem: (state.recipes[recipeIndex]
                                                  .probes[index].answer ==
                                              null ||
                                          state.recipes[recipeIndex]
                                                  .probes[index].answer ==
                                              '')
                                      ? state.recipes[recipeIndex].probes[index]
                                          .optionsList()[0]
                                      : state.recipes[recipeIndex].probes[index].answer),
                            )
                          ],
                        ),
                      )),
                    );
                  }),
            ),
          ),
        ],
      );
    });
  }
}

class ProbesPrompt extends StatelessWidget {
  final int recipeIndex;
  final String? assignedFoodItemId;
  const ProbesPrompt(
      {Key? key, required this.recipeIndex, this.assignedFoodItemId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      if (state.recipes[recipeIndex].recipeType != 'Standard Recipe') {
        return const ListTile(
          title: Text('Probes are only a feature of Standard recipes'),
          subtitle: Text('Use a standard recipe to add probes'),
          tileColor: Colors.blue,
        );
      } else if (assignedFoodItemId != null &&
          state.recipes[recipeIndex].allProbesChecked &&
          state.recipes[recipeIndex].allProbeAnswersStandard &&
          state.recipes[recipeIndex].recipeType == 'Standard Recipe' &&
          state.recipes[recipeIndex].probes.isNotEmpty) {
        return const ListTile(
          title: Text('This is a standard recipe.'),
          subtitle: Text('Confirm recipe volume on Recipe Details page'),
          tileColor: Colors.green,
        );
      } else if (assignedFoodItemId != null &&
          state.recipes[recipeIndex].allProbesChecked &&
          !state.recipes[recipeIndex].allProbeAnswersStandard &&
          state.recipes[recipeIndex].recipeType == 'Standard Recipe' &&
          state.recipes[recipeIndex].probes.isNotEmpty) {
        return const ListTile(
          title: Text('This is a modified recipe.'),
          subtitle: Text('Add or remove ingredients on the ingredients page'),
          tileColor: Colors.red,
        );
      } else {
        return const SizedBox
            .shrink(); // Empty widget used in official Material codebase
      }
    });
  }
}

class DeleteProbe extends StatelessWidget {
  final Recipe recipe;
  final Probe probe;

  const DeleteProbe({Key? key, required this.recipe, required this.probe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return AlertDialog(
        title: const Text('Delete probe'),
        content: Text('Would you like to delete the ${probe.probeName} probe?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => {
              context
                  .read<RecipeBloc>()
                  .add(ProbeDeleted(recipe: recipe, probe: probe)),
              Navigator.pop(context, 'OK')
            },
            child: const Text('OK'),
          ),
        ],
      );
    });
  }
}
