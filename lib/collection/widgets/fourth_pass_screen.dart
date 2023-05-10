import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/collection/collection.dart';

class FourthPassScreen extends StatelessWidget {
  const FourthPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Column(children: [
          const CollectionFinishedTile(),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(2.0),
                itemCount: state.gibsonsForm.foodItems.length,
                itemBuilder: (context, index) {
                  return AbsorbPointer(
                    absorbing: state.gibsonsForm.finished,
                    child: FourthPassFoodItemCard(
                      foodItem: state.gibsonsForm.foodItems[index],
                      onConfirmationChanged: (negatedConfirmation) => context
                          .read<CollectionBloc>()
                          .add(FoodItemConfirmationChanged(
                              foodItemId: state.gibsonsForm.foodItems[index].id,
                              foodItemConfirmed: negatedConfirmation)),
                      onDeleted: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              DeleteFoodItemDialog(
                                  foodItem:
                                      state.gibsonsForm.foodItems[index])),
                      onSelectedScreenChanged: (screen) => context
                          .read<CollectionBloc>()
                          .add(ActiveStepChanged(
                              changedActiveStep: screen.index)),
                    ),
                  );
                }),
          ),
          // TODO: Do we really need a New food button here?
          // Visibility(
          //   visible: !state.gibsonsForm.finished,
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: ElevatedButton.icon(
          //             icon: const Icon(Icons.add),
          //             label: const Text("New Food"),
          //             onPressed: () {
          //               context.read<CollectionBloc>().add(FoodItemAdded());
          //               context.read<CollectionBloc>().add(
          //                   const SelectedScreenChanged(
          //                       changedSelectedScreen:
          //                           SelectedScreen.firstPass));
          //             }),
          //       ),
          //     ],
          //   ),
          // ),
        ]);
      },
    );
  }
}
