import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify_api/gibsonify_api.dart';

class DeleteFoodItemDialog extends StatelessWidget {
  final FoodItem foodItem;
  const DeleteFoodItemDialog({Key? key, required this.foodItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String foodItemDisplayName =
        isFieldUnmodifiedOrEmpty(foodItem.name) ? 'unnamed' : foodItem.name!;
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Delete food'),
          content: Text('Would you like to delete the $foodItemDisplayName food?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context
                    .read<CollectionBloc>()
                    .add(FoodItemDeleted(foodItem: foodItem));
                Navigator.pop(context, 'Delete');
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
