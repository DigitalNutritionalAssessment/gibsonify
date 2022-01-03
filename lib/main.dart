import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

import 'app.dart';

void main() async {
  // Initializing shared preferences before calling runApp needs the following:
  WidgetsFlutterBinding.ensureInitialized();

  final gibsonifyApi =
      GibsonifyApi(sharedPreferences: await SharedPreferences.getInstance());

  final gibsonifyRepository = GibsonifyRepository(gibsonifyApi: gibsonifyApi);

  runApp(App(gibsonifyRepository: gibsonifyRepository));
}
