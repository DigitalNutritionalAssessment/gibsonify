import 'package:flutter/material.dart';

import 'package:gibsonify/recipe/recipe.dart';

enum SelectedRecipeScreen {
  probeScreen,
  ingredientScreen,
  detailScreen,
}

class RecipePage extends StatefulWidget {
  final int recipeIndex;
  final String? assignedFoodItemId;
  final String? foodItemDescription;
  final SelectedRecipeScreen? selectedScreen;

  const RecipePage(this.recipeIndex,
      {Key? key,
      this.assignedFoodItemId,
      this.foodItemDescription,
      this.selectedScreen})
      : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  SelectedRecipeScreen selectedScreen = SelectedRecipeScreen.probeScreen;

  final Map<SelectedRecipeScreen, int> _selectedScreenIndices = {
    SelectedRecipeScreen.probeScreen: 0,
    SelectedRecipeScreen.ingredientScreen: 1,
    SelectedRecipeScreen.detailScreen: 2,
  };

  @override
  void initState() {
    super.initState();
    selectedScreen = (widget.selectedScreen == null)
        ? SelectedRecipeScreen.probeScreen
        : widget.selectedScreen!;
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
      body: _screens[selectedScreenIndex()],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedScreenIndex(),
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

  int selectedScreenIndex() {
    int? index = _selectedScreenIndices[selectedScreen];
    if (index == null) {
      throw const FormatException('Index of selected screen not found');
    } else {
      return index;
    }
  }

  void _onScreenSelected(int index) {
    var indicesToScreens = _selectedScreenIndices.map((k, v) => MapEntry(v, k));
    SelectedRecipeScreen? screen = indicesToScreens[index];
    if (screen == null) {
      throw const FormatException('Screen of selected index not found');
    } else {
      setState(() {
        selectedScreen = screen;
      });
    }
  }
}
