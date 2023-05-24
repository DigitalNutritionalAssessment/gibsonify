// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'fct.g.dart';

@JsonSerializable()
class FCTNutrition {
  final double? energy_kj;
  final double? carbohydrate_g;
  final double? protein_g;
  final double? fat_g;
  final double? fibre_g;
  final double? moisture_g;
  final double? ash_g;
  final double? vit_a_g;
  final double? vit_b1_g;
  final double? vit_b2_g;
  final double? vit_b3_g;
  final double? vit_b5_g;
  final double? vit_b6_g;
  final double? vit_b7_g;
  final double? vit_b9_g;
  final double? vit_c_g;
  final double? vit_d2_g;
  final double? vit_e_g;
  final double? vit_k1_g;
  final double? vit_k2_g;

  const FCTNutrition({
    this.energy_kj,
    this.carbohydrate_g,
    this.protein_g,
    this.fat_g,
    this.fibre_g,
    this.moisture_g,
    this.ash_g,
    this.vit_a_g,
    this.vit_b1_g,
    this.vit_b2_g,
    this.vit_b3_g,
    this.vit_b5_g,
    this.vit_b6_g,
    this.vit_b7_g,
    this.vit_b9_g,
    this.vit_c_g,
    this.vit_d2_g,
    this.vit_e_g,
    this.vit_k1_g,
    this.vit_k2_g,
  });

  factory FCTNutrition.fromJson(Map<String, dynamic> json) =>
      _$FCTNutritionFromJson(json);

  Map<String, dynamic> toJson() => _$FCTNutritionToJson(this);
}

@JsonSerializable()
class FCTFoodItem {
  final String id;
  final String name;
  final String scientificName;
  final List<String> alternateNames;
  final String foodGroupId;
  final int ddsGroupId;
  final String? photoUrl;
  final FCTNutrition nutrition;

  const FCTFoodItem({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.alternateNames,
    required this.foodGroupId,
    required this.ddsGroupId,
    this.photoUrl,
    required this.nutrition,
  });

  // List<String> matchingAlternateNames(String query) {
  //   final queryLower = query.toLowerCase();
  //   return alternateNames
  //       .where((name) => name.toLowerCase().contains(queryLower))
  //       .toList();
  // }

  factory FCTFoodItem.fromJson(Map<String, dynamic> json) =>
      _$FCTFoodItemFromJson(json);

  Map<String, dynamic> toJson() => _$FCTFoodItemToJson(this);
}

@JsonSerializable()
class FCTFoodGroup {
  final String id;
  final String name;
  final List<String> foodItemIds;

  const FCTFoodGroup(
      {required this.id, required this.name, required this.foodItemIds});

  factory FCTFoodGroup.fromJson(Map<String, dynamic> json) =>
      _$FCTFoodGroupFromJson(json);

  Map<String, dynamic> toJson() => _$FCTFoodGroupToJson(this);
}

abstract class FoodCompositionTable {
  final String id;
  final String name;

  FoodCompositionTable({required this.id, required this.name});

  Future<void> init();
  Future<FCTFoodItem?> getFoodItem(String id);
  Future<Map<String, FCTFoodGroup>> getFoodGroups();
  Future<Iterable<FCTFoodItem>> search(String query);
}
