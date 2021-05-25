import 'package:flutter/material.dart';
import 'package:flutter_uikit/di/dependency_injection.dart';
import 'package:flutter_uikit/myapp.dart';

import 'package:flutter_uikit/database/icrisat_database.dart';

void main() {
  // initialise the DB
  IcrisatDB().initDB();

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Injector.configure(Flavor.MOCK);
  runApp(MyApp());
}
