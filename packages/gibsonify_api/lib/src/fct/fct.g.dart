// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FCTNutrition _$FCTNutritionFromJson(Map<String, dynamic> json) => FCTNutrition(
      energy_kj: (json['energy_kj'] as num?)?.toDouble(),
      carbohydrate_g: (json['carbohydrate_g'] as num?)?.toDouble(),
      protein_g: (json['protein_g'] as num?)?.toDouble(),
      fat_g: (json['fat_g'] as num?)?.toDouble(),
      fibre_g: (json['fibre_g'] as num?)?.toDouble(),
      moisture_g: (json['moisture_g'] as num?)?.toDouble(),
      ash_g: (json['ash_g'] as num?)?.toDouble(),
      vit_a_g: (json['vit_a_g'] as num?)?.toDouble(),
      vit_b1_g: (json['vit_b1_g'] as num?)?.toDouble(),
      vit_b2_g: (json['vit_b2_g'] as num?)?.toDouble(),
      vit_b3_g: (json['vit_b3_g'] as num?)?.toDouble(),
      vit_b5_g: (json['vit_b5_g'] as num?)?.toDouble(),
      vit_b6_g: (json['vit_b6_g'] as num?)?.toDouble(),
      vit_b7_g: (json['vit_b7_g'] as num?)?.toDouble(),
      vit_b9_g: (json['vit_b9_g'] as num?)?.toDouble(),
      vit_c_g: (json['vit_c_g'] as num?)?.toDouble(),
      vit_d2_g: (json['vit_d2_g'] as num?)?.toDouble(),
      vit_e_g: (json['vit_e_g'] as num?)?.toDouble(),
      vit_k1_g: (json['vit_k1_g'] as num?)?.toDouble(),
      vit_k2_g: (json['vit_k2_g'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FCTNutritionToJson(FCTNutrition instance) =>
    <String, dynamic>{
      'energy_kj': instance.energy_kj,
      'carbohydrate_g': instance.carbohydrate_g,
      'protein_g': instance.protein_g,
      'fat_g': instance.fat_g,
      'fibre_g': instance.fibre_g,
      'moisture_g': instance.moisture_g,
      'ash_g': instance.ash_g,
      'vit_a_g': instance.vit_a_g,
      'vit_b1_g': instance.vit_b1_g,
      'vit_b2_g': instance.vit_b2_g,
      'vit_b3_g': instance.vit_b3_g,
      'vit_b5_g': instance.vit_b5_g,
      'vit_b6_g': instance.vit_b6_g,
      'vit_b7_g': instance.vit_b7_g,
      'vit_b9_g': instance.vit_b9_g,
      'vit_c_g': instance.vit_c_g,
      'vit_d2_g': instance.vit_d2_g,
      'vit_e_g': instance.vit_e_g,
      'vit_k1_g': instance.vit_k1_g,
      'vit_k2_g': instance.vit_k2_g,
    };

FCTFoodItem _$FCTFoodItemFromJson(Map<String, dynamic> json) => FCTFoodItem(
      id: json['id'] as String,
      name: json['name'] as String,
      scientificName: json['scientificName'] as String,
      alternateNames: (json['alternateNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      foodGroupId: json['foodGroupId'] as String,
      ddsGroupId: json['ddsGroupId'] as int,
      photoUrl: json['photoUrl'] as String?,
      nutrition:
          FCTNutrition.fromJson(json['nutrition'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FCTFoodItemToJson(FCTFoodItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'scientificName': instance.scientificName,
      'alternateNames': instance.alternateNames,
      'foodGroupId': instance.foodGroupId,
      'ddsGroupId': instance.ddsGroupId,
      'photoUrl': instance.photoUrl,
      'nutrition': instance.nutrition,
    };

FCTFoodGroup _$FCTFoodGroupFromJson(Map<String, dynamic> json) => FCTFoodGroup(
      id: json['id'] as String,
      name: json['name'] as String,
      foodItemIds: (json['foodItemIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$FCTFoodGroupToJson(FCTFoodGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'foodItemIds': instance.foodItemIds,
    };
