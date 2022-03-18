import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import 'measurement.dart';
import 'recipe_ingredient.dart';
import 'recipe_probe.dart';

class Recipe extends Equatable {
  Recipe({
    this.recipeName,
    String? recipeNumber,
    String? date,
    this.recipeType = "",
    List<Measurement>? measurements,
    this.ingredients = const <Ingredient>[],
    this.probes = const <Probe>[],
    this.allProbeAnswersStandard = true,
    this.allProbesChecked = false,
    this.saved = false,
  })  : recipeNumber = recipeNumber ?? const Uuid().v4(),
        date = date ?? DateFormat('yyyy-MM-dd').format(DateTime.now()),
        measurements = measurements ?? [Measurement()];

  final String? recipeName;
  final String recipeNumber;
  final String date;
  final String recipeType;
  final List<Measurement> measurements;
  final List<Ingredient> ingredients;
  final List<Probe> probes;
  final bool allProbesChecked;
  final bool allProbeAnswersStandard;
  final bool saved;

  Recipe copyWith({
    String? recipeName,
    String? recipeNumber,
    String? date,
    String? recipeType,
    List<Measurement>? measurements,
    List<Ingredient>? ingredients,
    List<Probe>? probes,
    bool? allProbesChecked,
    bool? allProbeAnswersStandard,
    bool? saved,
  }) {
    return Recipe(
      recipeName: recipeName ?? this.recipeName,
      recipeNumber: recipeNumber ?? this.recipeNumber,
      date: date ?? this.date,
      recipeType: recipeType ?? this.recipeType,
      measurements: measurements ?? this.measurements,
      ingredients: ingredients ?? this.ingredients,
      probes: probes ?? this.probes,
      allProbesChecked: allProbesChecked ?? this.allProbesChecked,
      allProbeAnswersStandard:
          allProbeAnswersStandard ?? this.allProbeAnswersStandard,
      saved: saved ?? this.saved,
    );
  }

  @override
  List<Object?> get props => [
        recipeName,
        recipeNumber,
        date,
        recipeType,
        measurements,
        ingredients,
        probes,
        allProbesChecked,
        allProbeAnswersStandard,
        saved,
      ];

  Recipe.fromJson(Map<String, dynamic> json)
      : recipeName = json['recipeName'],
        recipeNumber = json['recipeNumber'],
        date = json['date'],
        recipeType = json['recipeType'],
        measurements = Measurement.jsonDecodeMeasurements(json['measurements']),
        ingredients = _jsonDecodeIngredients(json['ingredients']),
        probes = _jsonDecodeProbes(json['probes']),
        allProbesChecked = json['allProbesChecked'] == 'true' ? true : false,
        allProbeAnswersStandard =
            json['allProbeAnswersStandard'] == 'true' ? true : false,
        saved = json['saved'] == 'true' ? true : false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recipeName'] = recipeName;
    data['recipeNumber'] = recipeNumber;
    data['date'] = date;
    data['recipeType'] = recipeType;
    data['measurements'] = jsonEncode(measurements);
    data['ingredients'] = jsonEncode(ingredients);
    data['probes'] = jsonEncode(probes);
    data['allProbesChecked'] = allProbesChecked.toString();
    data['allProbeAnswersStandard'] = allProbeAnswersStandard.toString();
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
