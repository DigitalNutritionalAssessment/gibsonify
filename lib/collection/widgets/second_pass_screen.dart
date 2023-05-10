import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/collection/collection.dart';

class SecondPassScreen extends StatelessWidget {
  const SecondPassScreen({Key? key}) : super(key: key);

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
                      child: SecondPassFoodItemCard(
                        // TODO: change arguments ordering to match UI
                        foodItem: state.gibsonsForm.foodItems[index],
                        onSourceChanged: (changedSource) => context
                            .read<CollectionBloc>()
                            .add(FoodItemSourceChanged(
                                foodItemId:
                                    state.gibsonsForm.foodItems[index].id,
                                foodItemSource: changedSource)),
                        onDescriptionChanged: (changedDescription) => context
                            .read<CollectionBloc>()
                            .add(FoodItemDescriptionChanged(
                                foodItemId:
                                    state.gibsonsForm.foodItems[index].id,
                                foodItemDescription: changedDescription)),
                        onPreparationMethodChanged:
                            (changedPreparationMethod) => context
                                .read<CollectionBloc>()
                                .add(FoodItemPreparationMethodChanged(
                                    foodItemId:
                                        state.gibsonsForm.foodItems[index].id,
                                    foodItemPreparationMethod:
                                        changedPreparationMethod)),
                        onCustomPreparationMethodChanged:
                            (changedCustomPreparationMethod) => context
                                .read<CollectionBloc>()
                                .add(FoodItemCustomPreparationMethodChanged(
                                    foodItemId:
                                        state.gibsonsForm.foodItems[index].id,
                                    foodItemCustomPreparationMethod:
                                        changedCustomPreparationMethod)),
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
