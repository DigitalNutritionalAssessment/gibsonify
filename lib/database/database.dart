import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'package:flutter_uikit/model/consumption_data.dart';

class LocalOverallDatabase {
  Future<Database> database() async {
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      // join(await getDatabasesPath(), 'overall_storage.db'),
      '/Documents/overall_storage.db',
      // When the database is first created, create a table to store dogs
      onCreate: (db, version) {
        print("Created db");
        return db.execute(
          "CREATE TABLE consumption_data_index(id TEXT PRIMARY KEY, name TEXT)",
        );

      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  Future<void> insertConsumptionDataItem(
      ConsumptionData consumptionData) async {
    // Get a reference to the database
    final Database db = await database();

    // Insert the Dog into the correct table. We will also specify the
    // `conflictAlgorithm` to use in this case. If the same dog is inserted
    // multiple times, it will replace the previous data.
    await db.insert(
        'consumption_data_index', consumptionData.toCondensedDBMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
        print("insert Item");
  }

  Future<List<String>> getAllConsumptionDataIds() async {
    // Get a reference to the database
    final Database db = await database();

    // Query the table for All The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(
        'consumption_data_index');

    print(maps);
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return maps[i]['id'];
    });
  }

  Future<bool> idExists(String id) async{
    // Get a reference to the database
    final db = await database();

    List<Map> result = await db.query(
      'consumption_data_index',
      columns: ['id'],
      where: "id = ?",
      whereArgs: [id],
    );

    return result.isNotEmpty;
  }

  Future<void> updateConsumptionDataItem(
      ConsumptionData consumptionData) async {
    // Get a reference to the database
    final db = await database();

    // Update the given ConsumptionData
    await db.update(
      'consumption_data_index',
      consumptionData.toCondensedDBMap(),
      // Ensure we only update the Dog with a matching id
      where: "id = ?",
      // Pass the Dog's id through as a whereArg to prevent SQL injection
      whereArgs: [consumptionData.id],
    );
  }

  Future<void> deleteConsumptionDataItem(String id) async {
    // Get a reference to the database
    final db = await database();

    // Remove the Dog from the Database
    await db.delete(
      'consumption_data_index',
      // Use a `where` clause to delete a specific dog
      where: "id = ?",
      // Pass the Dog's id through as a whereArg to prevent SQL injection
      whereArgs: [id],
    );
  }
}