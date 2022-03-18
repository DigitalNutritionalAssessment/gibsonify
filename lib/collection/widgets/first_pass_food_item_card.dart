import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:dropdown_search/dropdown_search.dart';

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
    const List<String> timePeriods = [
      'Morning (3:01 am - 12:00 pm)',
      'Afternoon (12:01 pm - 4:00 pm)',
      'Evening (4:01 pm - 7:00 pm)',
      'Night (7:01 pm - 3:00 am)'
    ];

    return Slidable(
      key: Key(foodItem.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onDeleted!(),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          )
        ],
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                  // A unique key needs to be set in order to properly
                  // rebuild this Field after deleting a FoodItem
                  key: Key(foodItem.id),
                  initialValue: foodItem.name,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.fastfood),
                      labelText: 'Food name',
                      helperText: 'Food name e.g. Dhal',
                      // TODO: refactor such that errorText is displayed even if
                      // the field is clicked on and then clicked away, now it
                      // only works if something is typed and deleted
                      errorText: isFieldModifiedAndEmpty(foodItem.name)
                          ? 'Enter a food name e.g. Banana'
                          : null),
                  onChanged: (value) => onNameChanged!(value),
                  textInputAction: TextInputAction.next),
              DropdownSearch<String>(
                  maxHeight: 225.0,
                  dropdownSearchDecoration: InputDecoration(
                      icon: const Icon(Icons.access_time),
                      labelText: 'Time period',
                      helperText:
                          'Time period of consuming the food e.g. Morning',
                      // TODO: the errorText should be displayed if nothing is chosen
                      // so investigate how this can be achieved with focusnodes or
                      // maybe send an empty string (although that would not work all
                      // the time), currently errorText is never displayed
                      errorText: isFieldModifiedAndEmpty(foodItem.timePeriod)
                          ? 'Select a time period'
                          : null),
                  mode: Mode.MENU,
                  showSelectedItems: true,
                  showSearchBox: false,
                  items: timePeriods,
                  onChanged: (String? timePeriod) =>
                      onTimePeriodChanged!(timePeriod ?? ''),
                  // TODO: the selected item has to be a nullable string for the
                  // dropdown field to display properly, fix this once we drop Formz
                  selectedItem: foodItem.timePeriod)
            ],
          ),
        ),
      ),
    );
  }
}
