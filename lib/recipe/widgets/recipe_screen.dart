import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify/navigation/navigation.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add a new recipe'),
        ),
        body: const RecipeForm(),
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
                  onPressed: () =>
                      context.read<RecipeBloc>().add(IngredientAdded()))
            ]));
  }
}

class RecipeForm extends StatefulWidget {
  const RecipeForm({Key? key}) : super(key: key);

  @override
  State<RecipeForm> createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: const <Widget>[
          RecipeNameInput(),
          RecipeNumberInput(),
          RecipeVolumeInput(),
          Ingredients(),
        ],
      ),
    );
  }
}

class RecipeNameInput extends StatelessWidget {
  const RecipeNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.recipeName.value,
          decoration: InputDecoration(
            icon: const Icon(Icons.assignment_rounded),
            labelText: 'Recipe Name',
            helperText: 'A valid recipe name, e.g. Aloo bandhgobhi',
            errorText: state.recipeName.invalid
                ? 'Enter a valid recipe name, e.g. Aloo bandhgobhi'
                : null,
          ),
          onChanged: (value) {
            context
                .read<RecipeBloc>()
                .add(RecipeNameChanged(recipeName: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class RecipeNumberInput extends StatelessWidget {
  const RecipeNumberInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.recipeNumber.value,
          decoration: InputDecoration(
            icon: const Icon(Icons.format_list_numbered),
            labelText: 'Recipe Number',
            helperText: 'Number of recipe e.g. 9001',
            errorText:
                state.recipeNumber.invalid ? 'Enter recipe number' : null,
          ),
          onChanged: (value) {
            context
                .read<RecipeBloc>()
                .add(RecipeNumberChanged(recipeNumber: value));
          },
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
        );
      },
    );
  }
}

