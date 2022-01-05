import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/recipe/recipe.dart';

class RecipeProbePage extends StatelessWidget {
  final int recipeIndex;
  const RecipeProbePage(this.recipeIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
              title: Text(
                  'Probe list for ${state.recipes[recipeIndex].recipeName.value}')),
          floatingActionButton: FloatingActionButton.extended(
              label: const Text("Add probe"),
              icon: const Icon(Icons.add),
              onPressed: () => {
                    context
                        .read<RecipeBloc>()
                        .add(ProbeAdded(recipe: state.recipes[recipeIndex])),
                  }),
          body: ProbeList(recipeIndex: recipeIndex));
    });
  }
}
