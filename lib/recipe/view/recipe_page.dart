import 'package:flutter/material.dart';

import 'package:gibsonify/recipe/recipe.dart';

class RecipePage extends StatefulWidget {
  final int recipeIndex;
  final String? assignedFoodItemId;
  final String? foodItemDescription;
  final int? selectedScreenIndex;

  const RecipePage(this.recipeIndex,
      {Key? key,
      this.assignedFoodItemId,
      this.foodItemDescription,
      this.selectedScreenIndex})
      : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  int selectedScreenIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedScreenIndex =
        (widget.selectedScreenIndex == null) ? 0 : widget.selectedScreenIndex!;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      RecipeProbesScreen(widget.recipeIndex,
          assignedFoodItemId: widget.assignedFoodItemId,
          foodItemDescription: widget.foodItemDescription),
      RecipeIngredientsScreen(widget.recipeIndex,
          assignedFoodItemId: widget.assignedFoodItemId),
      RecipeDetailsScreen(widget.recipeIndex,
          assignedFoodItemId: widget.assignedFoodItemId),
    ];
    return Scaffold(
      body: _screens[selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedScreenIndex,
        onTap: _onScreenSelected,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.live_help),
            label: 'Recipe Probes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Recipe Ingredients',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Recipe Details',
          )
        ],
      ),
    );
  }

  void _onScreenSelected(int index) {
    setState(() {
      selectedScreenIndex = index;
    });
  }
}
