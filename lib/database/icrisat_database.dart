import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

import 'package:flutter_uikit/model/consumption_data.dart';
import 'package:flutter_uikit/utils/form_strings.dart';
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
            id: row['recipe_code'].toString(),
            description: recipeName,
            recipeType: (row['recipe_type'] != null)? RecipeType.values.elementAt((row['recipe_type']??1)-1) :null,
          ),
          ingredientItems: [getIngredientFromDBMap(row)],
        );
      }
    }

    return outputMap;
  }

  Future<String> getNextModifiedRecipeID() async {
    
    // Get the current last id
    final List<Map<String, dynamic>> maps = await db.query( 'recipes' ,
                                      columns: ['recipe_code'],
                                      where: 'recipe_type = ?',
                                      whereArgs: [RecipeType.MODIFIED.index+1]
    );

    print(RecipeType.MODIFIED.index+1);

    List<String> recipeCodeList;
    try{
      recipeCodeList = List.generate(maps.length, (i) => maps[i]['recipe_code'].split('-').last);
    } on NoSuchMethodError{     // No such method error is thrown when the type is wrong
      recipeCodeList = List.generate(maps.length, (i) => maps[i]['recipe_code'].toString().split('-').last);
    }

    print(recipeCodeList);
    recipeCodeList.sort();

    // Create the next recipe ID
    String lastRecipeID = recipeCodeList.last;

//    String lastRecipeNumber = lastRecipeID.split('-').last;
//    List<String> splitIDs = previousReportId.split('_');

//    if (splitIDs.length < 2){         // I.e. if there is no current user id
//
//      splitIDs.insert(0, enumerator.employeeNumber?.toString() ?? "");
//    }

    Person enumerator = await Person.getEnumeratorFromSharedPrefs();

    lastRecipeID = (enumerator.employeeNumber?.toString()??"") + "-"+((int.tryParse(lastRecipeID)??0) + 1).toString();

    return lastRecipeID;
  }

  Future updateRecipes(FoodItem foodItem) async{
    
    // Delete all recipe items with the corresponding recipe ID
    await deleteRecipe(foodItem);
    
    // Insert recipe Item
    Map<String,dynamic> recipeItem = {
      'recipe_code' : foodItem.recipe.id,
      'recipe_descr' : foodItem.recipe.description,
      'recipe_type' : foodItem.recipe.recipeType.index + 1,
      'recipe_type_descr' : FormStrings.recipeTypeSelection[foodItem.recipe.recipeType],
    };

    Batch batch = db.batch();
    for (IngredientItem ingredientItem in foodItem.ingredientItems){
      var ingredientItemMap =getDBMapFromIngredient(ingredientItem);
      ingredientItemMap.addAll(recipeItem);
      batch.insert('recipes', ingredientItemMap);
    }
    await batch.commit(noResult: true);
  }

  Future deleteRecipe(FoodItem foodItem) async{
    // Delete all recipe items with the corresponding recipe ID
    await db.delete('recipes', where: 'recipe_code = ?', whereArgs: [foodItem.recipe.id]);

  }
  
  Map<String, dynamic> getDBMapFromIngredient(IngredientItem ingredientItem){
    return {
      'ingr_descr' :ingredientItem.foodItemName,
      'ingr_code' : ingredientItem.fctCode,
      'ingr_fraction_type' : ingredientItem.measurementUnit.index + 1,
      'ingr_fraction_type_descr' : FormStrings.measurementUnitSelection[ingredientItem.measurementUnit],
      'ingr_fraction' :ingredientItem.measurement.toString(),
      'r_code' :ingredientItem.rCode.toString(),
      'r_descr' :ingredientItem.rDescription,
    };
  }

  IngredientItem getIngredientFromDBMap(Map<String,dynamic> map){

    return IngredientItem(
      foodItemName: map['ingr_descr'],
      fctCode: (map['ingr_code']?.toInt()), //(double.tryParse(map['ingr_code']??"")?.toInt()) ?? 
      measurementUnit: (map['ingr_fraction_type']!=null) ? MeasurementUnitSelection.values.elementAt(map['ingr_fraction_type']-1):null,
      measurement: (map['ingr_fraction'].runtimeType != double) ? double.tryParse(map['ingr_fraction']) : map['ingr_fraction'],
//      rCode: int.tryParse(map['r_code']),
//      measurement: map['ingr_fraction'],
      rCode:(map['r_code'].runtimeType != int) ? int.tryParse(map['r_code']) : map['r_code'],
      rDescription: map['r_descr']
    );
  }

  Future<Map<String,int>> mapFoodDescriptionToRCode() async {
    // Query the table for all items.
    final List<Map<String, dynamic>> maps = await db.query(
        'RetentionFactors',
        columns: ['R_Code','R_Descr']
    );

    //Very Hacky, but this works for what we need ><
    List<int> idList = List.generate(maps.length, (i) => maps[i]['R_Code']);
    List<String> descrList = List.generate(maps.length, (i) => maps[i]['R_Descr']);

    return Map<String,int>.fromIterables( descrList, idList);
  }


}
