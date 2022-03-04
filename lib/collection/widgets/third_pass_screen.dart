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
            appBar: AppBar(title: const Text('Third Pass'), actions: [
              IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, PageRouter.thirdPassHelp),
                  icon: const Icon(Icons.help))
            ]),
            body: ListView.builder(
                padding: const EdgeInsets.all(2.0),
                itemCount: state.gibsonsForm.foodItems.length,
                itemBuilder: (context, index) {
                  return ThirdPassFoodItemCard(
                    foodItem: state.gibsonsForm.foodItems[index],
                    onMeasurementMethodChanged:
                        (changedMeasurementIndexAndMethod) => context
                            .read<CollectionBloc>()
                            .add(FoodItemMeasurementMethodChanged(
                                foodItem: state.gibsonsForm.foodItems[index],
                                measurementIndex:
                                    changedMeasurementIndexAndMethod['index'],
                                foodItemMeasurementMethod:
                                    changedMeasurementIndexAndMethod[
                                        'method'])),
                    onMeasurementValueChanged:
                        (changedMeasurementIndexAndValue) => context
                            .read<CollectionBloc>()
                            .add(FoodItemMeasurementValueChanged(
                                foodItem: state.gibsonsForm.foodItems[index],
                                measurementIndex:
                                    changedMeasurementIndexAndValue['index'],
                                foodItemMeasurementValue:
                                    changedMeasurementIndexAndValue['value'])),
                    onMeasurementUnitChanged:
                        (changedMeasurementIndexAndUnit) => context
                            .read<CollectionBloc>()
                            .add(FoodItemMeasurementUnitChanged(
                                foodItem: state.gibsonsForm.foodItems[index],
                                measurementIndex:
                                    changedMeasurementIndexAndUnit['index'],
                                foodItemMeasurementUnit:
                                    changedMeasurementIndexAndUnit['unit'])),
                    onMeasurementAdded: () => context
                        .read<CollectionBloc>()
                        .add(FoodItemMeasurementAdded(
                            foodItem: state.gibsonsForm.foodItems[index])),
                    onMeasurementDeleted: (deletedMeasurementIndex) => context
                        .read<CollectionBloc>()
                        .add(FoodItemMeasurementDeleted(
                            foodItem: state.gibsonsForm.foodItems[index],
                            measurementIndex: deletedMeasurementIndex)),
                  );
                }));
      },
    );
  }
}
