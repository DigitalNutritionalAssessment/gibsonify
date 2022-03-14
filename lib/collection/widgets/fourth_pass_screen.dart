import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/navigation/navigation.dart';

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
                itemCount: state.gibsonsForm.foodItems.length,
                itemBuilder: (context, index) {
                  return FourthPassFoodItemCard(
                    foodItem: state.gibsonsForm.foodItems[index],
                    onConfirmationChanged: (negatedConfirmation) => context
                        .read<CollectionBloc>()
                        .add(FoodItemConfirmationChanged(
                            foodItem: state.gibsonsForm.foodItems[index],
                            foodItemConfirmed: negatedConfirmation)),
                    onDeleted: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => DeleteFoodItemDialog(
                            foodItem: state.gibsonsForm.foodItems[index])),
                    onSelectedScreenChanged: (screen) => context
                        .read<CollectionBloc>()
                        .add(SelectedScreenChanged(
                            changedSelectedScreen: screen)),
                  );
                }),
            floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton.extended(
                      heroTag: null,
                      label: const Text("New Food"),
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        context.read<CollectionBloc>().add(FoodItemAdded());
                        context.read<CollectionBloc>().add(
                            const SelectedScreenChanged(
                                changedSelectedScreen:
                                    SelectedScreen.firstPass));
                        // TODO: Add a ScrollController to BLoC state,
                        // pass it to first pass screen ListView and
                        // scroll down in this onPressed call
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton.extended(
                      heroTag: null,
                      label: const Text("Finish Collection"),
                      icon: const Icon(Icons.check),
                      onPressed: () {
                        const confirmAllFoodItemsSnackBar = SnackBar(
                            content:
                                Text('Confirm all foods before finishing!'));
                        if (state.gibsonsForm.allFoodItemsConfirmed()) {
                          Navigator.pushNamed(
                              context, PageRouter.finishCollection);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(confirmAllFoodItemsSnackBar);
                        }
                      }),
                ]));
      },
    );
  }
}
