import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify_repository/gibsonify_repository.dart';

import 'package:gibsonify/navigation/navigation.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify/surveys/surveys.dart';
import 'package:gibsonify/login/login.dart';
import 'package:gibsonify/import_export/import_export.dart';
import 'package:gibsonify/sync/sync.dart';

class App extends StatelessWidget with WidgetsBindingObserver {
  final GibsonifyRepository gibsonifyRepository;
  final HiveRepository hiveRepository;
  final FCTRepository fctRepository;

  const App(
      {Key? key,
      required this.gibsonifyRepository,
      required this.hiveRepository,
      required this.fctRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GibsonifyRepository>(
            create: (context) => gibsonifyRepository),
        RepositoryProvider<HiveRepository>(create: (context) => hiveRepository),
        RepositoryProvider<FCTRepository>(create: (context) => fctRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  LoginBloc(gibsonifyRepository: gibsonifyRepository)
                    ..add(const LoginInfoLoaded())),
          BlocProvider(
              create: (context) => SurveysBloc(
                  hiveRepository: hiveRepository, fctRepository: fctRepository)
                ..add(const SurveysPageOpened())),
          BlocProvider(
              lazy: false,
              create: (context) => RecipeBloc(
                  gibsonifyRepository: gibsonifyRepository,
                  hiveRepository: hiveRepository)
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
