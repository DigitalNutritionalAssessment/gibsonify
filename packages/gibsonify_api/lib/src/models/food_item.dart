import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';

import 'recipe.dart';
import 'measurement.dart';

class FoodItem extends Equatable {
  FoodItem(
      {String? id,
      this.name,
      this.timePeriod,
      this.source,
      this.description = const Description.pure(),
      this.preparationMethod = const PreparationMethod.pure(),
      List<Measurement>? measurements,
      this.recipe,
      this.confirmed = false})
      : id = id ?? const Uuid().v4(),
        measurements = measurements ?? [Measurement()];

  final String id;
  final String? name;
  // TODO: change to timePeriod, source to enums with maps to Strings and back
  // to enums for serialization (toJson and fromJson)
  final String? timePeriod;
  final String? source;
  final Description description;
  final PreparationMethod preparationMethod;
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
        description = Description.fromJson(json['description']),
        preparationMethod =
            PreparationMethod.fromJson(json['preparationMethod']),
        measurements = Measurement.jsonDecodeMeasurements(json['measurements']),
        recipe = json['recipe'] == '' ? null : Recipe.fromJson(json['recipe']),
        confirmed = json['confirmed'] == 'true' ? true : false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['timePeriod'] = timePeriod;
    data['source'] = source;
    data['description'] = description.toJson();
    data['preparationMethod'] = preparationMethod.toJson();
    data['measurements'] = jsonEncode(measurements);
    data['recipe'] = recipe?.toJson() ?? '';
    data['confirmed'] = confirmed.toString();
    return data;
  }

  FoodItem copyWith(
      {String? id,
      String? name,
      String? timePeriod,
      String? source,
      Description? description,
      PreparationMethod? preparationMethod,
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

  // TODO: override and implement toString() method

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
// TODO: The most sensible fix to this is probably getting rid of all Formz and
// replacing them by strings only, as in 90% of the cases the only validation
// is checking if it is not empty, and the rest can be added as custom
// validation methods

enum DescriptionValidationError { invalid }

class Description extends FormzInput<String, DescriptionValidationError> {
  const Description.pure() : super.pure('');
  const Description.dirty([String value = '']) : super.dirty(value);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['pure'] = pure.toString();
    return data;
  }

  Description.fromJson(Map<String, dynamic> json) : super.dirty(json['value']);

  @override
  DescriptionValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : DescriptionValidationError.invalid;
  }
}

enum PreparationMethodValidationError { invalid }

class PreparationMethod
    extends FormzInput<String, PreparationMethodValidationError> {
  const PreparationMethod.pure() : super.pure('');
  const PreparationMethod.dirty([String value = '']) : super.dirty(value);

  // TODO: update when accepting custom strings for 'other'
  final _allowedPreparationMethods = const [
    'raw',
    'boiled',
    'boiled in water but retained water',
    'boiled in water but removed water',
    'steamed',
    'roasted with oil',
    'roasted without oil',
    'fried',
    'stir-fried',
    'soaking and stir-fried',
    'boiled and fried',
    'boiled and stir-fried',
    'steamed and fried',
    'roasted and boiled',
    'other'
  ];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['pure'] = pure.toString();
    return data;
  }

  PreparationMethod.fromJson(Map<String, dynamic> json)
      : super.dirty(json['value']);

  @override
  PreparationMethodValidationError? validator(String? value) {
    final _lowerCaseValue = (value ?? '').toLowerCase();
    // TODO: refactor with a better null check
    return _allowedPreparationMethods.contains(_lowerCaseValue)
        ? null
        : PreparationMethodValidationError.invalid;
  }
}
