import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

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

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(foodItem.name.value +
                ' consumed in the ' +
                foodItem.timePeriod.value),
            // TODO: fix RenderFlex overflow
            DropdownSearch<String>(
                dropdownSearchDecoration: InputDecoration(
                  icon: const Icon(Icons.monitor_weight_outlined),
                  labelText: "Measurement method",
                  helperText: 'How the measurement is measured',
                  // TODO: the errorText should be displayed if nothing is chosen
                  // so investigate how this can be achieved with focusnodes or
                  // mayge send an empty string (although that would not work all
                  // the time)
                  errorText: !foodItem.measurements[0].isMethodValid()
                      ? 'Enter a measurement method'
                      : null,
                ),
                mode: Mode.MENU,
                showSelectedItems: true,
                showSearchBox: false,
                items: Measurement.measurementMethods,
                onChanged: (String? value) =>
                    onMeasurementMethodChanged!(value ?? ''),
                selectedItem: foodItem.measurements[0].measurementMethod),

            TextFormField(
              initialValue: foodItem.measurements[0].measurementValue,
              decoration: InputDecoration(
                icon: const Icon(Icons.drive_file_rename_outline_rounded),
                labelText: 'Measurement value',
                helperText: 'The amount or number you measured',
                errorText: !foodItem.measurements[0].isValueValid()
                    // TODO: the errorText should be displayed if nothing is typed
                    // so investigate how this can be achieved with focusnodes
                    ? 'Enter the measured value in 1 to 4 digits'
                    : null,
              ),
              onChanged: (value) => onMeasurementValueChanged!(value),
              textInputAction: TextInputAction.next,
            ),

            DropdownSearch<String>(
                dropdownSearchDecoration: InputDecoration(
                  icon: const Icon(Icons.radio_button_unchecked_outlined),
                  labelText: "Measurement unit",
                  helperText: 'The size of each measurement value',
                  // TODO: the errorText should be displayed if nothing is chosen
                  // so investigate how this can be achieved with focusnodes or
                  // mayge send an empty string (although that would not work all
                  // the time)
                  errorText: !foodItem.measurements[0].isUnitValid()
                      ? 'Select the measurement unit'
                      : null,
                ),
                mode: Mode.MENU,
                showSelectedItems: true,
                showSearchBox: false,
                items: Measurement.measurementUnits,
                onChanged: (String? value) =>
                    onMeasurementUnitChanged!(value ?? ''),
                selectedItem: foodItem.measurements[0].measurementUnit),
          ],
        ),
      ),
    );
  }
}
