import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/recipe/recipe.dart';

class EditProbePage extends StatelessWidget {
  final int recipeIndex;
  final int probeIndex;
  const EditProbePage(this.recipeIndex, this.probeIndex, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
              title: const Text('Edit Probe'),
              leading: BackButton(
                  onPressed: () => {
                        context.read<RecipeBloc>().add(const RecipesSaved()),
                        Navigator.pop(context)
                      })),
          floatingActionButton: FloatingActionButton.extended(
              label: const Text("Save Probe"),
              icon: const Icon(Icons.save_sharp),
              onPressed: () => {Navigator.pop(context)}),
          body: ProbeForm(recipeIndex, probeIndex));
    });
  }
}
