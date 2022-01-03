import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify_repository/gibsonify_repository.dart';

import 'package:gibsonify/navigation/navigation.dart';
import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/recipe/recipe.dart';

class App extends StatelessWidget {
  final GibsonifyRepository gibsonifyRepository;

  const App({Key? key, required this.gibsonifyRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: gibsonifyRepository,
      // TODO: Investigate moving Bloc Providers further down the widget tree
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              // TODO: Change CollectionBloc for HomeBloc
              create: (context) =>
                  CollectionBloc(gibsonifyRepository: gibsonifyRepository)),
          // TODO: Eventually delete RecipeBloc from here, move it to Recipes
          BlocProvider(create: (context) => RecipeBloc())
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
