import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gibsonify_api/gibsonify_api.dart';

class ProbeForm extends StatelessWidget {
  final int recipeIndex;
  final int probeIndex;
  const ProbeForm(this.recipeIndex, this.probeIndex, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                initialValue:
                    state.recipes[recipeIndex].probes[probeIndex].probeName,
                decoration: InputDecoration(
                    icon: const Icon(Icons.live_help),
                    labelText: 'Probe ${probeIndex + 1}',
                    helperText:
                        'Recipe probe - e.g. Which flour did you use to make roti?',
                    errorText: (state.recipes[recipeIndex].probes[probeIndex]
                                    .probeName !=
                                null &&
                            state.recipes[recipeIndex].probes[probeIndex]
                                .probeName!.isEmpty)
                        ? 'Probes cannot be empty'
                        : null),
                onChanged: (value) {
                  context.read<RecipeBloc>().add(ProbeChanged(
                      recipe: state.recipes[recipeIndex],
                      probeName: value,
                      probeIndex: probeIndex));
                },
                textInputAction: TextInputAction.next,
              ),
              const ListTile(title: Text('Edit probe options:')),
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(2.0),
                    itemCount: state.recipes[recipeIndex].probes[probeIndex]
                        .probeOptions.length,
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
                                          DeleteProbeOption(
                                              recipe:
                                                  state.recipes[recipeIndex],
                                              probeIndex: probeIndex,
                                              probeOptionIndex: index));
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
                            child: TextFormField(
                              key: Key(state
                                  .recipes[recipeIndex]
                                  .probes[probeIndex]
                                  .probeOptions[index]['id']!),
                              initialValue: state
                                  .recipes[recipeIndex]
                                  .probes[probeIndex]
                                  .probeOptions[index]['option'],
                              decoration: InputDecoration(
                                icon: const Icon(Icons.edit),
                                labelText: (index == 0)
                                    ? 'Default option'
                                    : 'Option ${index + 1}',
                                helperText:
                                    'Probe response option - e.g. Yes/No or a type of ingredient like wheat flour',
                              ),
                              onChanged: (value) {
                                context.read<RecipeBloc>().add(
                                    ProbeOptionChanged(
                                        recipe: state.recipes[recipeIndex],
                                        probeIndex: probeIndex,
                                        probeOptionIndex: index,
                                        probeOptionName: value));
                              },
                              textInputAction: TextInputAction.next,
                            ),
                          )));
                    }),
              )
            ],
          ));
    });
  }
}

class DeleteProbeOption extends StatelessWidget {
  final Recipe recipe;
  final int probeIndex;
  final int probeOptionIndex;

  const DeleteProbeOption(
      {Key? key,
      required this.recipe,
      required this.probeIndex,
      required this.probeOptionIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return AlertDialog(
        title: const Text('Delete probe response'),
        content: Text(
            'Would you like to delete the ${recipe.probes[probeIndex].probeOptions[probeOptionIndex]['option'] ?? ''} response?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => {
              context.read<RecipeBloc>().add(ProbeOptionDeleted(
                  recipe: recipe,
                  probeIndex: probeIndex,
                  probeOptionIndex: probeOptionIndex)),
              Navigator.pop(context, 'OK')
            },
            child: const Text('OK'),
          ),
        ],
      );
    });
  }
}
