import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify/collection/collection.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final int recipeIndex;
  final String? assignedFoodItemId;
  const RecipeDetailsScreen(this.recipeIndex,
      {Key? key, this.assignedFoodItemId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Recipe details'),
          leading: BackButton(
              onPressed: () => {
                    context.read<RecipeBloc>().add(const RecipesSaved()),
                    Navigator.pop(context)
                  }),
        ),
        body: RecipeDetails(recipeIndex),
        floatingActionButton: FloatingActionButton.extended(
            heroTag: null,
            label: assignedFoodItemId == null
                ? const Text("Save Recipe")
                : const Text("Choose Recipe"),
            icon: assignedFoodItemId == null
                ? const Icon(Icons.save_sharp)
                : const Icon(Icons.check),
            onPressed: () {
              if (assignedFoodItemId == null) {
                context.read<RecipeBloc>().add(RecipeStatusChanged(
                    recipe: state.recipes[recipeIndex], recipeSaved: true));
                context.read<RecipeBloc>().add(const RecipesSaved());
                Navigator.pop(context);
              } else {
                context.read<CollectionBloc>().add(FoodItemRecipeChanged(
                    foodItemId: assignedFoodItemId!,
                    foodItemRecipe: state.recipes[recipeIndex]));
                context.read<RecipeBloc>().add(const RecipesSaved());
                Navigator.pop(context);
                Navigator.pop(context);
              }
            }),
      );
    });
  }
}

class RecipeDetails extends StatelessWidget {
  final int recipeIndex;
  const RecipeDetails(this.recipeIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          RecipeNameInput(recipeIndex),
          RecipeNumberInput(recipeIndex),
          RecipeVolumeInput(recipeIndex),
        ],
      ),
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
