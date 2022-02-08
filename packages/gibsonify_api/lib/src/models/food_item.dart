import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';

// TODO: This is a temporary fix to avoid Name conflicts when importing the api
import 'recipe_ingredient.dart' show Name, Description;

import 'recipe.dart';

class FoodItem extends Equatable {
  FoodItem(
      {String? id,
      this.name = const Name.pure(),
      this.timePeriod = const TimePeriod.pure(),
      this.source = const Source.pure(),
      this.description = const Description.pure(),
      this.preparationMethod = const PreparationMethod.pure(),
      this.measurementMethod = const MeasurementMethod.pure(),
      this.measurementValue = const MeasurementValue.pure(),
      this.measurementUnit = const MeasurementUnit.pure(),
      this.recipe,
      this.confirmed = false})
      : id = id ?? const Uuid().v4();

  final String id;
  final Name name;
  final TimePeriod timePeriod;
  final Source source;
  final Description description;
  final PreparationMethod preparationMethod;
  final MeasurementMethod measurementMethod;
  final MeasurementValue measurementValue;
  final MeasurementUnit measurementUnit;
  final Recipe? recipe;
  // TODO: Add Form validation bool field to check if all fields are valid
  final bool confirmed;

  // TODO: implement code generation JSON serialization using json_serializable
  // and/or json_annotation

  FoodItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = Name.fromJson(json['name']),
        timePeriod = TimePeriod.fromJson(json['timePeriod']),
        source = Source.fromJson(json['source']),
        description = Description.fromJson(json['description']),
        preparationMethod =
            PreparationMethod.fromJson(json['preparationMethod']),
        measurementMethod =
            MeasurementMethod.fromJson(json['measurementMethod']),
        measurementValue = MeasurementValue.fromJson(json['measurementValue']),
        measurementUnit = MeasurementUnit.fromJson(json['measurementUnit']),
        recipe = json['recipe'] == '' ? null : Recipe.fromJson(json['recipe']),
        confirmed = json['confirmed'] == 'true' ? true : false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name.toJson();
    data['timePeriod'] = timePeriod.toJson();
    data['source'] = source.toJson();
    data['description'] = description.toJson();
    data['preparationMethod'] = preparationMethod.toJson();
    data['measurementMethod'] = measurementMethod.toJson();
    data['measurementValue'] = measurementValue.toJson();
    data['measurementUnit'] = measurementUnit.toJson();
    data['recipe'] = recipe?.toJson() ?? '';
    data['confirmed'] = confirmed.toString();
    return data;
  }

  FoodItem copyWith(
      {String? id,
      Name? name,
      TimePeriod? timePeriod,
      Source? source,
      Description? description,
      PreparationMethod? preparationMethod,
      MeasurementMethod? measurementMethod,
      MeasurementValue? measurementValue,
      MeasurementUnit? measurementUnit,
      Recipe? recipe,
      bool? confirmed}) {
    return FoodItem(
        id: id ?? this.id,
        name: name ?? this.name,
        timePeriod: timePeriod ?? this.timePeriod,
        source: source ?? this.source,
        description: description ?? this.description,
        preparationMethod: preparationMethod ?? this.preparationMethod,
        measurementMethod: measurementMethod ?? this.measurementMethod,
        measurementValue: measurementValue ?? this.measurementValue,
        measurementUnit: measurementUnit ?? this.measurementUnit,
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
        measurementMethod,
        measurementValue,
        measurementUnit,
        recipe,
        confirmed
      ];
}
// TODO: This has been temporarily commented out to resolve name conflicts
// The most sensible fix to this is probably getting rid of all Formz and
// replacing them by strings only, as in 90% of the cases the only validation
// is checking if it is not empty, and the rest can be added as custom
// validation methods

/*
enum NameValidationError { invalid }

// TODO: Investigate changing classes to be private (with leading underscore)

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([String value = '']) : super.dirty(value);

  // TODO: Figure out a way to use the pure attribute or maybe drop
  // Formz completely. It might be easier to just have all these values
  // as strings and implement a couple of validator methods
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['pure'] = pure.toString();
    return data;
  }

  Name.fromJson(Map<String, dynamic> json) : super.dirty(json['value']);

  @override
  NameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : NameValidationError.invalid;
  }
}
*/

enum TimePeriodValidationError { invalid }

class TimePeriod extends FormzInput<String, TimePeriodValidationError> {
  const TimePeriod.pure() : super.pure('');
  const TimePeriod.dirty([String value = '']) : super.dirty(value);

  final _allowedTimePeriod = const ['morning', 'afternoon', 'evening', 'night'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['pure'] = pure.toString();
    return data;
  }

