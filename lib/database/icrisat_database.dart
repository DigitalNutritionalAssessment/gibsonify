import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

import 'package:flutter_uikit/model/consumption_data.dart';


class IcrisatDB{

  IcrisatDB._privateConstructor();

  static final IcrisatDB _instance = IcrisatDB._privateConstructor();

  factory IcrisatDB(){
    return _instance;
  }

  Database db;

  Future initDB() async {

    String dbPath = join(await getDatabasesPath(), 'icrisat.db');
    bool exists = await databaseExists(dbPath);

    if (!exists){
      //Copy DB over
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(dbPath)).create(recursive: true);
      } catch (e) { print(e);}
      // Copy from asset
      ByteData data = await rootBundle.load(join("assets/database", "icrisat.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(dbPath).writeAsBytes(bytes, flush: true);

    } else {
      print("Opening existing database");
    }


    db =  await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      dbPath,
//      // When the database is first created, create a table to store dogs
//      onCreate: (db, version) {
//        print("Created db");
//        return db.execute(
//          "CREATE TABLE consumption_data_index(id TEXT PRIMARY KEY, name TEXT)",
//        );
//
//      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  Future<Map<String,int>> mapDescriptionToFCTCode() async {
    // Get a reference to the database

    // Query the table for all items.
    final List<Map<String, dynamic>> maps = await db.query(
        'Fct',
        columns: ['C_CODE','C_DESCR']
    );

    //Very Hacky, but this works for what we need ><
    List<int> idList = List.generate(maps.length, (i) => maps[i]['C_CODE']);
    List<String> descrList = List.generate(maps.length, (i) => maps[i]['C_DESCR']);

    return Map<String,int>.fromIterables( descrList, idList);
  }
}
