import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/navigation/navigation.dart';

class FirstPassScreen extends StatelessWidget {
  const FirstPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('First Pass'),
              actions: [
                IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, PageRouter.firstPassHelp),
                    icon: const Icon(Icons.help))
              ],
            ),
            body: ListView.builder(
                padding: const EdgeInsets.all(2.0),
                itemCount: state.foodItems.length,
                itemBuilder: (context, index) {
                  return FirstPassFoodItemCard(
                      foodItem: state.foodItems[index],
                      onNameChanged: (changedName) => context
                          .read<CollectionBloc>()
                          .add(FoodItemNameChanged(
                              foodItem: state.foodItems[index],
                              foodItemName: changedName)),
                      onTimePeriodChanged: (changedTimePeriod) => context
                          .read<CollectionBloc>()
                          .add(FoodItemTimePeriodChanged(
                              foodItem: state.foodItems[index],
                              foodItemTimePeriod: changedTimePeriod)),
                      onDeleted: () => context.read<CollectionBloc>().add(
                          FoodItemDeleted(foodItem: state.foodItems[index])));
                }),
            floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                      child: const Icon(Icons.add),
                      onPressed: () =>
                          context.read<CollectionBloc>().add(FoodItemAdded()))
                ]));
      },
    );
  }
}
