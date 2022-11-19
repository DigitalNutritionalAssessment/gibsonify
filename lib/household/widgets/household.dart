import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/household/view/create_respondent.dart';
import 'package:gibsonify/household/view/edit_household.dart';
import 'package:gibsonify/household/view/view_respondent.dart';
import 'package:gibsonify/navigation/models/page_router.dart';
import 'package:gibsonify/household/bloc/household_bloc.dart';
import 'package:gibsonify/household/view/view_household.dart';
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
    case PageRouter.viewRespondent:
      final args = settings.arguments as Map<String, dynamic>;
      page = ViewRespondentPage(index: args['index']);
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
