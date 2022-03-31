import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gibsonify/collection/collection.dart';

import 'package:gibsonify_api/gibsonify_api.dart';

class FourthPassFoodItemCard extends StatelessWidget {
  const FourthPassFoodItemCard(
      {Key? key,
      required this.foodItem,
      this.onConfirmationChanged,
      this.onDeleted,
      this.onSelectedScreenChanged})
      : super(key: key);

  final FoodItem foodItem;
  final ValueChanged<bool>? onConfirmationChanged;
  final VoidCallback? onDeleted;
  final ValueChanged<SelectedScreen>? onSelectedScreenChanged;

  @override
  Widget build(BuildContext context) {
    String foodItemDisplayName = isFieldUnmodifiedOrEmpty(foodItem.name)
        ? 'Unnamed food'
        : foodItem.name!;
    String foodItemDisplayTimePeriod =
        isFieldUnmodifiedOrEmpty(foodItem.timePeriod)
            ? 'unspecified period'
            : foodItem.timePeriod!;
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
        // TODO: change color in dark theme
        color: foodItem.confirmed
            ? Theme.of(context).colorScheme.background
            : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(foodItemDisplayName +
                  ' consumed in the ' +
                  foodItemDisplayTimePeriod),
              TextFormField(
                readOnly: true,
                // TODO add snackbar confirmation and scroll in the given page
                onTap: () =>
                    onSelectedScreenChanged!(SelectedScreen.secondPass),
                initialValue: foodItem.source,
                decoration: InputDecoration(
                  icon: const Icon(Icons.kitchen),
                  labelText: 'Food source',
                  helperText: 'Where does the food come from',
                  errorText: isFieldUnmodifiedOrEmpty(foodItem.source)
                      ? 'Select the food source'
                      : null,
                ),
              ),
              TextFormField(
                readOnly: true,
                onTap: () =>
                    onSelectedScreenChanged!(SelectedScreen.secondPass),
                initialValue: foodItem.description,
                decoration: InputDecoration(
                  icon: const Icon(Icons.info),
                  labelText: 'Food description',
                  helperText: 'Detailed dish description',
                  errorText: isFieldUnmodifiedOrEmpty(foodItem.description)
                      ? 'Enter the dish description'
                      : null,
                ),
              ),
              TextFormField(
                readOnly: true,
                onTap: () =>
                    onSelectedScreenChanged!(SelectedScreen.secondPass),
                initialValue: foodItem.preparationMethod,
                decoration: InputDecoration(
                  icon: const Icon(Icons.coffee_maker_outlined),
                  labelText: 'Form when eaten',
                  helperText: 'The preparation method of the food',
                  errorText:
                      isFieldUnmodifiedOrEmpty(foodItem.preparationMethod)
                          ? 'Select the food\'s preparation method'
                          : null,
                ),
              ),
              TextFormField(
                readOnly: true,
                onTap: () =>
                    onSelectedScreenChanged!(SelectedScreen.secondPass),
                initialValue: foodItem.recipe?.name ?? '',
                decoration: InputDecoration(
                  icon: const Icon(Icons.bookmark),
                  labelText: 'Food recipe',
                  helperText: 'What is the recipe of this food',
                  errorText: foodItem.recipe == null
                      ? 'Select the food\'s recipe'
                      : null,
                ),
              ),
              Column(
                children: [
                  ListView.builder(
                      // required to avoid Vertical viewport unbounded height error
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 8.0),
                      itemCount: foodItem.measurements.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: foodItem.confirmed
                              ? Theme.of(context).colorScheme.background
                              : null,
                          child: Column(
                            children: [
                              TextFormField(
                                readOnly: true,
                                onTap: () => onSelectedScreenChanged!(
                                    SelectedScreen.thirdPass),
                                initialValue: foodItem
                                    .measurements[index].measurementMethod,
                                decoration: InputDecoration(
                                  icon:
                                      const Icon(Icons.monitor_weight_outlined),
                                  labelText: 'Measurement method',
                                  helperText:
                                      'The method used to estimate food quantity',
                                  // TODO: refactor to something nicer
                                  errorText: !foodItem.measurements[index]
                                              .isMethodValid() ||
                                          foodItem.measurements[index]
                                                  .measurementMethod ==
                                              null
                                      ? 'Select the measurement method'
                                      : null,
                                ),
                              ),
                              TextFormField(
                                readOnly: true,
                                onTap: () => onSelectedScreenChanged!(
                                    SelectedScreen.thirdPass),
                                initialValue: foodItem
                                    .measurements[index].measurementUnit,
                                decoration: InputDecoration(
                                  icon: const Icon(
                                      Icons.radio_button_unchecked_outlined),
                                  labelText: 'Measurement unit',
                                  helperText:
                                      'The size of each measurement value',
                                  // TODO: refactor to something nicer
                                  errorText: !foodItem.measurements[index]
                                              .isUnitValid() ||
                                          foodItem.measurements[index]
                                                  .measurementUnit ==
                                              null
                                      ? 'Select the measurement unit'
                                      : null,
                                ),
                              ),
                              TextFormField(
                                readOnly: true,
                                onTap: () => onSelectedScreenChanged!(
                                    SelectedScreen.thirdPass),
                                initialValue: foodItem
                                    .measurements[index].measurementValue,
                                decoration: InputDecoration(
                                  icon: const Icon(
                                      Icons.drive_file_rename_outline_rounded),
                                  labelText: 'Measurement value',
                                  helperText:
                                      'The amount or number you measured',
                                  // TODO: refactor to something nicer
                                  errorText: !foodItem.measurements[index]
                                              .isValueValid() ||
                                          foodItem.measurements[index]
                                                  .measurementValue ==
                                              null
                                      ? 'Enter the measured value in 1 to 4 digits'
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                ],
              ),
              ListTile(
                  title: foodItem.confirmed
                      ? const Text('Unconfirm')
                      : const Text('Confirm'),
                  subtitle: Text(foodItemDisplayName),
                  leading: Checkbox(
                    value: foodItem.confirmed,
                    onChanged: (bool? value) =>
                        onConfirmationChanged!(!foodItem.confirmed),
                  ),
                  onTap: () => onConfirmationChanged!(!foodItem.confirmed)),
            ],
          ),
        ),
      ),
    );
  }
}
