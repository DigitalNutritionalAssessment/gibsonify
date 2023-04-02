import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';

void main() async {
  // Initializing shared preferences before calling runApp needs the following:
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  registerAdapters();

  final gibsonifyApi =
      GibsonifyApi(sharedPreferences: await SharedPreferences.getInstance());

  final gibsonifyRepository = GibsonifyRepository(gibsonifyApi: gibsonifyApi);
  final hiveRepository = await HiveRepository.create();

  runApp(App(
      gibsonifyRepository: gibsonifyRepository,
      hiveRepository: hiveRepository));
}
