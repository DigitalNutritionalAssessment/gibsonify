import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

import 'recipe_ingredient.dart';
import 'recipe_probe.dart';

// TODO: rename this file to recipe.dart instead of recipe_item.dart
class Recipe extends Equatable {
  Recipe({
    this.recipeName = const RecipeName.pure(),
    String? recipeNumber,
    this.recipeType = "",
    this.recipeVolume = const RecipeVolume.pure(),
    this.ingredients = const <Ingredient>[],
    this.probes = const <Probe>[],
    this.probesChecked = false,
    this.saved = false,
  }) : recipeNumber = recipeNumber ?? const Uuid().v4();

  Recipe.fromJson(Map<String, dynamic> json)
      : recipeName = RecipeName.fromJson(json['recipeName']),
        recipeNumber = json['recipeNumber'],
        recipeType = json['recipeType'],
        recipeVolume = RecipeVolume.fromJson(json['recipeVolume']),
        ingredients = _jsonDecodeIngredients(json['ingredients']),
        probes = _jsonDecodeProbes(json['probes']),
        probesChecked = json['probesChecked'] == 'true' ? true : false,
        saved = json['saved'] == 'true' ? true : false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recipeName'] = recipeName.toJson();
    data['recipeNumber'] = recipeNumber;
    data['recipeType'] = recipeType;
    data['recipeVolume'] = recipeVolume.toJson();
    data['ingredients'] = jsonEncode(ingredients);
    data['probes'] = jsonEncode(probes);
    data['probesChecked'] = probesChecked.toString();
    data['saved'] = saved.toString();
    return data;
  }

  final RecipeName recipeName;
  final String recipeNumber;
  final String recipeType;
  final RecipeVolume recipeVolume;
  final List<Ingredient> ingredients;
  final List<Probe> probes;
  final bool probesChecked;
  final bool saved;

  Recipe copyWith({
    RecipeName? recipeName,
    String? recipeNumber,
    String? recipeType,
    RecipeVolume? recipeVolume,
    List<Ingredient>? ingredients,
    List<Probe>? probes,
    bool? probesChecked,
    bool? saved,
  }) {
    return Recipe(
      recipeName: recipeName ?? this.recipeName,
      recipeNumber: recipeNumber ?? this.recipeNumber,
      recipeType: recipeType ?? this.recipeType,
      recipeVolume: recipeVolume ?? this.recipeVolume,
      ingredients: ingredients ?? this.ingredients,
      probes: probes ?? this.probes,
      probesChecked: probesChecked ?? this.probesChecked,
      saved: saved ?? this.saved,
    );
  }

  @override
  List<Object> get props => [
        recipeName,
        recipeNumber,
        recipeType,
        recipeVolume,
        ingredients,
        probes,
        probesChecked,
        saved,
      ];
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
