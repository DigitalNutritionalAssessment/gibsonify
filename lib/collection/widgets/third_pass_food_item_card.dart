import 'package:flutter/material.dart';

import 'package:gibsonify_api/gibsonify_api.dart';

class ThirdPassFoodItemCard extends StatelessWidget {
  const ThirdPassFoodItemCard(
      {Key? key,
      required this.foodItem,
      this.onMeasurementMethodChanged,
      this.onMeasurementValueChanged,
      this.onMeasurementUnitChanged})
      : super(key: key);

  final FoodItem foodItem;
  final ValueChanged<String>? onMeasurementMethodChanged;
  final ValueChanged<String>? onMeasurementValueChanged;
  final ValueChanged<String>? onMeasurementUnitChanged;

  @override
  Widget build(BuildContext context) {
    // TODO: research how to handle empty string as
    // the selected value other than a blank menu item
    const List<DropdownMenuItem<String>> measurementMethodDropdownMenuItems = [
      DropdownMenuItem(child: Text(''), value: ''),
      DropdownMenuItem(child: Text('Direct weight'), value: 'Direct weight'),
      DropdownMenuItem(
          child: Text('Volume of water'), value: 'Volume of water'),
      DropdownMenuItem(child: Text('Volume of food'), value: 'Volume of food'),
      DropdownMenuItem(child: Text('Play dough'), value: 'Play dough'),
      DropdownMenuItem(child: Text('Number'), value: 'Number'),
      DropdownMenuItem(child: Text('Size (photo)'), value: 'Size (photo)')
    ];
    const List<DropdownMenuItem<String>> measurementUnitDropdownMenuItems = [
      DropdownMenuItem(child: Text(''), value: ''),
      DropdownMenuItem(child: Text('Small spoon'), value: 'Small spoon'),
      DropdownMenuItem(child: Text('Big spoon'), value: 'Big spoon'),
      DropdownMenuItem(child: Text('Standard cup'), value: 'Standard cup'),
      DropdownMenuItem(child: Text('Small'), value: 'Small'),
      DropdownMenuItem(child: Text('Medium'), value: 'Medium'),
      DropdownMenuItem(child: Text('Large'), value: 'Large'),
      DropdownMenuItem(child: Text('Grams'), value: 'Grams'),
      DropdownMenuItem(child: Text('Millilitres'), value: 'Millilitres')
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
                value: foodItem.measurementMethod.value,
                decoration: InputDecoration(
                  icon: const Icon(Icons.monitor_weight_outlined),
                  labelText: 'Measurement method',
                  helperText: 'The method used to estimate food quantity',
                  errorText: foodItem.measurementMethod.invalid
                      ? 'Select the measurement method'
                      : null,
                ),
                items: measurementMethodDropdownMenuItems,
                onChanged: (String? value) =>
                    onMeasurementMethodChanged!(value ?? '')),
            TextFormField(
              initialValue: foodItem.measurementValue.value,
              decoration: InputDecoration(
                icon: const Icon(Icons.drive_file_rename_outline_rounded),
                labelText: 'Measurement value',
                helperText: 'The amount or number you measured',
                errorText: foodItem.measurementValue.invalid
                    ? 'Enter the dish measurement in 1 to 4 digits'
                    : null,
              ),
              onChanged: (value) => onMeasurementValueChanged!(value),
              textInputAction: TextInputAction.next,
            ),
            DropdownButtonFormField(
                value: foodItem.measurementUnit.value,
                decoration: InputDecoration(
                  icon: const Icon(Icons.radio_button_unchecked_outlined),
                  labelText: 'Measurement unit',
                  helperText: 'The size of each measurement value',
                  errorText: foodItem.measurementUnit.invalid
                      ? 'Select the measurement unit'
                      : null,
                ),
                items: measurementUnitDropdownMenuItems,
                onChanged: (String? value) =>
                    onMeasurementUnitChanged!(value ?? '')),
          ],
        ),
      ),
    );
  }
}
