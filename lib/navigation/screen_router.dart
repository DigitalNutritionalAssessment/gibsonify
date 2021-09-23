import 'package:flutter/material.dart';

import 'package:gibsonify/screens/screens.dart';

class ScreenRouter {
  // TODO: Rewrite sensitization, firstPass, secondPass, thirdPass, fourthPass
  // to collection/each
  static const home = '/';
  static const newCollection = '/newcollection';
  static const newRecipe = '/newrecipe';
  // TODO: add help screens for each of these e.g. firstPassHelp
  static const firsPass = '/firstpass';
  static const secondPass = '/secondpass';
  static const thirdPass = '/thirdpass';
  static const fourthPass = '/fourthpass';

  static Route route(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return _buildRoute(const HomeScreen());
      // TODO:
      case newCollection:
        return _buildRoute(const NewCollectionScreen());
      case newRecipe:
        return _buildRoute(const NewRecipeScreen());
      // case firsPass:
      //   return _buildRoute(FirsPassScreen());
      // case secondPass:
      //   return _buildRoute(SecondPassScreen());
      // case thirdPass:
      //   return _buildRoute(ThirdPassScreen());
      // case fourthPass:
      //   return _buildRoute(FourthPassScreen());
      default:
        throw Exception('Screen does not exist!');
    }
  }

  static MaterialPageRoute _buildRoute(Widget screen) {
    return MaterialPageRoute(builder: (context) => screen);
  }
}
