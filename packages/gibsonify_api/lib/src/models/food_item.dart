import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:gibsonify_api/gibsonify_api.dart';

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

  final String id;
  final String? name;
  // TODO: change to timePeriod, source and preparationMethod to enums with maps
  // to Strings and back to enums for serialization (toJson and fromJson)
  final String? timePeriod;
  final String? source;
  final String? description;
  final String? preparationMethod;
  final String? customPreparationMethod;
  final List<Measurement> measurements;
  final Recipe? recipe;
  // TODO: Add Form validation bool field to check if all fields are valid
  final bool confirmed;

  // TODO: implement code generation JSON serialization using json_serializable
  // and/or json_annotation

  FoodItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        timePeriod = json['timePeriod'],
        source = json['source'],
        description = json['description'],
        preparationMethod = json['preparationMethod'],
        customPreparationMethod = json['customPreparationMethod'],
        measurements = Measurement.jsonDecodeMeasurements(json['measurements']),
        recipe = json['recipe'] == '' ? null : Recipe.fromJson(json['recipe']),
        confirmed = json['confirmed'] == 'true' ? true : false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['timePeriod'] = timePeriod;
    data['source'] = source;
    data['description'] = description;
    data['preparationMethod'] = preparationMethod;
    data['customPreparationMethod'] = customPreparationMethod;
    data['measurements'] = jsonEncode(measurements);
    data['recipe'] = recipe?.toJson() ?? '';
    data['confirmed'] = confirmed.toString();
    return data;
  }

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
