import 'package:flutter/material.dart';

import 'package:gibsonify/home/home.dart';

class ChooseRecipePage extends StatelessWidget {
  final String? assignedFoodItemId;
  // TODO: this.assignedFoodItemId should probably be required argument
  const ChooseRecipePage({Key? key, this.assignedFoodItemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RecipesScreen(assignedFoodItemId: assignedFoodItemId),
    );
  }
}
