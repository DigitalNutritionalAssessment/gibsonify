import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProbeList extends StatelessWidget {
  final int recipeIndex;

  const ProbeList({Key? key, required this.recipeIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return ListView.builder(
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
                          builder: (BuildContext context) => DeleteProbe(
                              recipe: state.recipes[recipeIndex],
                              probe: state.recipes[recipeIndex].probes[index]));
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
                  key: Key(state.recipes[recipeIndex].probes[index]['key']),
                  initialValue: state.recipes[recipeIndex].probes[index]
                      ['probe'],
                  decoration: InputDecoration(
                    icon: const Icon(Icons.live_help),
                    labelText: 'Probe ${index + 1}',
                    helperText:
                        'Recipe probe - e.g. Which flour did you use to make roti?',
                  ),
                  onChanged: (value) {
                    context.read<RecipeBloc>().add(ProbeChanged(
                        recipe: state.recipes[recipeIndex],
                        probeName: value,
                        probeIndex: index));
                  },
                  textInputAction: TextInputAction.next,
                ),
              )),
            );
          });
    });
  }
}

class DeleteProbe extends StatelessWidget {
  final Recipe recipe;
  final Map<String, dynamic> probe;

  const DeleteProbe({Key? key, required this.recipe, required this.probe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return AlertDialog(
        title: const Text('Delete probe'),
        content: Text('Would you like to delete the ${probe['probe']} probe?'),
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
