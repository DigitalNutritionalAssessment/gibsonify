import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify_api/gibsonify_api.dart';

class ThirdPassFoodItemCard extends StatelessWidget {
  const ThirdPassFoodItemCard(
      {Key? key,
      required this.foodItem,
      this.onMeasurementMethodChangedOthersNulled,
      this.onMeasurementValueChanged,
      this.onMeasurementUnitChanged,
      this.onMeasurementAdded,
      this.onMeasurementDeleted})
      : super(key: key);

  final FoodItem foodItem;
  final ValueChanged<Map<String, dynamic>>?
      onMeasurementMethodChangedOthersNulled;
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
                          onMeasurementMethodChangedOthersNulled:
                              (measurementMethod) =>
                                  onMeasurementMethodChangedOthersNulled!({
                                    'index': index,
                                    'method': measurementMethod
                                  }),
                          onMeasurementUnitChanged: (measurementUnit) =>
                              onMeasurementUnitChanged!(
                                  {'index': index, 'unit': measurementUnit}),
                          onMeasurementValueChanged: (measurementValue) =>
                              onMeasurementValueChanged!({
                                'index': index,
                                'value': measurementValue
                              })));
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
