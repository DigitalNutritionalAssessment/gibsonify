import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/create_respondent/view/create_respondent.dart';
import 'package:gibsonify/edit_household/view/edit_household.dart';
import 'package:gibsonify/navigation/models/page_router.dart';
import 'package:gibsonify/view_household/bloc/household_bloc.dart';
import 'package:gibsonify/view_household/view/household.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

class HouseholdContainer extends StatelessWidget {
  final int id;
  final String subRoute;

  const HouseholdContainer({required this.id, required this.subRoute, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
            HouseholdBloc(isarRepository: context.read<IsarRepository>())
              ..add(HouseholdOpened(id: id)),
        child: Navigator(
          initialRoute: subRoute,
          onGenerateRoute: _onGenerateRoute,
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
