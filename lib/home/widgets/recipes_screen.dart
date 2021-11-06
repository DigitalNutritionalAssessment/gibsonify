import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/navigation/navigation.dart';
import 'package:gibsonify/recipe/recipe.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  _RecipesScreenState createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
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
                        subtitle: Text(state.recipes[index].recipeVolume.value),
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
                FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => {
                          context.read<RecipeBloc>().add(RecipeAdded()),
                          Navigator.pushNamed(context, PageRouter.recipe,
                              arguments: state.recipes.length),
                        })
              ]));
    });
  }
}
