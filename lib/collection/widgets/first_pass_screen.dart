import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/collection/collection.dart';

class FirstPassScreen extends StatelessWidget {
  const FirstPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, [bool mounted = true]) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Column(
          children: [
            const CollectionFinishedTile(),
            Visibility(
              visible: !state.gibsonsForm.finished,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text("New food"),
                        onPressed: () => context
                            .read<CollectionBloc>()
                            .add(FoodItemAdded())),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(2.0),
                  itemCount: state.gibsonsForm.foodItems.length,
                  itemBuilder: (context, index) {
                    return AbsorbPointer(
                      absorbing: state.gibsonsForm.finished,
                      child: FirstPassFoodItemCard(
                          foodItem: state.gibsonsForm.foodItems[index],
                          onNameChanged: (changedName) => context
                              .read<CollectionBloc>()
                              .add(FoodItemNameChanged(
                                  // TODO: change methods of FirstPassFoodItemCard
                                  // to return changed value and the foodItem
                                  // (or its uuid) that was passed to the widget
                                  // rather than to always have to pass
                                  // state.foodItems[index] to each method
                                  foodItemId:
                                      state.gibsonsForm.foodItems[index].id,
                                  foodItemName: changedName)),
                          onTimePeriodChanged: (changedTimePeriod) => context
                              .read<CollectionBloc>()
                              .add(FoodItemTimePeriodChanged(
                                  foodItemId:
                                      state.gibsonsForm.foodItems[index].id,
                                  foodItemTimePeriod: changedTimePeriod)),
                          onDeleted: () async {
                            final confirmed = (await showDialog<bool>(
                                useRootNavigator: false,
                                context: context,
                                builder: (BuildContext context) =>
                                    DeleteFoodItemDialog(
                                        foodItem: state
                                            .gibsonsForm.foodItems[index])));

                            if (mounted && (confirmed ?? false)) {
                              context.read<CollectionBloc>().add(
                                  FoodItemDeleted(
                                      foodItemId: state
                                          .gibsonsForm.foodItems[index].id));
                            }
                          }),
                    );
                  }),
            ),
          ],
        );
      },
    );
  }
}
