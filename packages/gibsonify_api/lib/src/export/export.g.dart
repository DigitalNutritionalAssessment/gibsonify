// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GibsonifyExportFile _$GibsonifyExportFileFromJson(Map<String, dynamic> json) =>
    GibsonifyExportFile(
      surveys: (json['surveys'] as List<dynamic>)
          .map((e) => Survey.fromJson(e as Map<String, dynamic>))
          .toList(),
      households: (json['households'] as List<dynamic>)
          .map((e) => Household.fromJson(e as Map<String, dynamic>))
          .toList(),
      recipes: (json['recipes'] as List<dynamic>)
          .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GibsonifyExportFileToJson(
        GibsonifyExportFile instance) =>
    <String, dynamic>{
      'surveys': instance.surveys.map((e) => e.toJson()).toList(),
      'households': instance.households.map((e) => e.toJson()).toList(),
      'recipes': instance.recipes.map((e) => e.toJson()).toList(),
      'metadata': instance.metadata.toJson(),
    };
