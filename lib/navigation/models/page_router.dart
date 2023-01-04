import 'package:flutter/material.dart';

import 'package:gibsonify/home/home.dart';
import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify/settings/settings.dart';
import 'package:gibsonify/login/login.dart';
import 'package:gibsonify/create_household/view/create_household.dart';
import 'package:gibsonify/household/household.dart';

class PageRouter {
  static const login = '/';
  static const home = '/home';
  static const recipe = '/recipe';
  static const ingredient = '/ingredient';
  static const editProbe = '/editprobe';
  static const collectionsHelp = '/collectionshelp';
  static const recipesHelp = '/recipeshelp';
  static const settingsHelp = '/settingshelp';
  static const createHousehold = 'createhousehold';

  static const householdPrefix = '/household';
  static const householdInitialRoute = '/household/$viewHousehold';
  static const viewHousehold = 'viewhousehold';
  static const editHousehold = 'edithousehold';
  static const createRespondent = 'createrespondent';
  static const viewRespondent = 'viewrespondent';
  static const editRespondent = 'editrespondent';
  static const collection = 'collection';
  static const sensitizationHelp = 'sensitizationhelp';
  static const firstPassHelp = 'firstpasshelp';
  static const secondPassHelp = 'secondpasshelp';
  static const thirdPassHelp = 'thirdpasshelp';
  static const finishCollection = 'finishcollection';
  static const chooseRecipe = 'chooserecipe';

  static Route route(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case login:
        return _buildRoute(const LoginPage());
      case home:
        return _buildRoute(const HomePage());
      case recipe:
        Map<String, dynamic> args =
            routeSettings.arguments as Map<String, dynamic>;
        return _buildRoute(RecipePage(
          args['recipeIndex'],
          viewedFromCollection: args['viewedFromCollection'],
          assignedFoodItemId: args['assignedFoodItemId'],
          foodItemDescription: args['foodItemDescription'],
          selectedScreen: args['selectedScreen'],
        ));
      case ingredient:
        Map<String, dynamic> args =
            routeSettings.arguments as Map<String, dynamic>;
        return _buildRoute(
            IngredientPage(args['recipeIndex'], args['ingredientIndex']));
      case editProbe:
        Map<String, dynamic> args =
            routeSettings.arguments as Map<String, dynamic>;
        return _buildRoute(ProbePage(args['recipeIndex'], args['probeIndex']));
      case collectionsHelp:
        return _buildRoute(const CollectionsHelpPage());
      case recipesHelp:
        return _buildRoute(const RecipesHelpPage());
      case settingsHelp:
        return _buildRoute(const SettingsHelpPage());
      case createHousehold:
        return _buildRoute(const CreateHouseholdPage());
      default:
        final route = routeSettings.name!;
        if (route.startsWith(householdPrefix)) {
          final subRoute = route.substring(householdPrefix.length);
          Map<String, dynamic> args =
              routeSettings.arguments as Map<String, dynamic>;
          return _buildRoute(
              HouseholdContainer(id: args['id'], subRoute: subRoute));
        } else {
          throw Exception('Page does not exist!');
        }
    }
  }

  static MaterialPageRoute _buildRoute(Widget page) {
    return MaterialPageRoute(builder: (context) => page);
  }
}
