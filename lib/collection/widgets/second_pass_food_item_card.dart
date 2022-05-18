import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify/navigation/navigation.dart';

class SecondPassFoodItemCard extends StatelessWidget {
  const SecondPassFoodItemCard(
      {Key? key,
      required this.foodItem,
      this.onSourceChanged,
      this.onDescriptionChanged,
      this.onPreparationMethodChanged,
      this.onCustomPreparationMethodChanged})
      : super(key: key);

  final FoodItem foodItem;
  final ValueChanged<String>? onSourceChanged;
  final ValueChanged<String>? onDescriptionChanged;
  final ValueChanged<String>? onPreparationMethodChanged;
  final ValueChanged<String>? onCustomPreparationMethodChanged;

  @override
  Widget build(BuildContext context) {
    String foodItemDisplayName = isFieldUnmodifiedOrEmpty(foodItem.name)
        ? 'Unnamed food'
        : foodItem.name!;
    String foodItemDisplayTimePeriod =
        isFieldUnmodifiedOrEmpty(foodItem.timePeriod)
            ? 'unspecified period'
            : foodItem.timePeriod!;
    const List<String> foodSources = [
      'Home made',
      'Purchased',
      'Gift/given by neighbor',
      'Home garden/farm',
      'Leftover',
      'Wild food',
      'Food aid',
      'Other'
    ];
    const List<String> preparationMethods = [
      'Raw',
      'Boiled',
      'Boiled in water but retained water',
      'Boiled in water but removed water',
      'Steamed',
      'Roasted with oil',
      'Roasted without oil',
      'Fried',
      'Stir-fried',
      'Soaking and stir-fried',
      'Boiled and fried',
      'Boiled and stir-fried',
      'Steamed and fried',
      'Roasted and boiled',
      'Other (please specify)'
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
                '$foodItemDisplayName consumed in the $foodItemDisplayTimePeriod'),
            DropdownSearch<String>(
                popupProps: const PopupProps.menu(
                    showSelectedItems: true,
                    fit: FlexFit.loose,
                    menuProps:
                        MenuProps(constraints: BoxConstraints.tightFor())),
                dropdownSearchDecoration: InputDecoration(
                    icon: const Icon(Icons.kitchen),
                    labelText: 'Food source',
                    helperText: 'Where does the food come from',
                    // TODO: the errorText should be displayed if nothing is chosen
                    // so investigate how this can be achieved with focusnodes or
                    // maybe send an empty string (although that would not work all
                    // the time), currently errorText is never displayed
                    errorText: isFieldModifiedAndEmpty(foodItem.source)
                        ? 'Select the food source'
                        : null),
                items: foodSources,
                onChanged: (String? foodSource) =>
                    onSourceChanged!(foodSource!),
                selectedItem: foodItem.source),
            DropdownSearch<String>(
                popupProps: const PopupProps.menu(
                    showSelectedItems: true,
                    menuProps: MenuProps(
                        constraints:
                            // Set maxHeight to 645 to indicate slidability
                            // by cutting the last item in half
                            BoxConstraints(maxHeight: 645.0))),
                dropdownSearchDecoration: InputDecoration(
                    icon: const Icon(Icons.food_bank_rounded),
                    labelText: 'Form when eaten',
                    helperText: 'The preparation method of the food',
                    // TODO: the errorText should be displayed if nothing is chosen
                    // so investigate how this can be achieved with focusnodes or
                    // maybe send an empty string (although that would not work all
                    // the time), currently errorText is never displayed
                    errorText:
                        isFieldModifiedAndEmpty(foodItem.preparationMethod)
                            ? 'Select the food\'s preparation method'
                            : null),
                items: preparationMethods,
                onChanged: (String? preparationMethod) =>
                    onPreparationMethodChanged!(preparationMethod!),
                selectedItem: foodItem.preparationMethod),
            Visibility(
              visible: (foodItem.preparationMethod == "Other (please specify)"),
              child: TextFormField(
                initialValue: foodItem.customPreparationMethod,
                decoration: InputDecoration(
                  icon: const Icon(Icons.food_bank_rounded),
                  labelText: 'Specify form when eaten',
                  helperText: 'The preparation method of the food',
                  errorText:
                      isFieldModifiedAndEmpty(foodItem.customPreparationMethod)
                          ? 'Enter the food\'s preparation method e.g. baked'
                          : null,
                ),
                onChanged: (String? customPreparationMethod) =>
                    onCustomPreparationMethodChanged!(customPreparationMethod!),
                textInputAction: TextInputAction.next,
              ),
            ),
            TextFormField(
              initialValue: foodItem.description,
              decoration: const InputDecoration(
                icon: Icon(Icons.info),
                labelText: 'Comments',
                helperText: 'Optional comments about the food item',
              ),
              onChanged: (value) => onDescriptionChanged!(value),
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              initialValue: foodItem.recipe?.name ?? '',
              readOnly: true,
              key: UniqueKey(),
              decoration: const InputDecoration(
                icon: Icon(Icons.bookmark),
                labelText: 'Food recipe',
                helperText: 'What is the recipe of this food',
                // TODO: implement errorText if user has clicked to add a recipe
                // but has not added any recipe (if recipe is still null)
                // errorText: foodItem.recipe == null
                //     ? 'Select the food recipe'
                //     : null,
              ),
              onTap: () {
                Navigator.pushNamed(context, PageRouter.chooseRecipe,
                    arguments: {
                      'assignedFoodItemId': foodItem.id,
                      'foodItemDescription': foodItem.description,
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
