import 'dart:convert';

import 'package:gibsonify_api/gibsonify_api.dart';

import 'package:flutter/services.dart' show rootBundle;

class _IFCT2017File {
  final Map<String, FCTFoodGroup> groups;
  final Map<String, FCTFoodItem> compositions;

  _IFCT2017File(this.groups, this.compositions);

  factory _IFCT2017File.fromJson(Map<String, dynamic> json) {
    final groups = json['groups'] as Map<String, dynamic>;
    final compositions = json['compositions'] as Map<String, dynamic>;
    return _IFCT2017File(
      groups.map((key, value) => MapEntry(key, FCTFoodGroup.fromJson(value))),
      compositions
          .map((key, value) => MapEntry(key, FCTFoodItem.fromJson(value))),
    );
  }
}

class IFCT2017 implements FoodCompositionTable {
  @override
  final String id = 'ifct2017';
  @override
  final String name = 'Indian Food Composition Tables (2017)';

  late Map<String, FCTFoodItem> foodItems;
  late Map<String, FCTFoodGroup> foodGroups;

  @override
  Future<void> init() async {
    final data = await rootBundle.loadString('assets/fct/ifct2017/fct.json');
    final contents = _IFCT2017File.fromJson(jsonDecode(data));
    foodGroups = contents.groups;
    foodItems = contents.compositions;
  }

  @override
  Future<Map<String, FCTFoodGroup>> getFoodGroups() async {
    return foodGroups;
  }

  @override
  Future<FCTFoodItem?> getFoodItem(String id) async {
    return foodItems[id];
  }

  @override
  Future<Iterable<FCTFoodItem>> search(String query) async {
    final sanitised = query.toLowerCase();
    return foodItems.values.where((foodItem) =>
        foodItem.name.toLowerCase().contains(sanitised) ||
        foodItem.alternateNames
            .any((name) => name.toLowerCase().contains(query)));
  }
}
