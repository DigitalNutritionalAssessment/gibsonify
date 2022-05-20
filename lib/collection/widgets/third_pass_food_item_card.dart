import 'package:flutter/material.dart';
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gibsonify/collection/collection.dart';

import 'package:gibsonify_api/gibsonify_api.dart';

class ThirdPassFoodItemCard extends StatelessWidget {
  const ThirdPassFoodItemCard(
      {Key? key,
      required this.foodItem,
      this.onMeasurementMethodChanged,
      this.onMeasurementValueChanged,
      this.onMeasurementUnitChanged,
      this.onMeasurementAdded,
      this.onMeasurementDeleted})
      : super(key: key);

  final FoodItem foodItem;
  final ValueChanged<Map<String, dynamic>>? onMeasurementMethodChanged;
  final ValueChanged<Map<String, dynamic>>? onMeasurementUnitChanged;
  final ValueChanged<Map<String, dynamic>>? onMeasurementValueChanged;
  final VoidCallback? onMeasurementAdded;
  final ValueChanged<int>? onMeasurementDeleted;

  void _onMeasurementDeleted(BuildContext context, int index) {
    if (foodItem.measurements.length > 1) {
      onMeasurementDeleted!(index);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Each food must have at least one measurement')));
    }
  }

  @override
  Widget build(BuildContext context) {
    String foodItemDisplayName = isFieldUnmodifiedOrEmpty(foodItem.name)
        ? 'Unnamed food'
        : foodItem.name!;
    String foodItemDisplayTimePeriod =
        isFieldUnmodifiedOrEmpty(foodItem.timePeriod)
            ? 'unspecified period'
            : foodItem.timePeriod!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
                '$foodItemDisplayName consumed in the $foodItemDisplayTimePeriod'),
            ListView.builder(
                // required to avoid Vertical viewport unbounded height error
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 8.0),
                itemCount: foodItem.measurements.length,
                itemBuilder: (context, index) {
                  return Slidable(
                      key: Key(foodItem.measurements[index].id),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) =>
                                _onMeasurementDeleted(context, index),
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          )
                        ],
                      ),
                      child: MeasurementCard(
                          measurement: foodItem.measurements[index],
                          onMeasurementMethodChanged: (measurementMethod) =>
                              onMeasurementMethodChanged!({
                                'index': index,
                                'method': measurementMethod
                              }),
                          onMeasurementUnitChanged: (measurementUnit) =>
                              onMeasurementUnitChanged!(
                                  {'index': index, 'unit': measurementUnit}),
                          onMeasurementValueChanged: (measurementValue) =>
                              onMeasurementValueChanged!(
                                  {'index': index, 'value': measurementValue}))
                      //     Card(
                      //   child: Column(
                      //     children: [
                      //       DropdownSearch<String>(
                      //           key: UniqueKey(),
                      //           popupProps: const PopupProps.menu(
                      //               showSelectedItems: true,
                      //               fit: FlexFit.loose,
                      //               menuProps: MenuProps(
                      //                   constraints: BoxConstraints.tightFor())),
                      //           dropdownSearchDecoration: InputDecoration(
                      //             icon: const Icon(Icons.monitor_weight_outlined),
                      //             labelText: "Measurement method",
                      //             helperText: 'How the measurement is measured',
                      //             // TODO: the errorText should be displayed if nothing is chosen
                      //             // so investigate how this can be achieved with focusnodes or
                      //             // mayge send an empty string (although that would not work all
                      //             // the time)
                      //             errorText: !foodItem.measurements[index]
                      //                     .isMethodValid()
                      //                 ? 'Enter a measurement method'
                      //                 : null,
                      //           ),
                      //           items: Measurement.measurementMethods,
                      //           // TODO: clear measurement unit and value when
                      //           // measurement method is changed
                      //           onChanged: (String? measurementMethod) {
                      //             onMeasurementMethodChanged!({
                      //               'index': index,
                      //               'method': measurementMethod
                      //             });
                      //             // clear unit and value after method change
                      //             // onMeasurementUnitChanged!(
                      //             //     {'index': index, 'unit': ''});
                      //             // onMeasurementValueChanged!(
                      //             //     {'index': index, 'value': ''});
                      //           },
                      //           selectedItem: foodItem
                      //               .measurements[index].measurementMethod),
                      //       DropdownSearch<String>(
                      //           key: UniqueKey(),
                      //           // TODO: Make measurement unit read only if no measurement method is
                      //           // chosen, and display a snackbar saying to first choose method
                      //           popupProps: const PopupProps.menu(
                      //               showSelectedItems: true,
                      //               fit: FlexFit.loose,
                      //               menuProps: MenuProps(
                      //                   constraints: BoxConstraints.tightFor())),
                      //           dropdownSearchDecoration: InputDecoration(
                      //             icon: const Icon(
                      //                 Icons.radio_button_unchecked_outlined),
                      //             labelText: "Measurement unit",
                      //             helperText:
                      //                 'The size of each measurement value',
                      //             // TODO: the errorText should be displayed if nothing is chosen
                      //             // so investigate how this can be achieved with focusnodes or
                      //             // mayge send an empty string (although that would not work all
                      //             // the time)
                      //             errorText:
                      //                 !foodItem.measurements[index].isUnitValid()
                      //                     ? 'Select the measurement unit'
                      //                     : null,
                      //           ),
                      //           items: foodItem.measurements[index]
                      //               .getMeasurementUnitsForMethod()
                      //           // _getMeasurementUnitsForMethod(foodItem
                      //           //     .measurements[index].measurementMethod)
                      //           ,
                      //           onChanged: (String? measurementUnit) =>
                      //               onMeasurementUnitChanged!({
                      //                 'index': index,
                      //                 'unit': measurementUnit
                      //               }),
                      //           selectedItem:
                      //               foodItem.measurements[index].measurementUnit),
                      //       TextFormField(
                      //         // key: UniqueKey(),
                      //         initialValue:
                      //             foodItem.measurements[index].measurementValue,
                      //         decoration: InputDecoration(
                      //           icon: const Icon(
                      //               Icons.drive_file_rename_outline_rounded),
                      //           labelText: 'Measurement value or quantity',
                      //           helperText: 'The amount or number you measured',
                      //           errorText: !foodItem.measurements[index]
                      //                   .isValueValid()
                      //               // TODO: the errorText should be displayed if nothing is typed
                      //               // so investigate how this can be achieved with focusnodes
                      //               ? 'Enter the measured value in 1 to 4 digits'
                      //               : null,
                      //         ),
                      //         onChanged: (measurementValue) =>
                      //             onMeasurementValueChanged!({
                      //           'index': index,
                      //           'value': measurementValue
                      //         }),
                      //         textInputAction: TextInputAction.next,
                      //         keyboardType: TextInputType.number,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      );
                }),
            ListTile(
                title: const Text('Add measurement'),
                leading: const Icon(Icons.add),
                onTap: () => onMeasurementAdded!())
          ],
        ),
      ),
    );
  }
}
