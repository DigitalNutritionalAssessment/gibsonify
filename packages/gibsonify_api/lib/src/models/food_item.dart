import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food_item.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 7)
class FoodItem extends Equatable {
  FoodItem(
      // TODO: temp hack to make id field Isar compatible. Id field will eventually be removed
      {this.id = "",
      this.name,
      this.timePeriod,
      this.source,
      this.description, // TODO: rename to comments
      this.preparationMethod,
      this.customPreparationMethod,
      this.measurements = const [],
      this.recipe,
      this.confirmed = false});

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String? name;
  // TODO: change to timePeriod, source and preparationMethod to enums with maps
  // to Strings and back to enums for serialization (toJson and fromJson)
  @HiveField(2)
  final String? timePeriod;
  @HiveField(3)
  final String? source;
  @HiveField(4)
  final String? description;
  @HiveField(5)
  final String? preparationMethod;
  @HiveField(6)
  final String? customPreparationMethod;
  @HiveField(7)
  final List<Measurement> measurements;
  @HiveField(8)
  final Recipe? recipe;
  // TODO: Add Form validation bool field to check if all fields are valid
  @HiveField(9)
  final bool confirmed;

  factory FoodItem.fromJson(Map<String, dynamic> json) =>
      _$FoodItemFromJson(json);

  Map<String, dynamic> toJson() => _$FoodItemToJson(this);

  // TODO: add a fromCsv constructor

  String preparationMethodDisplay() {
    if (isFieldNotNullAndNotEmpty(preparationMethod)) {
      if (preparationMethod == 'Other (please specify)') {
        return customPreparationMethod ?? 'Unspecified preparation method';
      }
      return preparationMethod!;
    }
    return 'Unnamed preparation method';
  }

  String toCsv() {
    String measurementsCombined = combineMeasurements(measurements);

    return '"$id","$name","$timePeriod","$source","$description",'
        '"${preparationMethodDisplay()}","$confirmed","${recipe?.number}",'
        '"${recipe?.date}","${recipe?.name}","$measurementsCombined"';
  }

  FoodItem copyWith(
      {String? id,
      String? name,
      String? timePeriod,
      String? source,
      String? description,
      String? preparationMethod,
      String? customPreparationMethod,
      List<Measurement>? measurements,
      Recipe? recipe,
      bool? confirmed}) {
    return FoodItem(
        id: id ?? this.id,
        name: name ?? this.name,
        timePeriod: timePeriod ?? this.timePeriod,
        source: source ?? this.source,
        description: description ?? this.description,
        preparationMethod: preparationMethod ?? this.preparationMethod,
        customPreparationMethod:
            customPreparationMethod ?? this.customPreparationMethod,
        measurements: measurements ?? this.measurements,
        recipe: recipe ?? this.recipe,
        confirmed: confirmed ?? this.confirmed);
  }

  @override
  String toString() {
    return '\n *** \Food Item:\n'
        'UUID: $id\n'
        'Name: $name\n'
        'Time Period: $timePeriod\n'
        'Source: $source\n'
        'Ingredients Description: $description\n'
        'Preparation Method: ${preparationMethodDisplay()}\n'
        'Measurements: $measurements\n'
        'Recipe: $recipe\n'
        'Confirmed: $confirmed\n'
        '\n *** \n';
  }

  @override
  List<Object?> get props => [
        name,
        id,
        timePeriod,
        source,
        description,
        preparationMethod,
        customPreparationMethod,
        measurements,
        recipe,
        confirmed
      ];
}
