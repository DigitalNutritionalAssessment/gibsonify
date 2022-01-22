import 'package:flutter/material.dart';

import 'package:gibsonify/home/home.dart';
import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/recipe/recipe.dart';

class PageRouter {
  static const home = '/';
  static const collection = '/collection';
  static const recipe = '/recipe';
  static const recipeProbe = '/recipeprobe';
  static const ingredient = '/ingredient';
  static const editProbe = '/editprobe';
  static const sensitizationHelp = '/sensitizationhelp';
  static const firstPassHelp = '/firstpasshelp';
  static const secondPassHelp = '/secondpasshelp';
  static const thirdPassHelp = '/thirdpasshelp';
  static const chooseRecipe = '/chooserecipe';
  static const finishCollection = '/finishcollection';

  static Route route(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return _buildRoute(const HomePage());
      case collection:
        return _buildRoute(const CollectionPage());
      case recipe:
        var indices = routeSettings.arguments as List;
        int recipeIndex = indices[0];
        String? assignedFoodItemId = indices[1];
        return _buildRoute(RecipePage(
          recipeIndex,
          assignedFoodItemId: assignedFoodItemId,
        ));
      case recipeProbe:
        var recipeIndex = routeSettings.arguments as int;
        return _buildRoute(RecipeProbePage(recipeIndex));
      case ingredient:
        var indices = routeSettings.arguments as List; // TODO: Use a hash-map
        int recipeIndex = indices[0];
        int ingredientIndex = indices[1];
        return _buildRoute(IngredientPage(recipeIndex, ingredientIndex));
      case editProbe:
        var indices = routeSettings.arguments as List; // TODO: Use a hash-map
        int recipeIndex = indices[0];
        int probeIndex = indices[1];
        return _buildRoute(EditProbePage(recipeIndex, probeIndex));
      case sensitizationHelp:
        return _buildRoute(const SensitizationHelpPage());
      case firstPassHelp:
        return _buildRoute(const FirstPassHelpPage());
      case secondPassHelp:
        return _buildRoute(const SecondPassHelpPage());
      case thirdPassHelp:
        return _buildRoute(const ThirdPassHelpPage());
      case chooseRecipe:
        var assignedFoodItemId = routeSettings.arguments as String?;
        return _buildRoute(
            ChooseRecipePage(assignedFoodItemId: assignedFoodItemId));
      case finishCollection:
        return _buildRoute(const FinishCollectionPage());
      default:
        throw Exception('Page does not exist!');
    }
  }

  static MaterialPageRoute _buildRoute(Widget page) {
    return MaterialPageRoute(builder: (context) => page);
  }
}
