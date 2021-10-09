import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/navigation/navigation.dart';
import 'package:gibsonify/collection/collection.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CollectionBloc(),
      child: MaterialApp(
        title: 'Gibsonify',
        theme: ThemeData(primarySwatch: Colors.teal),
        darkTheme: ThemeData.dark(), // TODO: add teal accents
        onGenerateRoute: PageRouter.route,
      ),
    );
  }
}
