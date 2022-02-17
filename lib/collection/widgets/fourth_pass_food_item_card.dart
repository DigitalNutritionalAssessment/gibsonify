import 'package:flutter/material.dart';

import 'package:gibsonify_api/gibsonify_api.dart';

class FourthPassFoodItemCard extends StatelessWidget {
  const FourthPassFoodItemCard(
      {Key? key,
      required this.foodItem,
      this.onConfirmationChanged,
      this.onDeleted})
      : super(key: key);

  final FoodItem foodItem;
  final ValueChanged<bool>? onConfirmationChanged;
  final VoidCallback? onDeleted;

  @override
  Widget build(BuildContext context) {
    return Card(
      // TODO: change color in dark theme
      color:
          foodItem.confirmed ? Theme.of(context).colorScheme.background : null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(foodItem.name.value +
                ' consumed in the ' +
                foodItem.timePeriod.value),
            TextFormField(
              readOnly: true,
              initialValue: foodItem.source.value,
              decoration: InputDecoration(
                icon: const Icon(Icons.kitchen),
                labelText: 'Food source',
                helperText: 'Where does the food come from',
                errorText:
                    foodItem.source.invalid ? 'Select the food source' : null,
              ),
            ),
            TextFormField(
              readOnly: true,
              initialValue: foodItem.description.value,
              decoration: InputDecoration(
                icon: const Icon(Icons.info),
                labelText: 'Food description',
                helperText: 'Detailed dish description',
                errorText: foodItem.description.invalid
                    ? 'Enter the dish description'
                    : null,
              ),
            ),
            TextFormField(
              readOnly: true,
              initialValue: foodItem.preparationMethod.value,
              decoration: InputDecoration(
                icon: const Icon(Icons.coffee_maker_outlined),
                labelText: 'Form when eaten',
                helperText: 'The preparation method of the food',
                errorText: foodItem.preparationMethod.invalid
                    ? 'Select the food\'s preparation method'
                    : null,
              ),
            ),
            TextFormField(
              readOnly: true,
              initialValue: foodItem.recipe?.recipeName ?? '',
              decoration: InputDecoration(
                icon: const Icon(Icons.bookmark),
                labelText: 'Food recipe',
                helperText: 'What is the recipe of this food',
                // TODO:
                // errorText: foodItem.preparationMethod.invalid
                //     ? 'Select the food\'s preparation method'
                //     : null,
              ),
            ),
            TextFormField(
              readOnly: true,
              initialValue: foodItem.measurements[0].measurementMethod,
              decoration: InputDecoration(
                icon: const Icon(Icons.monitor_weight_outlined),
                labelText: 'Measurement method',
                helperText: 'The method used to estimate food quantity',
                errorText: !foodItem.measurements[0].isMethodValid()
                    ? 'Select the measurement method'
                    : null,
              ),
            ),
            TextFormField(
              readOnly: true,
              initialValue: foodItem.measurements[0].measurementValue,
              decoration: InputDecoration(
                icon: const Icon(Icons.drive_file_rename_outline_rounded),
                labelText: 'Measurement value',
                helperText: 'The amount or number you measured',
                errorText: !foodItem.measurements[0].isValueValid()
                    ? 'Enter the dish measurement'
                    : null,
              ),
            ),
            TextFormField(
              readOnly: true,
              initialValue: foodItem.measurements[0].measurementUnit,
              decoration: InputDecoration(
                icon: const Icon(Icons.radio_button_unchecked_outlined),
                labelText: 'Measurement unit',
                helperText: 'The size of each measurement value',
                errorText: !foodItem.measurements[0].isUnitValid()
                    ? 'Select the measurement unit'
                    : null,
              ),
            ),
            const Divider(),
            TextButton(
                // TODO: set style property to be
                // opposite color of Card
                // TODO: make each fooditem change from confirmed
                // to unconfirmed if some field of it changes
                // TODO: only allow to confirm if all fields are
                // validated by Formz
                onPressed: () => onConfirmationChanged!(!foodItem.confirmed),
                child: foodItem.confirmed
                    ? const Text('Unconfirm')
                    : const Text('Confirm')),
            const Divider(),
            TextButton(
                onPressed: () => onDeleted!(), child: const Text('Delete'))
          ],
        ),
      ),
    );
  }
}
