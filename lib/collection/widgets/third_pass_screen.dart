import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/navigation/navigation.dart';

class ThirdPassScreen extends StatelessWidget {
  const ThirdPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Third Pass'),
              actions: [
                IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, PageRouter.thirdPassHelp),
                    icon: const Icon(Icons.help))
              ],
            ),
            body: ListView.builder(
                padding: const EdgeInsets.all(2.0),
                itemCount: state.foodItems.length,
                itemBuilder: (context, index) {
                  // TODO: refactor to more atomized widgets
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(state.foodItems[index].name.value +
                              ' consumed in the ' +
                              state.foodItems[index].timePeriod.value),
                          // TODO: fix RenderFlex overflow
                          DropdownButtonFormField(
                            value:
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
                            items: const [
                              // TODO: research how to handle empty string as
                              // the selected value other than a blank menu item
                              DropdownMenuItem(child: Text(''), value: ''),
                              DropdownMenuItem(
                                  child: Text('Direct weight'),
                                  value: 'Direct weight'),
                              DropdownMenuItem(
                                  child: Text('Volume of water'),
                                  value: 'Volume of water'),
                              DropdownMenuItem(
                                  child: Text('Volume of food'),
                                  value: 'Volume of food'),

                              DropdownMenuItem(
                                  child: Text('Play dough'),
                                  value: 'Play dough'),
                              DropdownMenuItem(
                                  child: Text('Number'), value: 'Number'),
                              DropdownMenuItem(
                                  child: Text('Size (photo)'),
                                  value: 'Size (photo)')
                            ],
                            onChanged: (String? value) {
                              context.read<CollectionBloc>().add(
                                  FoodItemMeasurementMethodChanged(
                                      foodItem: state.foodItems[index],
                                      foodItemMeasurementMethod: value ?? ''));
                            },
                          ),
                          TextFormField(
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
                            onChanged: (value) {
                              context.read<CollectionBloc>().add(
                                  FoodItemMeasurementValueChanged(
                                      foodItem: state.foodItems[index],
                                      foodItemMeasurementValue: value));
                            },
                            textInputAction: TextInputAction.next,
                          ),
                          DropdownButtonFormField(
                            value: state.foodItems[index].measurementUnit.value,
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
                            items: const [
                              // TODO: research how to handle empty string as
                              // the selected value other than a blank menu item
                              DropdownMenuItem(child: Text(''), value: ''),
                              DropdownMenuItem(
                                  child: Text('Small spoon'),
                                  value: 'Small spoon'),
                              DropdownMenuItem(
                                  child: Text('Big spoon'), value: 'Big spoon'),
                              DropdownMenuItem(
                                  child: Text('Standard cup'),
                                  value: 'Standard cup'),
                              DropdownMenuItem(
                                  child: Text('Small'), value: 'Small'),
                              DropdownMenuItem(
                                  child: Text('Medium'), value: 'Medium'),
                              DropdownMenuItem(
                                  child: Text('Large'), value: 'Large'),
                              DropdownMenuItem(
                                  child: Text('Grams or millilitres'),
                                  value: 'Grams or millilitres')
                            ],
                            onChanged: (String? value) {
                              context.read<CollectionBloc>().add(
                                  FoodItemMeasurementUnitChanged(
                                      foodItem: state.foodItems[index],
                                      foodItemMeasurementUnit: value ?? ''));
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }));
      },
    );
  }
}
