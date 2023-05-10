import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify_repository/gibsonify_repository.dart';

import 'package:gibsonify/navigation/navigation.dart';
import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify/surveys/surveys.dart';
import 'package:gibsonify/login/login.dart';
import 'package:gibsonify/import_export/import_export.dart';
import 'package:gibsonify/sync/sync.dart';

class App extends StatelessWidget with WidgetsBindingObserver {
  final GibsonifyRepository gibsonifyRepository;
  final HiveRepository hiveRepository;

  const App(
      {Key? key,
      required this.gibsonifyRepository,
      required this.hiveRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GibsonifyRepository>(
            create: (context) => gibsonifyRepository),
        RepositoryProvider<HiveRepository>(create: (context) => hiveRepository)
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  LoginBloc(gibsonifyRepository: gibsonifyRepository)
                    ..add(const LoginInfoLoaded())),
          BlocProvider(
              create: (context) => SurveysBloc(hiveRepository: hiveRepository)
                ..add(const SurveysPageOpened())),
          // TODO: Refactor and move Collection and Recipe BlocProviders further
          // down the widget tree
          BlocProvider(create: (context) => CollectionBloc()),
          BlocProvider(
              lazy: false,
              create: (context) =>
                  RecipeBloc(gibsonifyRepository: gibsonifyRepository)
                    ..add(const RecipesLoaded())),
          BlocProvider(
              create: (context) => ImportExportBloc(
                  gibsonifyRepository: gibsonifyRepository,
                  hiveRepository: hiveRepository)),
          BlocProvider(create: (context) => SyncBloc()),
        ],
        child: MaterialApp(
          title: 'Gibsonify',
          theme: ThemeData(primarySwatch: Colors.teal),
          darkTheme: ThemeData.dark(), // TODO: add teal accents
          onGenerateRoute: PageRouter.route,
        ),
      ),
    );
  }
}