class RecipeVolumeInput extends StatelessWidget {
  const RecipeVolumeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.recipeVolume.value,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            icon: const Icon(Icons.play_for_work_rounded),
            labelText: 'Recipe Volume',
            helperText: 'Volume of recipe in ml e.g 250 ml',
            errorText: state.recipeVolume.invalid ? 'Enter valid volume' : null,
          ),
          onChanged: (value) {
            context
                .read<RecipeBloc>()
                .add(RecipeVolumeChanged(recipeVolume: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class Ingredients extends StatefulWidget {
  // Can go back to stateless?
  const Ingredients({Key? key}) : super(key: key);

  @override
  State<Ingredients> createState() => _IngredientState();
}

class _IngredientState extends State<Ingredients> {
  List<String> cookingStates = [
    "Raw",
    "Boiled",
    "Boiled in water but retained water",
    "Boiled in water but removed water",
    "Steamed",
    "Roasted with oil",
    "Roasted without oil",
    "Fried",
    "Stir - fried",
    "Soaking and stir fried",
    "Boiled and fried",
    "Boiled and stir-fried",
    "Steamed and fried",
    "Roasted and boiled"
  ];
  List<String> measurementMethods = [
    "Direct weight",
    "Volume of water",
    "Volume of food",
    "Play dough",
    "Number",
    "Size (photo)"
  ];
  List<String> sizes = [
    "Small Spoon",
    "Big spoon",
    "Standard cup",
    "Small",
    "Medium",
    "Large"
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        return Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(2.0),
                itemCount: state.ingredients.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: state.ingredients[index].name.value,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.set_meal_rounded),
                              labelText: 'Ingredient name',
                              helperText: 'Ingredient name e.g. Rice',
                              errorText: state.ingredients[index].name.invalid
                                  ? 'Enter an ingredient name e.g. Tomato'
                                  : null,
                            ),
                            onChanged: (value) {
                              context.read<RecipeBloc>().add(
                                  IngredientNameChanged(
                                      ingredient: state.ingredients[index],
                                      ingredientName: value));
                            },
                            textInputAction: TextInputAction.next,
                          ),
                          TextFormField(
                            initialValue:
                                state.ingredients[index].description.value,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.description_rounded),
                              labelText: 'Ingredient description',
                              helperText:
                                  'Ingredient description e.g. Big, dry, ripe etc.',
                              errorText: state
                                      .ingredients[index].description.invalid
                                  ? 'Enter an ingredient description e.g. Ripe'
                                  : null,
                            ),
                            onChanged: (value) {
                              context.read<RecipeBloc>().add(
                                  IngredientDescriptionChanged(
                                      ingredient: state.ingredients[index],
                                      ingredientDescription: value));
                            },
                            textInputAction: TextInputAction.next,
                          ),
                          DropdownFormField<String>(
                            onEmptyActionPressed: () async {},
                            decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.arrow_drop_down),
                              icon: const Icon(Icons.food_bank_rounded),
                              labelText: "Cooking state",
                              helperText: 'How the ingredient is prepared',
                              errorText:
                                  state.ingredients[index].cookingState.invalid
                                      ? 'Enter a cooking state'
                                      : null,
                            ),
                            onSaved: (dynamic
                                str) {}, // investigate onSaved vs onChanged
                            onChanged: (dynamic value) {
                              context.read<RecipeBloc>().add(
                                  CookingStateChanged(
                                      ingredient: state.ingredients[index],
                                      cookingState: value));
                            },
                            validator: (dynamic str) {},
                            displayItemFn: (dynamic item) => Text(
                              item ?? '',
                            ),
                            findFn: (dynamic str) async => cookingStates,
                            filterFn: (dynamic item, str) =>
                                item.toLowerCase().indexOf(str.toLowerCase()) >=
                                0,
                            dropdownItemFn: (dynamic item, position, focused,
                                    dynamic lastSelectedItem, onTap) =>
                                ListTile(
                              title: Text(item),
                              onTap: onTap,
                            ),
                          ),
                          DropdownFormField<String>(
                            onEmptyActionPressed: () async {},
                            decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.arrow_drop_down),
                              icon: const Icon(Icons.food_bank_rounded),
                              labelText: "Measurement method",
                              helperText: 'How the measurement is measured',
                              errorText: state.ingredients[index]
                                      .measurementMethod.invalid
                                  ? 'Enter a measurement method'
                                  : null,
                            ),
                            onSaved: (dynamic
                                str) {}, // investigate onSaved vs onChanged
                            onChanged: (dynamic value) {
                              context.read<RecipeBloc>().add(
                                  MeasurementMethodChanged(
                                      ingredient: state.ingredients[index],
                                      measurementMethod: value));
                            },
                            validator: (dynamic str) {},
                            displayItemFn: (dynamic item) => Text(
                              item ?? '',
                            ),
                            findFn: (dynamic str) async => measurementMethods,
                            filterFn: (dynamic item, str) =>
                                item.toLowerCase().indexOf(str.toLowerCase()) >=
                                0,
                            dropdownItemFn: (dynamic item, position, focused,
                                    dynamic lastSelectedItem, onTap) =>
                                ListTile(
                              title: Text(item),
                              onTap: onTap,
                            ),
                          ),
                          TextFormField(
                            initialValue:
                                state.ingredients[index].measurement.value,
                            decoration: InputDecoration(
                              icon: const Icon(
                                  Icons.format_list_numbered_rounded),
                              labelText: 'Measurement volume',
                              helperText: 'Input measurement volume',
                              errorText:
                                  state.ingredients[index].measurement.invalid
                                      ? 'Enter an ingredient name e.g. Banana'
                                      : null,
                            ),
                            onChanged: (value) {
                              context.read<RecipeBloc>().add(MeasurementChanged(
                                  ingredient: state.ingredients[index],
                                  measurement: value));
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                          ),
                          TextFormField(
                            initialValue:
                                state.ingredients[index].measurementUnit.value,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.local_drink_rounded),
                              labelText: 'Measurement unit',
                              helperText: 'Grams or milliters',
                              errorText: state.ingredients[index]
                                      .measurementUnit.invalid
                                  ? 'Enter a measurement unit'
                                  : null,
                            ),
                            onChanged: (value) {
                              context.read<RecipeBloc>().add(
                                  MeasurementUnitChanged(
                                      ingredient: state.ingredients[index],
                                      measurementUnit: value));
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                          ),
                          DropdownFormField<String>(
                            onEmptyActionPressed: () async {},
                            decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.arrow_drop_down),
                              icon: const Icon(Icons.local_dining_rounded),
                              labelText: "Size",
                              helperText: 'Input size measurement',
                              errorText: state.ingredients[index]
                                      .measurementMethod.invalid
                                  ? 'Enter a size measurement'
                                  : null,
                            ),
                            onSaved: (dynamic
                                str) {}, // investigate onSaved vs onChanged
                            onChanged: (dynamic value) {
                              context.read<RecipeBloc>().add(SizeChanged(
                                  ingredient: state.ingredients[index],
                                  size: value));
                            },
                            validator: (dynamic str) {},
                            displayItemFn: (dynamic item) => Text(
                              item ?? '',
                            ),
                            findFn: (dynamic str) async => sizes,
                            filterFn: (dynamic item, str) =>
                                item.toLowerCase().indexOf(str.toLowerCase()) >=
                                0,
                            dropdownItemFn: (dynamic item, position, focused,
                                    dynamic lastSelectedItem, onTap) =>
                                ListTile(
                              title: Text(item),
                              onTap: onTap,
                            ),
                          ),
                          TextFormField(
                            initialValue:
                                state.ingredients[index].sizeNumber.value,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.fastfood),
                              labelText: 'Size number',
                              helperText: 'Input size',
                              errorText:
                                  state.ingredients[index].sizeNumber.invalid
                                      ? 'Enter an ingredient name e.g. Banana'
                                      : null,
                            ),
                            onChanged: (value) {
                              context.read<RecipeBloc>().add(SizeNumberChanged(
                                  ingredient: state.ingredients[index],
                                  sizeNumber: value));
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                  );
                }));
      },
    );
  }
}
