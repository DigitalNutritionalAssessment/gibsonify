import 'package:flutter/material.dart';

import 'package:gibsonify/navigation/navigation.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gibsonify',
      theme: ThemeData(primarySwatch: Colors.teal),
      darkTheme: ThemeData.dark(), // TODO: add teal accents
      onGenerateRoute: PageRouter.route,
    );
  }
}
