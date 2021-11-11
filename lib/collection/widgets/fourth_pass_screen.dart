import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/collection/collection.dart';

class FourthPassScreen extends StatelessWidget {
  const FourthPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(title: const Text('Fourth Pass')),
            body: ListView.builder(
                padding: const EdgeInsets.all(2.0),
                itemCount: state.foodItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    // TODO: change color in dark theme
                    color: state.foodItems[index].confirmed
                        ? Theme.of(context).colorScheme.background
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(state.foodItems[index].name.value +
                              ' consumed in the ' +
                              state.foodItems[index].timePeriod.value),
                          TextFormField(
                            readOnly: true,
                            initialValue: state.foodItems[index].source.value,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.kitchen),
                              labelText: 'Food source',
                              helperText: 'Where does the food come from',
                              errorText: state.foodItems[index].source.invalid
                                  ? 'Select the food source'
                                  : null,
                            ),
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue:
                                state.foodItems[index].description.value,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.info),
                              labelText: 'Food description',
                              helperText: 'Detailed dish description',
                              errorText:
                                  state.foodItems[index].description.invalid
                                      ? 'Enter the dish description'
                                      : null,
                            ),
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue:
                                state.foodItems[index].preparationMethod.value,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.coffee_maker_outlined),
                              labelText: 'Form when eaten',
                              helperText: 'The preparation method of the food',
                              errorText: state.foodItems[index]
                                      .preparationMethod.invalid
                                  ? 'Select the food\'s preparation method'
                                  : null,
                            ),
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue:
                                state.foodItems[index].measurementMethod.value,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.monitor_weight_outlined),
                              labelText: 'Measurement method',
                              helperText:
                                  'The method used to estimate food quantity',
                              errorText: state.foodItems[index]
                                      .measurementMethod.invalid
                                  ? 'Select the measurement method'
                                  : null,
                            ),
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue:
                                state.foodItems[index].measurementValue.value,
                            decoration: InputDecoration(
                              icon: const Icon(
                                  Icons.drive_file_rename_outline_rounded),
                              labelText: 'Measurement value',
                              helperText: 'The amount or number you measured',
                              errorText: state
                                      .foodItems[index].measurementValue.invalid
                                  ? 'Enter the dish measurement'
                                  : null,
                            ),
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue:
                                state.foodItems[index].measurementUnit.value,
                            decoration: InputDecoration(
                              icon: const Icon(
                                  Icons.radio_button_unchecked_outlined),
                              labelText: 'Measurement unit',
                              helperText: 'The size of each measurement value',
                              errorText:
                                  state.foodItems[index].measurementUnit.invalid
                                      ? 'Select the measurement unit'
                                      : null,
                            ),
                          ),
                          const Divider(),
                          TextButton(
                              // TODO: set style property to be
                              // opposite color of Card
                              // TODO: make each fooditem change from confirmed
                              // to unconfirmed if some field of it changes
                              onPressed: () {
                                var confirmedNegation =
                                    !state.foodItems[index].confirmed;
                                context.read<CollectionBloc>().add(
                                    FoodItemConfirmationChanged(
                                        foodItem: state.foodItems[index],
                                        foodItemConfirmed: confirmedNegation));
                              },
                              child: state.foodItems[index].confirmed
                                  ? const Text('Unconfirm')
                                  : const Text('Confirm'))
                        ],
                      ),
                    ),
                  );
                }));
      },
    );
  }
}
