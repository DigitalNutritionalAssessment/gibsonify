import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify/navigation/navigation.dart';

class RecipeScreen extends StatelessWidget {
  final Recipe _recipe;
  const RecipeScreen(Recipe recipe, {Key? key})
      : _recipe = recipe,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add a new recipe'),
        ),
        body: RecipeForm(_recipe),
        floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton.extended(
                  label: const Text("Save Recipe"),
                  icon: const Icon(Icons.save_sharp),
                  onPressed: () {}), // TODO: Implement save button logic
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton.extended(
                  label: const Text("New Ingredient"),
                  icon: const Icon(Icons.add),
                  onPressed: () => {
                        context
                            .read<RecipeBloc>()
                            .add(IngredientAdded(recipe: _recipe)),
                        Navigator.pushNamed(context, PageRouter.ingredient),
                      })
            ]));
  }
}

class RecipeForm extends StatelessWidget {
  final Recipe _recipe;
  const RecipeForm(Recipe recipe, {Key? key})
      : _recipe = recipe,
        super(key: key);

//   @override
//   State<RecipeForm> createState() => _RecipeFormState();
// }

// class _RecipeFormState extends State<RecipeForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          RecipeNameInput(_recipe),
          RecipeNumberInput(_recipe),
          RecipeVolumeInput(_recipe),
          Ingredients(_recipe),
        ],
      ),
    );
  }
}

class RecipeNameInput extends StatelessWidget {
  final Recipe _recipe;
  const RecipeNameInput(Recipe recipe, {Key? key})
      : _recipe = recipe,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        return TextFormField(
          // initialValue: state.recipeName.value,
          initialValue:
              state.recipes[state.recipes.indexOf(_recipe)].recipeName.value,
          decoration: InputDecoration(
            icon: const Icon(Icons.assignment_rounded),
            labelText: 'Recipe Name',
            helperText: 'A valid recipe name, e.g. Aloo bandhgobhi',
            errorText:
                state.recipes[state.recipes.indexOf(_recipe)].recipeName.invalid
                    ? 'Enter a valid recipe name, e.g. Aloo bandhgobhi'
                    : null,
          ),
          onChanged: (value) {
            context
                .read<RecipeBloc>()
                .add(RecipeNameChanged(recipeName: value, recipe: _recipe));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class RecipeNumberInput extends StatelessWidget {
  final Recipe _recipe;
  const RecipeNumberInput(Recipe recipe, {Key? key})
      : _recipe = recipe,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        return TextFormField(
          initialValue:
              state.recipes[state.recipes.indexOf(_recipe)].recipeNumber.value,
          decoration: InputDecoration(
            icon: const Icon(Icons.format_list_numbered),
            labelText: 'Recipe Number',
            helperText: 'Number of recipe e.g. 9001',
            errorText: state.recipes[state.recipes.indexOf(_recipe)]
                    .recipeNumber.invalid
                ? 'Enter recipe number'
                : null,
          ),
          onChanged: (value) {
            context
                .read<RecipeBloc>()
                .add(RecipeNumberChanged(recipeNumber: value, recipe: _recipe));
          },
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
        );
      },
    );
  }
}

class RecipeVolumeInput extends StatelessWidget {
  final Recipe _recipe;
  const RecipeVolumeInput(Recipe recipe, {Key? key})
      : _recipe = recipe,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        return TextFormField(
          initialValue:
              state.recipes[state.recipes.indexOf(_recipe)].recipeVolume.value,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            icon: const Icon(Icons.play_for_work_rounded),
            labelText: 'Recipe Volume',
            helperText: 'Volume of recipe in ml e.g 250 ml',
            errorText: state.recipes[state.recipes.indexOf(_recipe)]
                    .recipeVolume.invalid
                ? 'Enter valid volume'
                : null,
          ),
          onChanged: (value) {
            context
                .read<RecipeBloc>()
                .add(RecipeVolumeChanged(recipeVolume: value, recipe: _recipe));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class Ingredients extends StatelessWidget {
  final Recipe _recipe;
  const Ingredients(Recipe recipe, {Key? key})
      : _recipe = recipe,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(2.0),
              itemCount: state
                  .recipes[state.recipes.indexOf(_recipe)].ingredients.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                        title: Text(state
                            .recipes[state.recipes.indexOf(_recipe)]
                            .ingredients[index]
                            .name
                            .value),
                        subtitle: Text(state
                            .recipes[state.recipes.indexOf(_recipe)]
                            .ingredients[index]
                            .description
                            .value),
                        leading: const Icon(Icons.food_bank),
                        onTap: () => {} // TODO: Implement recipe edit logic
                        ));
              }));
    });
  }
}
