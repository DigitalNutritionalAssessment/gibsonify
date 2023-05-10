import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:gibsonify_api/gibsonify_api.dart';

part 'recipe.g.dart';

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
      ];

  Recipe.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        employeeNumber = json['employeeNumber'],
        number = json['number'],
        date = json['date'],
        type = json['type'],
        measurements = Measurement.jsonDecodeMeasurements(json['measurements']),
        ingredients = _jsonDecodeIngredients(json['ingredients']),
        probes = _jsonDecodeProbes(json['probes']),
        allProbesChecked = json['allProbesChecked'] == 'true' ? true : false,
        allProbeAnswersStandard =
            json['allProbeAnswersStandard'] == 'true' ? true : false,
        saved = json['saved'] == 'true' ? true : false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['employeeNumber'] = employeeNumber;
    data['number'] = number;
    data['date'] = date;
    data['type'] = type;
    data['measurements'] = jsonEncode(measurements);
    data['ingredients'] = jsonEncode(ingredients);
    data['probes'] = jsonEncode(probes);
    data['allProbesChecked'] = allProbesChecked.toString();
    data['allProbeAnswersStandard'] = allProbeAnswersStandard.toString();
    data['saved'] = saved.toString();
    return data;
  }

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
