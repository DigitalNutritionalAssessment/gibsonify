import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:gibsonify_api/gibsonify_api.dart';

class MeasurementCard extends StatelessWidget {
  const MeasurementCard(
      {Key? key,
      required this.measurement,
      required this.onMeasurementMethodChanged,
      required this.onMeasurementUnitChanged,
      required this.onMeasurementValueChanged})
      : super(key: key);

  final Measurement measurement;
  // TODO: make signatures accept String? to be able to clear values
  final ValueChanged<String>? onMeasurementMethodChanged;
  final ValueChanged<String>? onMeasurementUnitChanged;
  final ValueChanged<String>? onMeasurementValueChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          DropdownSearch<String>(
              key: UniqueKey(),
              popupProps: const PopupProps.menu(
                  showSelectedItems: true,
                  fit: FlexFit.loose,
                  menuProps: MenuProps(constraints: BoxConstraints.tightFor())),
              dropdownSearchDecoration: InputDecoration(
                icon: const Icon(Icons.monitor_weight_outlined),
                labelText: "Measurement method",
                helperText: 'How the measurement is measured',
                // TODO: the errorText should be displayed if nothing is chosen
                // so investigate how this can be achieved with focusnodes or
                // mayge send an empty string (although that would not work all
                // the time)
                errorText: !measurement.isMethodValid()
                    ? 'Enter a measurement method'
                    : null,
              ),
              items: Measurement.measurementMethods,
              // TODO: clear measurement unit and value when
              // measurement method is changed
              onChanged: (String? measurementMethod) {
                // TODO: make signature accept null to be able to clear values
                onMeasurementMethodChanged!(measurementMethod ?? '');
                // clear unit and value after method change
                // onMeasurementUnitChanged!(
                //     {'index': index, 'unit': ''});
                // onMeasurementValueChanged!(
                //     {'index': index, 'value': ''});
              },
              selectedItem: measurement.measurementMethod),
          DropdownSearch<String>(
              key: UniqueKey(),
              // TODO: Make measurement unit read only if no measurement method is
              // chosen, and display a snackbar saying to first choose method
              popupProps: const PopupProps.menu(
                  showSelectedItems: true,
                  fit: FlexFit.loose,
                  menuProps: MenuProps(constraints: BoxConstraints.tightFor())),
              dropdownSearchDecoration: InputDecoration(
                icon: const Icon(Icons.radio_button_unchecked_outlined),
                labelText: "Measurement unit",
                helperText: 'The size of each measurement value',
                // TODO: the errorText should be displayed if nothing is chosen
                // so investigate how this can be achieved with focusnodes or
                // mayge send an empty string (although that would not work all
                // the time)
                errorText: !measurement.isUnitValid()
                    ? 'Select the measurement unit'
                    : null,
              ),
              items: measurement.getMeasurementUnitsForMethod(),
              onChanged: (String? measurementUnit) =>
                  onMeasurementUnitChanged!(measurementUnit ?? ''),
              selectedItem: measurement.measurementUnit),
          TextFormField(
            // this cannot be UniqueKey as keyboard hides after each press
            // key: UniqueKey(),
            initialValue: measurement.measurementValue,
            decoration: InputDecoration(
              icon: const Icon(Icons.drive_file_rename_outline_rounded),
              labelText: 'Measurement value or quantity',
              helperText: 'The amount or number you measured',
              errorText: !measurement.isValueValid()
                  // TODO: the errorText should be displayed if nothing is typed
                  // so investigate how this can be achieved with focusnodes
                  ? 'Enter the measured value in 1 to 4 digits'
                  : null,
            ),
            onChanged: (measurementValue) =>
                onMeasurementValueChanged!(measurementValue),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
