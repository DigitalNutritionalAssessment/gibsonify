import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
  // TODO: refactor to Map<String, dynamic> and name the arguments as keys
  final ValueChanged<List<dynamic>>? onMeasurementMethodChanged;
  final ValueChanged<List<dynamic>>? onMeasurementValueChanged;
  final ValueChanged<List<dynamic>>? onMeasurementUnitChanged;
  final VoidCallback? onMeasurementAdded;
  final ValueChanged<int>? onMeasurementDeleted;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(foodItem.name.value +
                ' consumed in the ' +
                foodItem.timePeriod.value),
            ListView.builder(
                // required to avoid Vertical viewport unbounded height error
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 8.0),
                itemCount: foodItem.measurements.length,
                itemBuilder: (context, index) {
                  // TODO: Try out a pop up button instead of Slidable
                  return Slidable(
                    key: Key(foodItem.measurements[index].id),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            if (foodItem.measurements.length > 1) {
                              onMeasurementDeleted!(index);
                              // TODO: implement deletion dialog
                              // showDialog<String>(
                              //     context: context,
                              //     builder: (BuildContext context) =>
                              //         DeleteFoodItemMeasurement(
                              //             foodItem: foodItem,
                              //             measurementIndex: index));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Each food must have at least one measurement')));
                            }
                          },
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        )
                      ],
                    ),
                    child: Card(
                      child: Column(
                        children: [
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
                                errorText: !foodItem.measurements[index]
                                        .isMethodValid()
                                    ? 'Enter a measurement method'
                                    : null,
                              ),
                              mode: Mode.MENU,
                              showSelectedItems: true,
                              showSearchBox: false,
                              items: Measurement.measurementMethods,
                              onChanged: (String? value) =>
                                  // TODO: create map
                                  onMeasurementMethodChanged!(
                                      [index, value ?? '']),
                              selectedItem: foodItem
                                  .measurements[index].measurementMethod),

                          TextFormField(
                            initialValue:
                                foodItem.measurements[index].measurementValue,
                            decoration: InputDecoration(
                              icon: const Icon(
                                  Icons.drive_file_rename_outline_rounded),
                              labelText: 'Measurement value',
                              helperText: 'The amount or number you measured',
                              errorText: !foodItem.measurements[index]
                                      .isValueValid()
                                  // TODO: the errorText should be displayed if nothing is typed
                                  // so investigate how this can be achieved with focusnodes
                                  ? 'Enter the measured value in 1 to 4 digits'
                                  : null,
                            ),
                            onChanged: (value) =>
                                onMeasurementValueChanged!([index, value]),
                            textInputAction: TextInputAction.next,
                          ),

                          DropdownSearch<String>(
                              dropdownSearchDecoration: InputDecoration(
                                icon: const Icon(
                                    Icons.radio_button_unchecked_outlined),
                                labelText: "Measurement unit",
                                helperText:
                                    'The size of each measurement value',
                                // TODO: the errorText should be displayed if nothing is chosen
                                // so investigate how this can be achieved with focusnodes or
                                // mayge send an empty string (although that would not work all
                                // the time)
                                errorText:
                                    !foodItem.measurements[index].isUnitValid()
                                        ? 'Select the measurement unit'
                                        : null,
                              ),
                              mode: Mode.MENU,
                              showSelectedItems: true,
                              showSearchBox: false,
                              items: Measurement.measurementUnits,
                              onChanged: (String? value) =>
                                  onMeasurementUnitChanged!(
                                      [index, value ?? '']),
                              selectedItem:
                                  foodItem.measurements[index].measurementUnit),
                        ],
                      ),
                    ),
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

// TODO: Implement pop up confirmation box
// class DeleteFoodItemeMeasurement extends StatelessWidget {
//   final FoodItem foodItem;
//   final int measurementIndex;

//   const DeleteFoodItemeMeasurement(
//       {Key? key, required this.foodItem, required this.measurementIndex})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
//       return AlertDialog(
//         title: const Text('Delete measurement'),
//         content: const Text('Would you like to delete the measurement?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, 'Cancel'),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => {
//               context.read<CollectionBloc>().add(RecipeMeasurementDeleted(
//                   recipe: recipe, measurementIndex: measurementIndex)),
//               Navigator.pop(context, 'OK'),
//             },
//             child: const Text('OK'),
//           ),
//         ],
//       );
//     });
//   }
// }