  TimePeriod.fromJson(Map<String, dynamic> json) : super.dirty(json['value']);

  @override
  TimePeriodValidationError? validator(String? value) {
    final _lowerCaseValue = (value ?? '').toLowerCase();
    // TODO: refactor with a better null check
    return _allowedTimePeriod.contains(_lowerCaseValue)
        ? null
        : TimePeriodValidationError.invalid;
  }
}

enum SourceValidationError { invalid }

class Source extends FormzInput<String, SourceValidationError> {
  const Source.pure() : super.pure('');
  const Source.dirty([String value = '']) : super.dirty(value);

  // TODO: update when accepting custom strings for 'other'
  final _allowedSource = const [
    'home made',
    'purchased',
    'gift/given by neighbor',
    'home garden/farm',
    'leftover',
    'wild food',
    'food aid',
    'not applicable',
    'other'
  ];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['pure'] = pure.toString();
    return data;
  }

  Source.fromJson(Map<String, dynamic> json) : super.dirty(json['value']);

  @override
  SourceValidationError? validator(String? value) {
    final _lowerCaseValue = (value ?? '').toLowerCase();
    // TODO: refactor with a better null check
    return _allowedSource.contains(_lowerCaseValue)
        ? null
        : SourceValidationError.invalid;
  }
}

/*
enum DescriptionValidationError { invalid }

class Description extends FormzInput<String, DescriptionValidationError> {
  const Description.pure() : super.pure('');
  const Description.dirty([String value = '']) : super.dirty(value);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
*/

enum PreparationMethodValidationError { invalid }

class PreparationMethod
    extends FormzInput<String, PreparationMethodValidationError> {
  const PreparationMethod.pure() : super.pure('');
  const PreparationMethod.dirty([String value = '']) : super.dirty(value);

  // TODO: update when accepting custom strings for 'other'
  final _allowedPreparationMethod = const [
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    return _allowedPreparationMethod.contains(_lowerCaseValue)
        ? null
        : PreparationMethodValidationError.invalid;
  }
}

// TODO: allowed measurement methods are changed for not empty check only

enum MeasurementMethodValidationError { invalid }

class MeasurementMethod
    extends FormzInput<String, MeasurementMethodValidationError> {
  const MeasurementMethod.pure() : super.pure('');
  const MeasurementMethod.dirty([String value = '']) : super.dirty(value);

  final _allowedMeasurementMethod = const [
    'direct weight',
    'volume of water',
    'volume of food',
    'play dough',
    'number',
    'size (photo)',
  ];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['pure'] = pure.toString();
    return data;
  }

  MeasurementMethod.fromJson(Map<String, dynamic> json)
      : super.dirty(json['value']);

  @override
  MeasurementMethodValidationError? validator(String? value) {
    final _lowerCaseValue = (value ?? '').toLowerCase();
    // TODO: refactor with a better null check
    return _allowedMeasurementMethod.contains(_lowerCaseValue)
        ? null
        : MeasurementMethodValidationError.invalid;
  }
}

enum MeasurementValueValidationError { invalid }

// TODO: Investigate changing this to a string or float

class MeasurementValue
    extends FormzInput<String, MeasurementValueValidationError> {
  const MeasurementValue.pure() : super.pure('');
  const MeasurementValue.dirty([String value = '']) : super.dirty(value);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['pure'] = pure.toString();
    return data;
  }

  MeasurementValue.fromJson(Map<String, dynamic> json)
      : super.dirty(json['value']);

  @override
  MeasurementValueValidationError? validator(String? value) {
    // TODO: Add validation, currently only checks if not empty
    return value?.isNotEmpty == true
        ? null
        : MeasurementValueValidationError.invalid;
  }
}

// TODO: allowed measurement units are changed for not empty check only

enum MeasurementUnitValidationError { invalid }

class MeasurementUnit
    extends FormzInput<String, MeasurementUnitValidationError> {
  const MeasurementUnit.pure() : super.pure('');
  const MeasurementUnit.dirty([String value = '']) : super.dirty(value);

  final _allowedMeasurementUnit = const [
    'small spoon',
    'big spoon',
    'standard cup',
    'small',
    'medium',
    'large',
    'grams or millilitres' //TODO: check with ICRISAT if this is okay
  ];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['pure'] = pure.toString();
    return data;
  }

  MeasurementUnit.fromJson(Map<String, dynamic> json)
      : super.dirty(json['value']);

  @override
  MeasurementUnitValidationError? validator(String? value) {
    final _lowerCaseValue = (value ?? '').toLowerCase();
    // TODO: refactor with a better null check
    return _allowedMeasurementUnit.contains(_lowerCaseValue)
        ? null
        : MeasurementUnitValidationError.invalid;
  }
}
