import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/navigation/navigation.dart';
import 'package:gibsonify_api/gibsonify_api.dart';

class ThirdPassScreen extends StatelessWidget {
  const ThirdPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Column(
          children: [
            const CollectionFinishedTile(),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(2.0),
                  itemCount: state.gibsonsForm.foodItems.length,
                  itemBuilder: (context, index) {
                    return AbsorbPointer(
                      absorbing: state.gibsonsForm.finished,
                      child: ThirdPassFoodItemCard(
                        foodItem: state.gibsonsForm.foodItems[index],
                        onMeasurementMethodChangedOthersNulled:
                            (changedMeasurementIndexAndMethod) => context
                                .read<CollectionBloc>()
                                .add(
                                    FoodItemMeasurementMethodChangedOthersNulled(
                                        foodItemId: state
                                            .gibsonsForm.foodItems[index].id,
                                        measurementIndex:
                                            changedMeasurementIndexAndMethod[
                                                'index'],
                                        measurementMethod:
                                            changedMeasurementIndexAndMethod[
                                                'method'])),
                        onMeasurementUnitChanged:
                            (changedMeasurementIndexAndUnit) => context
                                .read<CollectionBloc>()
                                .add(FoodItemMeasurementUnitChanged(
                                    foodItemId:
                                        state.gibsonsForm.foodItems[index].id,
                                    measurementIndex:
                                        changedMeasurementIndexAndUnit['index'],
                                    measurementUnit:
                                        changedMeasurementIndexAndUnit[
                                            'unit'])),
                        onMeasurementValueChanged:
                            (changedMeasurementIndexAndValue) => context
                                .read<CollectionBloc>()
                                .add(FoodItemMeasurementValueChanged(
                                    foodItemId:
                                        state.gibsonsForm.foodItems[index].id,
                                    measurementIndex:
                                        changedMeasurementIndexAndValue[
                                            'index'],
                                    measurementValue:
                                        changedMeasurementIndexAndValue[
                                            'value'])),
                        onMeasurementAdded: () => context
                            .read<CollectionBloc>()
                            .add(FoodItemMeasurementAdded(
                                foodItemId:
                                    state.gibsonsForm.foodItems[index].id)),
                        onMeasurementDeleted: (deletedMeasurementIndex) =>
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    DeleteFoodItemMeasurementDialog(
                                      foodItem:
                                          state.gibsonsForm.foodItems[index],
                                      measurementIndex: deletedMeasurementIndex,
                                    )),
                      ),
                    );
                  }),
            ),
          ],
        );
      },
    );
  }
}

class DeleteFoodItemMeasurementDialog extends StatelessWidget {
  final FoodItem foodItem;
  final int measurementIndex;
  const DeleteFoodItemMeasurementDialog(
      {Key? key, required this.foodItem, required this.measurementIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Delete measurement'),
          content: const Text('Would you like to delete the measurement?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<CollectionBloc>().add(FoodItemMeasurementDeleted(
                    measurementIndex: measurementIndex,
                    foodItemId: foodItem.id));
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
