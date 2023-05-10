import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe_ingredient.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 10)
class Ingredient extends Equatable {
  Ingredient(
      {this.name,
      this.customName,
      this.description,
      this.cookingState,
      this.customCookingState,
      this.measurements = const [],
      // Food composition will be undergoing major changes so
      // it can be left out until those are implemented
      //this.foodComposition,
      this.saved = false,
      this.id = ""});

  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? customName;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final String? cookingState;
  @HiveField(4)
  final String? customCookingState;
  @HiveField(5)
  final List<Measurement> measurements;
  //final Map<String, dynamic>? foodComposition;
  @HiveField(6)
  final bool saved;
  @HiveField(7)
  final String id;

  String ingredientNameDisplay() {
    if (isFieldNotNullAndNotEmpty(name)) {
      if (name == 'Other (please specify)') {
        return customName ?? 'Unspecified Ingredient';
      }
      return name!;
    }
    return 'Unnamed ingredient';
  }

  String cookingStateDisplay() {
    if (isFieldNotNullAndNotEmpty(cookingState)) {
      if (cookingState == 'Other (please specify)') {
        return customCookingState ?? 'Unspecified cooking state';
      }
      return cookingState!;
    }
    return 'Unnamed cooking state';
  }

  bool areMeasurementsFilled() {
    bool result = true;
    for (Measurement measurement in measurements) {
      if (!measurement.isMeasurementFilled()) {
        result = false;
      }
    }
    return result;
  }

  Ingredient copyWith(
      {String? name,
      String? customName,
      String? description,
      String? cookingState,
      String? customCookingState,
      List<Measurement>? measurements,
      Map<String, dynamic>? foodComposition,
      bool? saved,
      String? id}) {
    return Ingredient(
        name: name ?? this.name,
        customName: customName ?? this.customName,
        description: description ?? this.description,
        cookingState: cookingState ?? this.cookingState,
        customCookingState: customCookingState ?? this.customCookingState,
        measurements: measurements ?? this.measurements,
        //foodComposition: foodComposition ?? this.foodComposition,
        saved: saved ?? this.saved,
        id: id ?? this.id);
  }

  @override
  List<Object?> get props => [
        name,
        customName,
        description,
        cookingState,
        customCookingState,
        measurements,
        //foodComposition,
        saved,
        id
      ];

  // TODO: move this to the main app, this shouldn't be a method of this class
  static Future<String> getIngredients() {
    return rootBundle.loadString('assets/ingredients/ingredients.json');
  }

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);

  String toCsv() {
    String measurementsCombined = combineMeasurements(measurements);

    // TODO: how should customName be handled?
    return '"${ingredientNameDisplay()}","$description",'
        '"${cookingStateDisplay()}","$measurementsCombined"';
  }
}
