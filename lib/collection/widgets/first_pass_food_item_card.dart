import 'package:flutter/material.dart';

import 'package:gibsonify_api/gibsonify_api.dart';

class FirstPassFoodItemCard extends StatelessWidget {
  const FirstPassFoodItemCard(
      {Key? key,
      required this.foodItem,
      this.onNameChanged,
      this.onTimePeriodChanged,
      this.onDeleted})
      : super(key: key);

  final FoodItem foodItem;
  final ValueChanged<String>? onNameChanged;
  final ValueChanged<String>? onTimePeriodChanged;
  final VoidCallback? onDeleted;

  @override
  Widget build(BuildContext context) {
    const List<DropdownMenuItem<String>> dropdownMenuItems = [
      DropdownMenuItem(child: Text(''), value: ''),
      DropdownMenuItem(
          child: Text('Morning (3:01 am - 12:00 pm)'), value: 'Morning'),
      DropdownMenuItem(
          child: Text('Afternoon (12:01 pm - 4:00 pm)'), value: 'Afternoon'),
      DropdownMenuItem(
          child: Text('Evening (4:01 pm - 7:00 pm)'), value: 'Evening'),
      DropdownMenuItem(child: Text('Night (7:01 pm - 3:00 am)'), value: 'Night')
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
                // A unique key needs to be set in order to properly
                // rebuild this Field after deleting a FoodItem
                key: Key(foodItem.id),
                initialValue: foodItem.name.value,
                decoration: InputDecoration(
                    icon: const Icon(Icons.fastfood),
                    labelText: 'Food name',
                    helperText: 'Food name e.g. Dhal',
                    errorText: foodItem.name.invalid
                        ? 'Enter a food name e.g. Banana'
                        : null),
                onChanged: (value) => onNameChanged!(value),
                textInputAction: TextInputAction.next),
            DropdownButtonFormField(
                value: foodItem.timePeriod.value,
                decoration: InputDecoration(
                    icon: const Icon(Icons.access_time),
                    labelText: 'Time period',
                    helperText:
                        'Time period of consuming the food e.g. Morning',
                    errorText: foodItem.timePeriod.invalid
                        ? 'Select a time period'
                        : null),
                items: dropdownMenuItems,
                onChanged: (String? value) =>
                    onTimePeriodChanged!(value ?? '')),
            const Divider(),
            // TODO: Make a pop-up with a confirmation box
            // for deleting an item, this might need to be done in First Pass
            // Screen
            TextButton(
                onPressed: () => onDeleted!(), child: const Text('Delete'))
          ],
        ),
      ),
    );
  }
}
