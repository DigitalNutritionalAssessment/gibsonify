import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/navigation/navigation.dart';

class SecondPassScreen extends StatelessWidget {
  const SecondPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Second Pass'),
            actions: [
              IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, PageRouter.secondPassHelp),
                  icon: const Icon(Icons.help))
            ],
          ),
          body: ListView.builder(
              padding: const EdgeInsets.all(2.0),
              itemCount: state.foodItems.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(state.foodItems[index].name.value +
                            ' consumed in ' +
                            state.foodItems[index].timePeriod.value),
                        // TODO: fix RenderFlex overflow
                        DropdownButtonFormField(
                          value: state.foodItems[index].source.value,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.kitchen),
                            labelText: 'Food source',
                            helperText: 'Where does the food come from',
                            errorText: state.foodItems[index].source.invalid
                                ? 'Select the food source'
                                : null,
                          ),
                          items: const [
                            // TODO: research how to handle empty string as
                            // the selected value other than a blank menu item
                            DropdownMenuItem(child: Text(''), value: ''),
                            DropdownMenuItem(
                                child: Text('Home made'), value: 'Home made'),
                            DropdownMenuItem(
                                child: Text('Purchased'), value: 'Purchased'),
                            DropdownMenuItem(
                                child: Text('Gift/given by neighbor'),
                                value: 'Gift/given by neighbor'),

                            DropdownMenuItem(
                                child: Text('Home garden/farm'),
                                value: 'Home garden/farm'),
                            DropdownMenuItem(
                                child: Text('Leftover'), value: 'Leftover'),
                            DropdownMenuItem(
                                child: Text('Wild food'), value: 'Wild food'),
                            DropdownMenuItem(
                                child: Text('Food aid'), value: 'Food aid'),
                            DropdownMenuItem(
                                child: Text('Other'), value: 'Other'),
                            DropdownMenuItem(
                                child: Text('Not applicable'),
                                value: 'Not applicable'),
                          ],
                          onChanged: (String? value) {
                            context
                                .read<CollectionBloc>()
                                .add(FoodItemSourceChanged(
                                    foodItem: state.foodItems[index],
                                    // TODO: Make a better null check
                                    foodItemSource: value ?? ''));
                          },
                        ),
                        TextFormField(
                          initialValue:
                              state.foodItems[index].description.value,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.info),
                            labelText: 'Food description',
                            helperText: 'Detailed dish description',
                            errorText:
                                state.foodItems[index].description.invalid
                                    ? 'Enter the dish description'
                                    : null,
                          ),
                          onChanged: (value) {
                            context.read<CollectionBloc>().add(
                                FoodItemDescriptionChanged(
                                    foodItem: state.foodItems[index],
                                    foodItemDescription: value));
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        DropdownButtonFormField(
                          value: state.foodItems[index].preparationMethod.value,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.coffee_maker_outlined),
                            labelText: 'Form when eaten',
                            helperText: 'The preparation method of the food',
                            errorText:
                                state.foodItems[index].preparationMethod.invalid
                                    ? 'Select the form'
                                    : null,
                          ),
                          items: const [
                            // TODO: research how to handle empty string as
                            // the selected value other than a blank menu item
                            DropdownMenuItem(child: Text(''), value: ''),
                            DropdownMenuItem(child: Text('Raw'), value: 'Raw'),
                            DropdownMenuItem(
                                child: Text('Boiled'), value: 'Boiled'),
                            DropdownMenuItem(
                                child:
                                    Text('Boiled in water but retained water'),
                                value: 'Boiled in water but retained water'),
                            DropdownMenuItem(
                                child:
                                    Text('Boiled in water but removed water'),
                                value: 'Boiled in water but removed water'),
                            DropdownMenuItem(
                                child: Text('Steamed'), value: 'Steamed'),
                            DropdownMenuItem(
                                child: Text('Roasted with oil'),
                                value: 'Roasted with oil'),
                            DropdownMenuItem(
                                child: Text('Roasted without oil'),
                                value: 'Roasted without oil'),
                            DropdownMenuItem(
                                child: Text('Fried'), value: 'Fried'),
                            DropdownMenuItem(
                                child: Text('Stir-fried'), value: 'Stir-fried'),
                            DropdownMenuItem(
                                child: Text('Soaking and stir-fried'),
                                value: 'Soaking and stir-fried'),
                            DropdownMenuItem(
                                child: Text('Boiled and fried'),
                                value: 'Boiled and fried'),
                            DropdownMenuItem(
                                child: Text('Boiled and stir-fried'),
                                value: 'Boiled and stir-fried'),
                            DropdownMenuItem(
                                child: Text('Steamed and fried'),
                                value: 'Steamed and fried'),
                            DropdownMenuItem(
                                child: Text('Roasted and boiled'),
                                value: 'Roasted and boiled'),
                            DropdownMenuItem(
                                child: Text('Other'), value: 'Other')
                          ],
                          onChanged: (String? value) {
                            context
                                .read<CollectionBloc>()
                                .add(FoodItemPreparationMethodChanged(
                                    foodItem: state.foodItems[index],
                                    // TODO: Make a better null check
                                    foodItemPreparationMethod: value ?? ''));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
