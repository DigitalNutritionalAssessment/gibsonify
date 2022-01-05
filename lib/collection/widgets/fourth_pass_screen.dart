import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/home/home.dart';
import 'package:gibsonify/collection/collection.dart';

class FourthPassScreen extends StatelessWidget {
  const FourthPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Fourth Pass'),
              leading: BackButton(
                onPressed: () {
                  context.read<CollectionBloc>().add(const GibsonsFormSaved());
                  context.read<HomeBloc>().add(const GibsonsFormsLoaded());
                  Navigator.maybePop(context);
                },
              ),
            ),
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
                              foodItemConfirmed: negatedConfirmation)));
                }),
            floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                      child: const Icon(Icons.save),
                      onPressed: () {
                        context.read<CollectionBloc>().add(GibsonsFormSaved());
                        context.read<HomeBloc>().add(GibsonsFormsLoaded());
                        Navigator.maybePop(context);
                      })
                ]));
      },
    );
  }
}
