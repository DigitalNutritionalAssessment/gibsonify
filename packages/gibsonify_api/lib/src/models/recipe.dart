import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 9)
class Recipe extends Equatable {
  Recipe({
    this.name,
    this.employeeNumber,
    // TODO: temp hack to make id field Isar compatible. Id field will eventually be removed
    this.number = "", // TODO: change this to `id` since its alphanumeric?
    String? date,
    this.type = "",
    this.measurements = const [],
    this.ingredients = const <Ingredient>[],
    this.probes = const <Probe>[],
    this.allProbeAnswersStandard = true,
    this.allProbesChecked = false,
    this.saved = false,
    this.surveyId,
  }) : date = date ?? DateFormat('yyyy-MM-dd').format(DateTime.now());

  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? employeeNumber;
  @HiveField(2)
  final String number;
  @HiveField(3)
  final String? date;
  @HiveField(4)
  final String type;
  @HiveField(5)
  final List<Measurement> measurements;
  @HiveField(6)
  final List<Ingredient> ingredients;
  @HiveField(7)
  final List<Probe> probes;
  @HiveField(8)
  final bool allProbesChecked;
  @HiveField(9)
  final bool allProbeAnswersStandard;
  @HiveField(10)
  final bool saved;
  @HiveField(11, defaultValue: null)
  final String? surveyId;

  String recipeNameDisplay() {
    if (isFieldNotNullAndNotEmpty(name)) {
      return name!;
    }
    return 'Unnamed recipe';
  }

  String ingredientNamesDisplay() {
    final List<String?> ingredientNames = [];
    for (Ingredient ingredient in ingredients) {
      ingredientNames.add(ingredient.ingredientNameDisplay());
    }
    String joinedNames = ingredientNames.join(', ');
    if (joinedNames.isNotEmpty) {
      return '\n\nIngredients: ' + joinedNames;
    }
    return '';
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

  Recipe copyWith({
    String? name,
    String? employeeNumber,
    String? number,
    String? date,
    String? type,
    List<Measurement>? measurements,
    List<Ingredient>? ingredients,
    List<Probe>? probes,
    bool? allProbesChecked,
    bool? allProbeAnswersStandard,
    bool? saved,
    String? surveyId,
  }) {
    return Recipe(
      name: name ?? this.name,
      employeeNumber: employeeNumber ?? this.employeeNumber,
      number: number ?? this.number,
      date: date ?? this.date,
      type: type ?? this.type,
      measurements: measurements ?? this.measurements,
      ingredients: ingredients ?? this.ingredients,
      probes: probes ?? this.probes,
      allProbesChecked: allProbesChecked ?? this.allProbesChecked,
      allProbeAnswersStandard:
          allProbeAnswersStandard ?? this.allProbeAnswersStandard,
      saved: saved ?? this.saved,
      surveyId: surveyId ?? this.surveyId,
    );
  }

  @override
  List<Object?> get props => [
        name,
        employeeNumber,
        number,
        date,
        type,
        measurements,
        ingredients,
        probes,
        allProbesChecked,
        allProbeAnswersStandard,
        saved,
        surveyId,
      ];

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);

  String toCsv() {
    // TODO: think if we shouldn't change the type to enum or strings that
    // don't have " Recipe" in the end.
    String prunedType = type.replaceAll(' Recipe', '');
    String recipeInfo =
        '"$employeeNumber","$number","$date","$name","$prunedType",';
    String csv = '';

    String measurementsCombined = combineMeasurements(measurements);
    var blankFieldsAfterMeasurements = ',,,,,,';
    csv += recipeInfo +
        '"Measurement",' +
        measurementsCombined +
        blankFieldsAfterMeasurements +
        '\n';

    var blankFieldsBeforeIngredient = ',,,';
    for (Ingredient ingredient in ingredients) {
      csv += recipeInfo +
          '"Ingredient",' +
          blankFieldsBeforeIngredient +
          ingredient.toCsv() +
          '\n';
    }

    var blankFieldsBeforeProbe = ',';
    var blankFieldsAfterProbe = ',,,,';
    for (Probe probe in probes) {
      csv += recipeInfo +
          '"Probe",' +
          blankFieldsBeforeProbe +
          probe.toCsv() +
          blankFieldsAfterProbe +
          '\n';
    }
    return csv;
  }
}
