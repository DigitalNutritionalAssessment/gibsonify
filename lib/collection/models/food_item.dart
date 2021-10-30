// TODO: look into making Food a child of Equatable
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';

class FoodItem extends Equatable {
  FoodItem(
      {this.name = const Name.pure(),
      String? id,
      this.timePeriod = const TimePeriod.pure(),
      this.source = const Source.pure(),
      this.description = const Description.pure(),
      this.preparationMethod = const PreparationMethod.pure()})
      : id = id ?? const Uuid().v4();

  final Name name;
  final String id;
  final TimePeriod timePeriod;
  final Source source;
  final Description description;
  final PreparationMethod preparationMethod;

  FoodItem copyWith(
      {Name? name,
      String? id,
      TimePeriod? timePeriod,
      Source? source,
      Description? description,
      PreparationMethod? preparationMethod}) {
    return FoodItem(
        name: name ?? this.name,
        id: id ?? this.id,
        timePeriod: timePeriod ?? this.timePeriod,
        source: source ?? this.source,
        description: description ?? this.description,
        preparationMethod: preparationMethod ?? this.preparationMethod);
  }

  @override
  List<Object> get props =>
      [name, id, timePeriod, source, description, preparationMethod];
}

enum NameValidationError { invalid }

// TODO: change classes to be private with underscore???

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError? validator(String? value) {
    // TODO: Add validation, currently only checks if not empty
    return value?.isNotEmpty == true ? null : NameValidationError.invalid;
  }
}

enum TimePeriodValidationError { invalid }

class TimePeriod extends FormzInput<String, TimePeriodValidationError> {
  const TimePeriod.pure() : super.pure('');
  const TimePeriod.dirty([String value = '']) : super.dirty(value);

  final _allowedTimePeriod = const ['morning', 'afternoon', 'evening', 'night'];

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

  @override
  SourceValidationError? validator(String? value) {
    final _lowerCaseValue = (value ?? '').toLowerCase();
    // TODO: refactor with a better null check
    return _allowedSource.contains(_lowerCaseValue)
        ? null
        : SourceValidationError.invalid;
  }
}

enum DescriptionValidationError { invalid }

class Description extends FormzInput<String, DescriptionValidationError> {
  const Description.pure() : super.pure('');
  const Description.dirty([String value = '']) : super.dirty(value);

  @override
  DescriptionValidationError? validator(String? value) {
    // TODO: Add validation, currently only checks if not empty
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

  @override
  PreparationMethodValidationError? validator(String? value) {
    final _lowerCaseValue = (value ?? '').toLowerCase();
    // TODO: refactor with a better null check
    return _allowedPreparationMethod.contains(_lowerCaseValue)
        ? null
        : PreparationMethodValidationError.invalid;
  }
}
