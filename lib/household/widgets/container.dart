import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/navigation/models/page_router.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

import 'package:gibsonify/household/household.dart';

class HouseholdContainer extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final int id;
  final String subRoute;

  HouseholdContainer({required this.id, required this.subRoute, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
            HouseholdBloc(isarRepository: context.read<IsarRepository>())
              ..add(HouseholdOpened(id: id)),
        child: WillPopScope(
          onWillPop: () async {
            if (_navigatorKey.currentState != null) {
              _navigatorKey.currentState!.maybePop();
              return false;
            }

            return true;
          },
          child: Navigator(
            key: _navigatorKey,
            initialRoute: subRoute,
            onGenerateRoute: _onGenerateRoute,
          ),
        ));
  }
}

Route _onGenerateRoute(RouteSettings settings) {
  late Widget page;

  switch (settings.name) {
    case PageRouter.viewHousehold:
      page = const ViewHouseholdPage();
      break;
    case PageRouter.editHousehold:
      page = const EditHouseholdPage();
      break;
    case PageRouter.createRespondent:
      page = const CreateRespondentPage();
      break;
    case PageRouter.viewRespondent:
      final args = settings.arguments as Map<String, dynamic>;
      page = ViewRespondentPage(index: args['index']);
      break;
    case PageRouter.editRespondent:
      page = const EditRespondentPage();
      break;
    case PageRouter.collection:
      page = const CollectionPage();
      break;
    case PageRouter.chooseRecipe:
      final args = settings.arguments as Map<String, dynamic>;
      page = ChooseRecipePage(
          assignedFoodItemId: args['assignedFoodItemId'],
          foodItemDescription: args['foodItemDescription']);
      break;
    case PageRouter.recipe:
      Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      page = RecipePage(
        args['recipeIndex'],
        viewedFromCollection: args['viewedFromCollection'],
        assignedFoodItemId: args['assignedFoodItemId'],
        foodItemDescription: args['foodItemDescription'],
        selectedScreen: args['selectedScreen'],
      );
      break;
    case PageRouter.ingredient:
      Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      page = IngredientPage(args['recipeIndex'], args['ingredientIndex']);
      break;
    case PageRouter.finishCollection:
      page = const FinishCollectionPage();
      break;
    case PageRouter.sensitizationHelp:
      page = const SensitizationHelpPage();
      break;
    case PageRouter.firstPassHelp:
      page = const FirstPassHelpPage();
      break;
    case PageRouter.secondPassHelp:
      page = const SecondPassHelpPage();
      break;
    case PageRouter.thirdPassHelp:
      page = const ThirdPassHelpPage();
      break;
    case PageRouter.createAnthropometrics:
      page = const CreateAnthropometricsPage();
      break;
    case PageRouter.viewAnthropometrics:
      final args = settings.arguments as Map<String, dynamic>;
      page = ViewAnthropometricsPage(index: args['index']);
      break;
    default:
      throw Exception('Invalid route: ${settings.name}');
  }

  return MaterialPageRoute(
    builder: (context) {
      return page;
    },
    settings: settings,
  );
}
