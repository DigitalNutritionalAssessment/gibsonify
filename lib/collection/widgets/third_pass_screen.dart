import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/home/home.dart';
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
                leading: BackButton(
                  onPressed: () {
                    context
                        .read<CollectionBloc>()
                        .add(const GibsonsFormSaved());
                    context.read<HomeBloc>().add(const GibsonsFormsLoaded());
                    Navigator.maybePop(context);
                  },
                ),
                actions: [
                  IconButton(
                      onPressed: () => Navigator.pushNamed(
                          context, PageRouter.thirdPassHelp),
                      icon: const Icon(Icons.help))
                ]),
            body: ListView.builder(
                padding: const EdgeInsets.all(2.0),
                itemCount: state.gibsonsForm.foodItems.length,
                itemBuilder: (context, index) {
                  return ThirdPassFoodItemCard(
                      foodItem: state.gibsonsForm.foodItems[index],
                      onMeasurementMethodChanged: (changedMeasurementMethod) =>
                          context.read<CollectionBloc>().add(
                              FoodItemMeasurementMethodChanged(
                                  foodItem: state.gibsonsForm.foodItems[index],
                                  foodItemMeasurementMethod:
                                      changedMeasurementMethod)),
                      onMeasurementValueChanged: (changedMeasurementValue) =>
                          context.read<CollectionBloc>().add(
                              FoodItemMeasurementValueChanged(
                                  foodItem: state.gibsonsForm.foodItems[index],
                                  foodItemMeasurementValue:
                                      changedMeasurementValue)),
                      onMeasurementUnitChanged: (changedMeasurementUnit) =>
                          context.read<CollectionBloc>().add(
                              FoodItemMeasurementUnitChanged(
                                  foodItem: state.gibsonsForm.foodItems[index],
                                  foodItemMeasurementUnit:
                                      changedMeasurementUnit)));
                }));
      },
    );
  }
}
