import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify_repository/gibsonify_repository.dart';

import 'package:gibsonify/navigation/navigation.dart';
import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify/login/login.dart';
import 'package:gibsonify/import_export/import_export.dart';

class App extends StatelessWidget {
  final GibsonifyRepository gibsonifyRepository;
  final IsarRepository isarRepository;

  const App(
      {Key? key,
      required this.gibsonifyRepository,
      required this.isarRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GibsonifyRepository>(
            create: (context) => gibsonifyRepository),
        RepositoryProvider<IsarRepository>(create: (context) => isarRepository)
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  LoginBloc(gibsonifyRepository: gibsonifyRepository)
                    ..add(const LoginInfoLoaded())),
          // TODO: Refactor and move Collection and Recipe BlocProviders further
          // down the widget tree
          // Or another possibility is to get rid of HomeBloc and move its
          // functionality to CollectionBloc
          BlocProvider(
              create: (context) =>
                  CollectionBloc(gibsonifyRepository: gibsonifyRepository)),
          BlocProvider(
              lazy: false,
              create: (context) =>
                  RecipeBloc(gibsonifyRepository: gibsonifyRepository)
                    ..add(const RecipesLoaded())),
          BlocProvider(
              create: (context) =>
                  ImportExportBloc(gibsonifyRepository: gibsonifyRepository)),
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
