import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:gibsonify_api/gibsonify_api.dart';

class Recipe extends Equatable {
  Recipe({
    this.name,
    this.employeeNumber,
    String? number, // TODO: change this to `id` since its alphanumeric?
    String? date,
    this.type = "",
    List<Measurement>? measurements,
    this.ingredients = const <Ingredient>[],
    this.probes = const <Probe>[],
    this.allProbeAnswersStandard = true,
    this.allProbesChecked = false,
    this.saved = false,
  })  : number = number ?? const Uuid().v4(),
        date = date ?? DateFormat('yyyy-MM-dd').format(DateTime.now()),
        measurements = measurements ?? [Measurement()];

  final String? name;
  final String? employeeNumber;
  final String number;
  final String date;
  final String type;
  final List<Measurement> measurements;
  final List<Ingredient> ingredients;
  final List<Probe> probes;
  final bool allProbesChecked;
  final bool allProbeAnswersStandard;
  final bool saved;

  String ingredientNamesString() {
    final List<String?> ingredientNames = [];
    for (Ingredient ingredient in ingredients) {
      ingredientNames.add(ingredient.name);
    }
    String joinedNames = ingredientNames.join(', ');
    if (joinedNames.isNotEmpty) {
      return '\n\nIngredients: ' + joinedNames;
    }
    return '';
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
