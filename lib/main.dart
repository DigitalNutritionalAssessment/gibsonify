import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';

import 'app.dart';

void main() async {
  // Initializing shared preferences before calling runApp needs the following:
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  registerAdapters();

  Intl.systemLocale = await findSystemLocale();
  initializeDateFormatting(Intl.systemLocale, null);

  final gibsonifyApi =
      GibsonifyApi(sharedPreferences: await SharedPreferences.getInstance());

  final gibsonifyRepository = GibsonifyRepository(gibsonifyApi: gibsonifyApi);
  final hiveRepository = await HiveRepository.create();

  FlutterMapTileCaching.initialise(await RootDirectory.normalCache,
      settings: FMTCSettings(
          defaultTileProviderSettings: FMTCTileProviderSettings(
              cachedValidDuration: const Duration(days: 365))));
  final store = FMTC.instance('default');
  await store.manage.createAsync();

  runApp(App(
      gibsonifyRepository: gibsonifyRepository,
      hiveRepository: hiveRepository));
}
