import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

import 'package:flutter_uikit/model/consumption_data.dart';
import 'package:flutter_uikit/model/food_item.dart';


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

  Future<Map<String,FoodItem>> getRecipeInformation() async {
    // Query the table for all items.
    final List<Map<String, dynamic>> maps = await db.query( 'recipes' );

    Map<String, FoodItem> outputMap = new Map<String, FoodItem>();

    for (Map<String,dynamic> row in maps)
    {
      String recipeName = row['recipe_descr'];

      // If there is already a recipe with the same name, append it to the
      // ingredientItems List
      if (outputMap.containsKey(recipeName)){
        outputMap[recipeName].ingredientItems.add(getIngredientFromDBMap(row));
      }
      else{
        outputMap[recipeName] = FoodItem(
          foodName: recipeName,
          recipe: Recipe(
            id: row['recipe_code'],
            description: recipeName,
            recipeType: (row['recipeType'] != null)? RecipeType.values.elementAt(row['recipeType']) :null,
          ),
          ingredientItems: [getIngredientFromDBMap(row)],
        );
      }
    }

    return outputMap;



  }

  IngredientItem getIngredientFromDBMap(Map<String,dynamic> map){
    return IngredientItem(
      foodItemName: map['ingr_descr'],
      fctCode: map['ingr_code'],
      measurementUnit: (map['ingr_fraction_type']!=null) ? MeasurementUnitSelection.values.elementAt(map['ingr_fraction_type']-1):null,
      measurement: map['ingr_fraction'],
    );
  }


}
