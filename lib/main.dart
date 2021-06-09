import 'package:flutter/material.dart';
import 'package:flutter_uikit/di/dependency_injection.dart';
import 'package:flutter_uikit/myapp.dart';
import 'package:flutter_uikit/database/icrisat_database.dart';

//This is the entry point of the program, and the file name must stay as main.dart
//can only have one main function in the program

void main() {
  // initialise the DB
  IcrisatDB().initDB();

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Injector.configure(Flavor.MOCK);
  runApp(MyApp());
}