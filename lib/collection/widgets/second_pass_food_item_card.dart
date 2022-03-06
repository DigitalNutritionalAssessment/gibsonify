import 'package:flutter/material.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify/navigation/navigation.dart';

class SecondPassFoodItemCard extends StatelessWidget {
  const SecondPassFoodItemCard(
      {Key? key,
      required this.foodItem,
      this.onSourceChanged,
      this.onDescriptionChanged,
      this.onPreparationMethodChanged})
      : super(key: key);

  final FoodItem foodItem;
  final ValueChanged<String>? onSourceChanged;
  final ValueChanged<String>? onDescriptionChanged;
  final ValueChanged<String>? onPreparationMethodChanged;

  @override
  Widget build(BuildContext context) {
    // TODO: research how to handle empty string as
    // the selected value other than a blank menu item
    const List<DropdownMenuItem<String>> sourceDropdownMenuItems = [
      DropdownMenuItem(child: Text(''), value: ''),
      DropdownMenuItem(child: Text('Home made'), value: 'Home made'),
      DropdownMenuItem(child: Text('Purchased'), value: 'Purchased'),
      DropdownMenuItem(
          child: Text('Gift/given by neighbor'),
          value: 'Gift/given by neighbor'),
      DropdownMenuItem(
          child: Text('Home garden/farm'), value: 'Home garden/farm'),
      DropdownMenuItem(child: Text('Leftover'), value: 'Leftover'),
      DropdownMenuItem(child: Text('Wild food'), value: 'Wild food'),
      DropdownMenuItem(child: Text('Food aid'), value: 'Food aid'),
      DropdownMenuItem(child: Text('Other'), value: 'Other'),
    ];
    const List<DropdownMenuItem<String>> preparationMethodDropdownMenuItems = [
      DropdownMenuItem(child: Text(''), value: ''),
      DropdownMenuItem(child: Text('Raw'), value: 'Raw'),
      DropdownMenuItem(child: Text('Boiled'), value: 'Boiled'),
      DropdownMenuItem(
          child: Text('Boiled in water but retained water'),
          value: 'Boiled in water but retained water'),
      DropdownMenuItem(
          child: Text('Boiled in water but removed water'),
          value: 'Boiled in water but removed water'),
      DropdownMenuItem(child: Text('Steamed'), value: 'Steamed'),
      DropdownMenuItem(
          child: Text('Roasted with oil'), value: 'Roasted with oil'),
      DropdownMenuItem(
          child: Text('Roasted without oil'), value: 'Roasted without oil'),
      DropdownMenuItem(child: Text('Fried'), value: 'Fried'),
      DropdownMenuItem(child: Text('Stir-fried'), value: 'Stir-fried'),
      DropdownMenuItem(
          child: Text('Soaking and stir-fried'),
          value: 'Soaking and stir-fried'),
      DropdownMenuItem(
          child: Text('Boiled and fried'), value: 'Boiled and fried'),
      DropdownMenuItem(
          child: Text('Boiled and stir-fried'), value: 'Boiled and stir-fried'),
      DropdownMenuItem(
          child: Text('Steamed and fried'), value: 'Steamed and fried'),
      DropdownMenuItem(
          child: Text('Roasted and boiled'), value: 'Roasted and boiled'),
      DropdownMenuItem(child: Text('Other'), value: 'Other')
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(foodItem.name.value +
                ' consumed in the ' +
                foodItem.timePeriod.value),
            // TODO: fix RenderFlex overflow
            DropdownButtonFormField(
              value: foodItem.source.value,
              decoration: InputDecoration(
                icon: const Icon(Icons.kitchen),
                labelText: 'Food source',
                helperText: 'Where does the food come from',
                errorText:
                    foodItem.source.invalid ? 'Select the food source' : null,
              ),
              items: sourceDropdownMenuItems,
              onChanged: (String? value) => onSourceChanged!(value ?? ''),
            ),
            TextFormField(
              initialValue: foodItem.description.value,
              decoration: InputDecoration(
                icon: const Icon(Icons.info),
                labelText: 'Food ingredients',
                helperText: 'Detailed list of ingredients',
                errorText: foodItem.description.invalid
                    ? 'Write down the full list of ingredients'
                    : null,
              ),
              onChanged: (value) => onDescriptionChanged!(value),
              textInputAction: TextInputAction.next,
            ),
            DropdownButtonFormField(
              value: foodItem.preparationMethod.value,
              decoration: InputDecoration(
                icon: const Icon(Icons.coffee_maker_outlined),
                labelText: 'Form when eaten',
                helperText: 'The preparation method of the food',
                errorText: foodItem.preparationMethod.invalid
                    ? 'Select the food\'s preparation method'
                    : null,
              ),
              items: preparationMethodDropdownMenuItems,
              onChanged: (String? value) =>
                  onPreparationMethodChanged!(value ?? ''),
            ),
            TextFormField(
              initialValue: foodItem.recipe?.recipeName ?? '',
              readOnly: true,
              key: UniqueKey(),
              decoration: InputDecoration(
                icon: const Icon(Icons.bookmark),
                labelText: 'Food recipe',
                helperText: 'What is the recipe of this food',
                // TODO:
                // errorText: foodItem.recipe == null
                //     ? 'Enter the food recipe'
                //     : null,
              ),
              onTap: () {
                Navigator.pushNamed(context, PageRouter.chooseRecipe,
                    arguments: {
                      'assignedFoodItemId': foodItem.id,
                      'foodItemDescription': foodItem.description.value,
                    });
              },
              textInputAction: TextInputAction.next,
            ),
          ],
        ),
      ),
    );
  }
}
