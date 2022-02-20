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
    return Slidable(
      key: Key(foodItem.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // TODO: implement deletion confirmation dialog
            onPressed: (context) => onDeleted!(),
            backgroundColor: const Color(0xFFFE4A49),
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
              Text(foodItem.name.value +
                  ' consumed in the ' +
                  foodItem.timePeriod.value),
              TextFormField(
                readOnly: true,
                // TODO add snackbar confirmation and scroll in the given page
                onTap: () =>
                    onSelectedScreenChanged!(SelectedScreen.secondPass),
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
                onTap: () =>
                    onSelectedScreenChanged!(SelectedScreen.secondPass),
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
                onTap: () =>
                    onSelectedScreenChanged!(SelectedScreen.secondPass),
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
                onTap: () =>
                    onSelectedScreenChanged!(SelectedScreen.secondPass),
                initialValue: foodItem.recipe?.recipeName ?? '',
                decoration: const InputDecoration(
                  icon: Icon(Icons.bookmark),
                  labelText: 'Food recipe',
                  helperText: 'What is the recipe of this food',
                  // TODO:
                  // errorText: foodItem.preparationMethod.invalid
                  //     ? 'Select the food\'s preparation method'
                  //     : null,
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
                                  errorText: !foodItem.measurements[index]
                                          .isMethodValid()
                                      ? 'Select the measurement method'
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
                                  errorText: !foodItem.measurements[index]
                                          .isValueValid()
                                      ? 'Enter the dish measurement'
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
                                  errorText: !foodItem.measurements[index]
                                          .isUnitValid()
                                      ? 'Select the measurement unit'
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                ],
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
