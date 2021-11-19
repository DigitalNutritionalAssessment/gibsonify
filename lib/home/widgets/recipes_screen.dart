import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/navigation/navigation.dart';
import 'package:gibsonify/recipe/recipe.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(title: const Text('Recipes')),
          body: ListView.builder(
              padding: const EdgeInsets.all(2.0),
              itemCount: state.recipes.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                        title: Text(state.recipes[index].recipeName.value),
                        subtitle: Text(state.recipes[index].recipeType),
                        trailing: state.recipes[index].saved
                            ? const Icon(Icons.done)
                            : const Icon(Icons.rotate_left_rounded),
                        onTap: () => Navigator.pushNamed(
                            context, PageRouter.recipe,
                            arguments: index)));
              }),
          floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton.extended(
                    heroTag: null,
                    label: const Text("Standard Recipe"),
                    icon: const Icon(Icons.add),
                    onPressed: () => {
                          context.read<RecipeBloc>().add(RecipeAdded(
                              recipeType: "Standard Recipe",
                              recipeNumber:
                                  (state.recipes.length + 1).toString(),
                              standard: true)),
                          Navigator.pushNamed(context, PageRouter.recipe,
                              arguments: state.recipes.length),
                        }),
                const SizedBox(
                  height: 10,
                ),
                FloatingActionButton.extended(
                    heroTag: null,
                    label: const Text("Modified Recipe"),
                    icon: const Icon(Icons.add),
                    onPressed: () => {
                          context.read<RecipeBloc>().add(RecipeAdded(
                              recipeType: "Modified Recipe",
                              recipeNumber:
                                  (state.recipes.length + 1).toString(),
                              standard: false)),
                          Navigator.pushNamed(context, PageRouter.recipe,
                              arguments: state.recipes.length),
                        })
              ]));
    });
  }
}
