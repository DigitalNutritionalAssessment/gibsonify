import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify/login/login.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify/navigation/navigation.dart';
import 'package:dropdown_search/dropdown_search.dart';

class RecipeProbesScreen extends StatelessWidget {
  final int recipeIndex;
  final bool viewedFromCollection;
  final String? assignedFoodItemId;
  final String? foodItemDescription;
  const RecipeProbesScreen(this.recipeIndex,
      {Key? key,
      required this.viewedFromCollection,
      this.assignedFoodItemId,
      this.foodItemDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(title: const Text('Recipe probes list')),
          floatingActionButton: Visibility(
            visible: (state.recipes[recipeIndex].type == 'Standard Recipe' &&
                !viewedFromCollection &&
                !state.recipes[recipeIndex].saved),
            child: FloatingActionButton.extended(
                label: const Text("Add probe"),
                icon: const Icon(Icons.add),
                onPressed: () => {
                      context
                          .read<RecipeBloc>()
                          .add(ProbeAdded(recipe: state.recipes[recipeIndex])),
                      Navigator.pushNamed(context, PageRouter.editProbe,
                          arguments: {
                            'recipeIndex': recipeIndex,
                            'probeIndex':
                                state.recipes[recipeIndex].probes.length,
                          })
                    }),
          ),
          body: ProbeList(
            recipeIndex: recipeIndex,
            viewedFromCollection: viewedFromCollection,
            assignedFoodItemId: assignedFoodItemId,
            foodItemDescription: foodItemDescription,
          ));
    });
  }
}

class ProbeList extends StatelessWidget {
  final int recipeIndex;
  final bool viewedFromCollection;
  final String? assignedFoodItemId;
  final String? foodItemDescription;

  const ProbeList(
      {Key? key,
      required this.recipeIndex,
      required this.viewedFromCollection,
      this.assignedFoodItemId,
      this.foodItemDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Visibility(
                visible: state.recipes[recipeIndex].saved,
                child: const SavedRecipeListTile()),
            ProbesPrompt(
              recipeIndex: recipeIndex,
              viewedFromCollection: viewedFromCollection,
              assignedFoodItemId: assignedFoodItemId,
              foodItemDescription: foodItemDescription,
            ),
            Visibility(
                visible: (state.recipes[recipeIndex].type == 'Standard Recipe'),
                child: Expanded(
                  child: Column(children: [
                    AbsorbPointer(
                        absorbing: state.recipes[recipeIndex].saved,
                        child: RecipeNameInput(recipeIndex)),
                    Visibility(
                        visible: (viewedFromCollection &&
                            isFieldNotNullAndNotEmpty(foodItemDescription)),
                        child: TextFormField(
                          initialValue: foodItemDescription,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.info),
                            labelText: 'Food item comments',
                          ),
                          enabled: false,
                        )),
                    const SizedBox(height: 10),
                    ListTile(
                        title: (state.recipes[recipeIndex].probes.isNotEmpty)
                            ? const Text('Probes:')
                            : const Text('Recipe has no probes currently')),
                    Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(2.0),
                          itemCount: state.recipes[recipeIndex].probes.length,
                          itemBuilder: (context, index) {
                            return Card(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ListTile(
                                      title: Text(state
                                          .recipes[recipeIndex].probes[index]
                                          .probeNameDisplay()),
                                      leading: const Icon(Icons.live_help),
                                      trailing: Visibility(
                                        visible: viewedFromCollection,
                                        child: Checkbox(
                                          value: state.recipes[recipeIndex]
                                              .probes[index].checked,
                                          onChanged: (bool? value) {
                                            context.read<RecipeBloc>().add(
                                                ProbeChecked(
                                                    recipe: state
                                                        .recipes[recipeIndex],
                                                    probeCheck: value!,
                                                    probeIndex: index));
                                          },
                                        ),
                                      ),
                                      onTap: () => {
                                            if (!viewedFromCollection)
                                              {
                                                Navigator.pushNamed(context,
                                                    PageRouter.editProbe,
                                                    arguments: {
                                                      'recipeIndex':
                                                          recipeIndex,
                                                      'probeIndex': index,
                                                    })
                                              }
                                          },
                                      onLongPress: (state
                                                  .recipes[recipeIndex].saved ||
                                              viewedFromCollection)
                                          ? null
                                          : () => showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return ProbeOptions(
                                                    recipe: state
                                                        .recipes[recipeIndex],
                                                    probe: state
                                                        .recipes[recipeIndex]
                                                        .probes[index]);
                                              })),
                                  Visibility(
                                    visible: (viewedFromCollection),
                                    child: DropdownSearch<String>(
                                        popupProps: const PopupProps.menu(
                                            showSelectedItems: true,
                                            fit: FlexFit.loose,
                                            menuProps: MenuProps(
                                                constraints:
                                                    BoxConstraints.tightFor())),
                                        items: state
                                            .recipes[recipeIndex].probes[index]
                                            .optionsList(),
                                        onChanged: (String? answer) => context
                                            .read<RecipeBloc>()
                                            .add(ProbeOptionSelected(
                                                recipe:
                                                    state.recipes[recipeIndex],
                                                probeIndex: index,
                                                answer: answer!)),
                                        selectedItem: (state.recipes[recipeIndex].probes[index].answer == null ||
                                                state.recipes[recipeIndex]
                                                        .probes[index].answer ==
                                                    '')
                                            ? state.recipes[recipeIndex].probes[index]
                                                .optionsList()[0]
                                            : state.recipes[recipeIndex].probes[index].answer),
                                  )
                                ],
                              ),
                            ));
                          }),
                    ),
                  ]),
                )),
          ],
        ),
      );
    });
  }
}

