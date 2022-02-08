import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

import 'measurement.dart';
import 'recipe_ingredient.dart';
import 'recipe_probe.dart';

class Recipe extends Equatable {
  Recipe({
    this.recipeName,
    String? recipeNumber,
    this.recipeType = "",
    List<Measurement>? measurements,
    this.ingredients = const <Ingredient>[],
    this.probes = const <Probe>[],
    this.probesStandard = true,
    this.probesChecked = false,
    this.saved = false,
  })  : recipeNumber = recipeNumber ?? const Uuid().v4(),
        measurements = measurements ?? [Measurement()];

  final String? recipeName;
  final String recipeNumber;
  final String recipeType;
  final List<Measurement> measurements;
  final List<Ingredient> ingredients;
  final List<Probe> probes;
  final bool probesChecked; // Flag to show all recipe probes have been checked
  final bool
      probesStandard; // Flag to show all answers to recipe probe match the standard recipe answer
  final bool saved;

  Recipe copyWith({
    String? recipeName,
    String? recipeNumber,
    String? recipeType,
    List<Measurement>? measurements,
    List<Ingredient>? ingredients,
    List<Probe>? probes,
    bool? probesChecked,
    bool? probesStandard,
    bool? saved,
  }) {
    return Recipe(
      recipeName: recipeName ?? this.recipeName,
      recipeNumber: recipeNumber ?? this.recipeNumber,
      recipeType: recipeType ?? this.recipeType,
      measurements: measurements ?? this.measurements,
      ingredients: ingredients ?? this.ingredients,
      probes: probes ?? this.probes,
      probesChecked: probesChecked ?? this.probesChecked,
      probesStandard: probesStandard ?? this.probesStandard,
      saved: saved ?? this.saved,
    );
  }

  @override
  List<Object?> get props => [
        recipeName,
        recipeNumber,
        recipeType,
        measurements,
        ingredients,
        probes,
        probesChecked,
        probesStandard,
        saved,
      ];

  Recipe.fromJson(Map<String, dynamic> json)
      : recipeName = json['recipeName'],
        recipeNumber = json['recipeNumber'],
        recipeType = json['recipeType'],
        measurements = Measurement.jsonDecodeMeasurements(json['measurements']),
        ingredients = _jsonDecodeIngredients(json['ingredients']),
        probes = _jsonDecodeProbes(json['probes']),
        probesChecked = json['probesChecked'] == 'true' ? true : false,
        probesStandard = json['probesStandard'] == 'true' ? true : false,
        saved = json['saved'] == 'true' ? true : false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recipeName'] = recipeName;
    data['recipeNumber'] = recipeNumber;
    data['recipeType'] = recipeType;
    data['measurements'] = jsonEncode(measurements);
    data['ingredients'] = jsonEncode(ingredients);
    data['probes'] = jsonEncode(probes);
    data['probesChecked'] = probesChecked.toString();
    data['probesStandard'] = probesStandard.toString();
    data['saved'] = saved.toString();
    return data;
  }
}

List<Ingredient> _jsonDecodeIngredients(jsonEncodedIngredients) {
  List<dynamic> partiallyDecodedIngredients =
      jsonDecode(jsonEncodedIngredients);
  List<Ingredient> fullyDecodedIngredients = List<Ingredient>.from(
      partiallyDecodedIngredients.map((x) => Ingredient.fromJson(x)));
  return fullyDecodedIngredients;
}

List<Probe> _jsonDecodeProbes(jsonEncodedProbes) {
  List<dynamic> partiallyDecodedProbes = jsonDecode(jsonEncodedProbes);
  List<Probe> fullyDecodedProbes =
      List<Probe>.from(partiallyDecodedProbes.map((x) => Probe.fromJson(x)));
  return fullyDecodedProbes;
}
