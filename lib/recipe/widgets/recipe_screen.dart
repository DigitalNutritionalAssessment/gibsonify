import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify/navigation/navigation.dart';

class RecipeScreen extends StatelessWidget {
  final int recipeIndex;
  const RecipeScreen(this.recipeIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Add a new recipe'),
          ),
          body: RecipeForm(recipeIndex),
          floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton.extended(
                    heroTag: null,
                    label: const Text("Save Recipe"),
                    icon: const Icon(Icons.save_sharp),
                    onPressed: () => {
                          context.read<RecipeBloc>().add(RecipeStatusChanged(
                              recipe: state.recipes[recipeIndex],
                              recipeSaved: true)),
                          Navigator.pop(context)
                        }),
                const SizedBox(
                  height: 10,
                ),
                FloatingActionButton.extended(
                    heroTag: null,
                    label: const Text("New Ingredient"),
                    icon: const Icon(Icons.add),
                    onPressed: () => {
                          context.read<RecipeBloc>().add(IngredientAdded(
                              recipe: state.recipes[recipeIndex])),
                          Navigator.pushNamed(context, PageRouter.ingredient,
                              arguments: [
                                recipeIndex,
                                state.recipes[recipeIndex].ingredients.length
                              ]),
                        })
              ]));
    });
  }
}

class RecipeForm extends StatelessWidget {
  final int recipeIndex;
  const RecipeForm(this.recipeIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          RecipeNameInput(recipeIndex),
          RecipeNumberInput(recipeIndex),
          RecipeVolumeInput(recipeIndex),
          Ingredients(recipeIndex),
        ],
      ),
    );
  }
}

class RecipeNameInput extends StatelessWidget {
  final int recipeIndex;
  const RecipeNameInput(this.recipeIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.recipes[recipeIndex].recipeName.value,
          decoration: InputDecoration(
            icon: const Icon(Icons.assignment_rounded),
            labelText: 'Recipe Name',
            helperText: 'A valid recipe name, e.g. Aloo bandhgobhi',
            errorText: state.recipes[recipeIndex].recipeName.invalid
                ? 'Enter a valid recipe name, e.g. Aloo bandhgobhi'
                : null,
          ),
          onChanged: (value) {
            context.read<RecipeBloc>().add(RecipeNameChanged(
                recipeName: value, recipe: state.recipes[recipeIndex]));
          },
          textInputAction: TextInputAction.next,
        );
      },
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

class RecipeVolumeInput extends StatelessWidget {
  final int recipeIndex;
  const RecipeVolumeInput(this.recipeIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.recipes[recipeIndex].recipeVolume.value,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            icon: const Icon(Icons.play_for_work_rounded),
            labelText: 'Recipe Volume',
            helperText: 'Volume of recipe in ml e.g 250 ml',
            errorText: state.recipes[recipeIndex].recipeVolume.invalid
                ? 'Enter valid volume'
                : null,
          ),
          onChanged: (value) {
            context.read<RecipeBloc>().add(RecipeVolumeChanged(
                recipeVolume: value, recipe: state.recipes[recipeIndex]));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class Ingredients extends StatelessWidget {
  final int recipeIndex;
  const Ingredients(this.recipeIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(2.0),
              itemCount: state.recipes[recipeIndex].ingredients.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                        // TODO: Fix ingredients not updating
                        // key: Key(state.recipes[recipeIndex].ingredients[index]
                        //     .name.value),
                        title: Text(state.recipes[recipeIndex]
                            .ingredients[index].name.value),
                        subtitle: Text(state.recipes[recipeIndex]
                            .ingredients[index].description.value),
                        leading: const Icon(Icons.food_bank),
                        trailing:
                            state.recipes[recipeIndex].ingredients[index].saved
                                ? const Icon(Icons.done)
                                : const Icon(Icons.rotate_left_rounded),
                        onTap: () => {
                              Navigator.pushNamed(
                                  context, PageRouter.ingredient,
                                  arguments: [recipeIndex, index])
                            }));
              }));
    });
  }
}
