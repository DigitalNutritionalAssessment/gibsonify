import 'package:flutter/material.dart';

import 'package:gibsonify_api/gibsonify_api.dart';

class DeleteFoodItemDialog extends StatelessWidget {
  final FoodItem foodItem;
  const DeleteFoodItemDialog({Key? key, required this.foodItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String foodItemDisplayName =
        isFieldUnmodifiedOrEmpty(foodItem.name) ? 'unnamed' : foodItem.name!;
    return AlertDialog(
      title: const Text('Delete food'),
      content: Text('Would you like to delete the $foodItemDisplayName food?'),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('No'),
        ),
      ],
    );
  }
}
