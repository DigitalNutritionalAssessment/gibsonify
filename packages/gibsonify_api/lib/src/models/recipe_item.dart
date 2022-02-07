import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

import 'measurement.dart';
import 'recipe_ingredient.dart';
import 'recipe_probe.dart';

// TODO: rename this file to recipe.dart instead of recipe_item.dart
class Recipe extends Equatable {
  Recipe({
    this.recipeName = const RecipeName.pure(),
    String? recipeNumber,
    this.recipeType = "",
    this.measurementMethod,
    this.measurementUnit,
    this.measurementVolume,
    this.recipeVolume = const RecipeVolume.pure(),
    List<Measurement>? measurements,
    this.ingredients = const <Ingredient>[],
    this.probes = const <Probe>[],
    this.probesStandard = true,
    this.probesChecked = false,
    this.saved = false,
  })  : recipeNumber = recipeNumber ?? const Uuid().v4(),
        measurements = measurements ?? [Measurement()];

  final RecipeName recipeName;
  final String recipeNumber;
  final String recipeType;
  final String? measurementMethod;
  final String? measurementUnit;
  final int? measurementVolume;
  final RecipeVolume recipeVolume;
  final List<Measurement> measurements;
  final List<Ingredient> ingredients;
  final List<Probe> probes;
  final bool probesChecked;
  final bool probesStandard;
  final bool saved;

  Recipe copyWith({
    RecipeName? recipeName,
    String? recipeNumber,
    String? recipeType,
    String? measurementMethod,
    String? measurementUnit,
    int? measurementVolume,
    RecipeVolume? recipeVolume,
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
      measurementMethod: measurementMethod ?? this.measurementMethod,
      measurementUnit: measurementUnit ?? this.measurementUnit,
      measurementVolume: measurementVolume ?? this.measurementVolume,
      recipeVolume: recipeVolume ?? this.recipeVolume,
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
        measurementMethod,
        measurementUnit,
        measurementVolume,
        recipeVolume,
        measurements,
        ingredients,
        probes,
        probesChecked,
        probesStandard,
        saved,
      ];

  Recipe.fromJson(Map<String, dynamic> json)
      : recipeName = RecipeName.fromJson(json['recipeName']),
        recipeNumber = json['recipeNumber'],
        recipeType = json['recipeType'],
        measurementMethod = json['measurementMethod'],
        measurementUnit = json['measurementUnit'],
        measurementVolume = json['measurementVolume'],
        recipeVolume = RecipeVolume.fromJson(json['recipeVolume']),
        measurements = Measurement.jsonDecodeMeasurements(json['measurements']),
        ingredients = _jsonDecodeIngredients(json['ingredients']),
        probes = _jsonDecodeProbes(json['probes']),
        probesChecked = json['probesChecked'] == 'true' ? true : false,
        probesStandard = json['probesStandard'] == 'true' ? true : false,
        saved = json['saved'] == 'true' ? true : false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recipeName'] = recipeName.toJson();
    data['recipeNumber'] = recipeNumber;
    data['recipeType'] = recipeType;
    data['measurementMethod'] = measurementMethod;
    data['measurementUnit'] = measurementUnit;
    data['measurementVolume'] = measurementVolume;
    data['recipeVolume'] = recipeVolume.toJson();
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

enum RecipeNameValidationError { invalid }

class RecipeName extends FormzInput<String, RecipeNameValidationError> {
  const RecipeName.pure() : super.pure('');
  const RecipeName.dirty([String value = '']) : super.dirty(value);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['pure'] = pure.toString();
    return data;
  }

  RecipeName.fromJson(Map<String, dynamic> json) : super.dirty(json['value']);

  @override
  RecipeNameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : RecipeNameValidationError.invalid;
  }
}

enum RecipeVolumeValidationError { invalid }

class RecipeVolume extends FormzInput<String, RecipeVolumeValidationError> {
  const RecipeVolume.pure() : super.pure('');
  const RecipeVolume.dirty([String value = '']) : super.dirty(value);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['pure'] = pure.toString();
    return data;
  }

  RecipeVolume.fromJson(Map<String, dynamic> json) : super.dirty(json['value']);

  @override
  RecipeVolumeValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : RecipeVolumeValidationError.invalid;
  }
}
