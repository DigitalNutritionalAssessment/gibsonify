import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:dropdown_plus/dropdown_plus.dart';

class IngredientForm extends StatelessWidget {
  IngredientForm({Key? key}) : super(key: key);

  final List<String> cookingStates = [
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
  final List<String> measurementMethods = [
    "Direct weight",
    "Volume of water",
    "Volume of food",
    "Play dough",
    "Number",
    "Size (photo)"
  ];
  final List<String> sizes = [
    "Small Spoon",
    "Big spoon",
    "Standard cup",
    "Small",
    "Medium",
    "Large"
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // TODO: change this to which specific recipe's ingredient is being changed
              // currently changes the adds ingredient to the last recipe in
              TextFormField(
                initialValue: state.recipes.last.ingredients.last.name.value,
                decoration: InputDecoration(
                  icon: const Icon(Icons.set_meal_rounded),
                  labelText: 'Ingredient name',
                  helperText: 'Ingredient name e.g. Rice',
                  errorText: state.recipes.last.ingredients.last.name.invalid
                      ? 'Enter an ingredient name e.g. Tomato'
                      : null,
                ),
                onChanged: (value) {
                  context.read<RecipeBloc>().add(IngredientNameChanged(
                      ingredient: state.recipes.last.ingredients.last,
                      ingredientName: value,
                      recipe: state.recipes.last));
                },
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                initialValue:
                    state.recipes.last.ingredients.last.description.value,
                decoration: InputDecoration(
                  icon: const Icon(Icons.description_rounded),
                  labelText: 'Ingredient description',
                  helperText: 'Ingredient description e.g. Big, dry, ripe etc.',
                  errorText:
                      state.recipes.last.ingredients.last.description.invalid
                          ? 'Enter an ingredient description e.g. Ripe'
                          : null,
                ),
                onChanged: (value) {
                  context.read<RecipeBloc>().add(IngredientDescriptionChanged(
                      ingredient: state.recipes.last.ingredients.last,
                      ingredientDescription: value,
                      recipe: state.recipes.last));
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
                      state.recipes.last.ingredients.last.cookingState.invalid
                          ? 'Enter a cooking state'
                          : null,
                ),
                onSaved: (dynamic str) {}, // investigate onSaved vs onChanged
                onChanged: (dynamic value) {
                  context.read<RecipeBloc>().add(CookingStateChanged(
                      ingredient: state.recipes.last.ingredients.last,
                      cookingState: value,
                      recipe: state.recipes.last));
                },
                validator: (dynamic str) {},
                displayItemFn: (dynamic item) => Text(
                  item ?? '',
                ),
                findFn: (dynamic str) async => cookingStates,
                filterFn: (dynamic item, str) =>
                    item.toLowerCase().indexOf(str.toLowerCase()) >= 0,
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
                  errorText: state.recipes.last.ingredients.last
                          .measurementMethod.invalid
                      ? 'Enter a measurement method'
                      : null,
                ),
                onSaved: (dynamic str) {}, // investigate onSaved vs onChanged
                onChanged: (dynamic value) {
                  context.read<RecipeBloc>().add(MeasurementMethodChanged(
                      ingredient: state.recipes.last.ingredients.last,
                      measurementMethod: value,
                      recipe: state.recipes.last));
                },
                validator: (dynamic str) {},
                displayItemFn: (dynamic item) => Text(
                  item ?? '',
                ),
                findFn: (dynamic str) async => measurementMethods,
                filterFn: (dynamic item, str) =>
                    item.toLowerCase().indexOf(str.toLowerCase()) >= 0,
                dropdownItemFn: (dynamic item, position, focused,
                        dynamic lastSelectedItem, onTap) =>
                    ListTile(
                  title: Text(item),
                  onTap: onTap,
                ),
              ),
              TextFormField(
                initialValue:
                    state.recipes.last.ingredients.last.measurement.value,
                decoration: InputDecoration(
                  icon: const Icon(Icons.format_list_numbered_rounded),
                  labelText: 'Measurement volume',
                  helperText: 'Input measurement volume',
                  errorText:
                      state.recipes.last.ingredients.last.measurement.invalid
                          ? 'Enter an ingredient name e.g. Banana'
                          : null,
                ),
                onChanged: (value) {
                  context.read<RecipeBloc>().add(MeasurementChanged(
                      ingredient: state.recipes.last.ingredients.last,
                      measurement: value,
                      recipe: state.recipes.last));
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                initialValue:
                    state.recipes.last.ingredients.last.measurementUnit.value,
                decoration: InputDecoration(
                  icon: const Icon(Icons.local_drink_rounded),
                  labelText: 'Measurement unit',
                  helperText: 'Grams or milliters',
                  errorText: state
                          .recipes.last.ingredients.last.measurementUnit.invalid
                      ? 'Enter a measurement unit'
                      : null,
                ),
                onChanged: (value) {
                  context.read<RecipeBloc>().add(MeasurementUnitChanged(
                      ingredient: state.recipes.last.ingredients.last,
                      measurementUnit: value,
                      recipe: state.recipes.last));
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
                  errorText: state.recipes.last.ingredients.last
                          .measurementMethod.invalid
                      ? 'Enter a size measurement'
                      : null,
                ),
                onSaved: (dynamic str) {}, // investigate onSaved vs onChanged
                onChanged: (dynamic value) {
                  context.read<RecipeBloc>().add(SizeChanged(
                      ingredient: state.recipes.last.ingredients.last,
                      size: value,
                      recipe: state.recipes.last));
                },
                validator: (dynamic str) {},
                displayItemFn: (dynamic item) => Text(
                  item ?? '',
                ),
                findFn: (dynamic str) async => sizes,
                filterFn: (dynamic item, str) =>
                    item.toLowerCase().indexOf(str.toLowerCase()) >= 0,
                dropdownItemFn: (dynamic item, position, focused,
                        dynamic lastSelectedItem, onTap) =>
                    ListTile(
                  title: Text(item),
                  onTap: onTap,
                ),
              ),
              TextFormField(
                initialValue:
                    state.recipes.last.ingredients.last.sizeNumber.value,
                decoration: InputDecoration(
                  icon: const Icon(Icons.fastfood),
                  labelText: 'Size number',
                  helperText: 'Input size',
                  errorText:
                      state.recipes.last.ingredients.last.sizeNumber.invalid
                          ? 'Enter an ingredient name e.g. Banana'
                          : null,
                ),
                onChanged: (value) {
                  context.read<RecipeBloc>().add(SizeNumberChanged(
                      ingredient: state.recipes.last.ingredients.last,
                      sizeNumber: value,
                      recipe: state.recipes.last));
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
            ],
          ));
    });
  }
}
