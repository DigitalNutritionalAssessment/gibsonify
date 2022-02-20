import 'package:flutter/material.dart';

import 'package:gibsonify/home/home.dart';
import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/recipe/recipe.dart';

class PageRouter {
  static const home = '/';
  static const collection = '/collection';
  static const recipe = '/recipe';
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
        Map<String, dynamic> args =
            routeSettings.arguments as Map<String, dynamic>;
        return _buildRoute(RecipePage(
          args['recipeIndex'],
          assignedFoodItemId: args['assignedFoodItemId'],
          foodItemDescription: args['foodItemDescription'],
          selectedScreenIndex: args['selectedScreenIndex'],
        ));
      case ingredient:
        Map<String, dynamic> args =
            routeSettings.arguments as Map<String, dynamic>;
        return _buildRoute(
            IngredientPage(args['recipeIndex'], args['ingredientIndex']));
      case editProbe:
        Map<String, dynamic> args =
            routeSettings.arguments as Map<String, dynamic>;
        return _buildRoute(
            EditProbePage(args['recipeIndex'], args['probeIndex']));
      case sensitizationHelp:
        return _buildRoute(const SensitizationHelpPage());
      case firstPassHelp:
        return _buildRoute(const FirstPassHelpPage());
      case secondPassHelp:
        return _buildRoute(const SecondPassHelpPage());
      case thirdPassHelp:
        return _buildRoute(const ThirdPassHelpPage());
      case chooseRecipe:
        Map<String, dynamic> args =
            routeSettings.arguments as Map<String, dynamic>;
        return _buildRoute(ChooseRecipePage(
            assignedFoodItemId: args['assignedFoodItemId'],
            foodItemDescription: args['foodItemDescription']));
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
