import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'recipe.dart';
import 'measurement.dart';

class FoodItem extends Equatable {
  FoodItem(
      {String? id,
      this.name,
      this.timePeriod,
      this.source,
      this.description, // TODO: rename to ingredientsDescription
      this.preparationMethod,
      List<Measurement>? measurements,
      this.recipe,
      this.confirmed = false})
      : id = id ?? const Uuid().v4(),
        measurements = measurements ?? [Measurement()];

  final String id;
  final String? name;
  // TODO: change to timePeriod, source and preparationMethod to enums with maps
  // to Strings and back to enums for serialization (toJson and fromJson)
  final String? timePeriod;
  final String? source;
  final String? description;
  final String? preparationMethod;
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
    data['measurements'] = jsonEncode(measurements);
    data['recipe'] = recipe?.toJson() ?? '';
    data['confirmed'] = confirmed.toString();
    return data;
  }

  // TODO: add a fromCsv constructor

  String toCsv() {
    String measurementsCombined = '';
    for (Measurement measurement in measurements) {
      measurementsCombined = measurementsCombined +
          '${measurement.measurementMethod}_'
              '${measurement.measurementUnit}_${measurement.measurementValue} + ';
    }

    measurementsCombined = measurementsCombined.substring(
        0, measurementsCombined.length - ' + '.length);

    return '"$id","$name","$timePeriod","$source","$description",'
        '"$preparationMethod","$confirmed","${recipe?.number}","${recipe?.date}",'
        '"${recipe?.name}","$measurementsCombined"';
  }

  FoodItem copyWith(
      {String? id,
      String? name,
      String? timePeriod,
      String? source,
      String? description,
      String? preparationMethod,
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
        'Preparation Method: $preparationMethod\n'
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
        measurements,
        recipe,
        confirmed
      ];
}