class ProbesPrompt extends StatelessWidget {
  final int recipeIndex;
  final bool viewedFromCollection;
  final String? assignedFoodItemId;
  final String? foodItemDescription;
  const ProbesPrompt(
      {Key? key,
      required this.recipeIndex,
      required this.viewedFromCollection,
      this.assignedFoodItemId,
      this.foodItemDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, loginState) {
      return BlocBuilder<RecipeBloc, RecipeState>(
          builder: (context, recipeState) {
        if (recipeState.recipes[recipeIndex].type != 'Standard Recipe') {
          return const ListTile(
            title: Text('Probes are only a feature of Standard recipes'),
            subtitle: Text('Use a standard recipe to add probes'),
            tileColor: Colors.blue,
          );
        } else if (viewedFromCollection &&
            recipeState.recipes[recipeIndex].allProbesChecked &&
            recipeState.recipes[recipeIndex].allProbeAnswersStandard &&
            recipeState.recipes[recipeIndex].type == 'Standard Recipe' &&
            recipeState.recipes[recipeIndex].probes.isNotEmpty) {
          return const ListTile(
            title: Text('This is a standard recipe.'),
            subtitle: Text('Confirm recipe volume on Recipe Details page'),
            tileColor: Colors.green,
          );
        } else if (viewedFromCollection &&
            recipeState.recipes[recipeIndex].allProbesChecked &&
            !recipeState.recipes[recipeIndex].allProbeAnswersStandard &&
            recipeState.recipes[recipeIndex].type == 'Standard Recipe' &&
            recipeState.recipes[recipeIndex].probes.isNotEmpty) {
          return ListTile(
            title: const Text('This is a modified recipe.'),
            subtitle: const Text('Tap here to create a modified recipe'),
            tileColor: Colors.red,
            onTap: () => {
              context.read<RecipeBloc>().add(ModifiedRecipeCreated(
                  recipe: recipeState.recipes[recipeIndex],
                  employeeNumber: loginState.loginInfo.employeeId!)),
              context.read<RecipeBloc>().add(const RecipesSaved()),
              Navigator.pop(context),
              Navigator.pushNamed(context, PageRouter.recipe, arguments: {
                'recipeIndex': recipeIndex + 1,
                'viewedFromCollection': viewedFromCollection,
                'assignedFoodItemId': assignedFoodItemId,
                'foodItemDescription': foodItemDescription,
                'selectedScreen': SelectedRecipeScreen.ingredientScreen
              })
            },
          );
        } else {
          return const SizedBox
              .shrink(); // Empty widget used in official Material codebase
        }
      });
    });
  }
}

class ProbeOptions extends StatelessWidget {
  final Recipe recipe;
  final Probe probe;

  const ProbeOptions({Key? key, required this.recipe, required this.probe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      final List<Widget> options = [
        const ListTile(title: Text('Probe options')),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.copy),
          title: const Text('Duplicate'),
          onTap: () => {
            context
                .read<RecipeBloc>()
                .add(ProbeDuplicated(recipe: recipe, probe: probe)),
            Navigator.pop(context)
          },
        ),
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text('Delete'),
          onTap: () => {
            context
                .read<RecipeBloc>()
                .add(ProbeDeleted(recipe: recipe, probe: probe)),
            Navigator.pop(context)
          },
        )
      ];
      return Wrap(children: options);
    });
  }
}
