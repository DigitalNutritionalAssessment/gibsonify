import 'package:flutter/material.dart';

import 'package:gibsonify/home/home.dart';
import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/recipe/recipe.dart';

class PageRouter {
  static const home = '/';
  static const collection = '/collection';
  static const recipe = '/recipe';
  static const sensitizationHelp = '/sensitizationhelp';

  static Route route(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return _buildRoute(const HomePage());
      case collection:
        return _buildRoute(const CollectionPage());
      case recipe:
        return _buildRoute(const RecipePage());
      case sensitizationHelp:
        return _buildRoute(const SensitizationHelpPage());
      default:
        throw Exception('Page does not exist!');
    }
  }

  static MaterialPageRoute _buildRoute(Widget page) {
    return MaterialPageRoute(builder: (context) => page);
  }
}
