import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';

class Ingredient extends Equatable {
  Ingredient(
      {this.name = const Name.pure(),
      this.description = const Description.pure(),
      this.cookingState = const CookingState.pure(),
      this.measurementMethod = const MeasurementMethod.pure(),
      this.measurement = const Measurement.pure(),
      this.measurementUnit = const MeasurementUnit.pure(),
      this.size = const Size.pure(),
      this.sizeNumber = const SizeNumber.pure(),
      this.saved = false,
      String? id})
      : id = id ?? const Uuid().v4();

  final Name name;
  final Description description;
  final CookingState cookingState;
  final MeasurementMethod measurementMethod;
  final Measurement measurement;
  final MeasurementUnit measurementUnit;
  final Size size;
  final SizeNumber sizeNumber;
  final bool saved;
  final String id;

  Ingredient copyWith(
      {Name? name,
      Description? description,
      CookingState? cookingState,
      MeasurementMethod? measurementMethod,
      Measurement? measurement,
      MeasurementUnit? measurementUnit,
      Size? size,
      SizeNumber? sizeNumber,
      bool? saved,
      String? id}) {
    return Ingredient(
        name: name ?? this.name,
        description: description ?? this.description,
        cookingState: cookingState ?? this.cookingState,
        measurementMethod: measurementMethod ?? this.measurementMethod,
        measurement: measurement ?? this.measurement,
        measurementUnit: measurementUnit ?? this.measurementUnit,
        size: size ?? this.size,
        sizeNumber: sizeNumber ?? this.sizeNumber,
        saved: saved ?? this.saved,
        id: id ?? this.id);
  }

  @override
  List<Object> get props => [
        name,
        description,
        cookingState,
        measurementMethod,
        measurement,
        measurementUnit,
        size,
        sizeNumber,
        saved,
        id
      ];
}

enum NameValidationError { invalid }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : NameValidationError.invalid;
  }
}

enum DescriptionValidationError { invalid }

class Description extends FormzInput<String, DescriptionValidationError> {
  const Description.pure() : super.pure('');
  const Description.dirty([String value = '']) : super.dirty(value);

  @override
  DescriptionValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : DescriptionValidationError.invalid;
  }
}

enum CookingStateValidationError { invalid }

class CookingState extends FormzInput<String, CookingStateValidationError> {
  const CookingState.pure() : super.pure('');
  const CookingState.dirty([String value = '']) : super.dirty(value);

  @override
  CookingStateValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : CookingStateValidationError.invalid;
  }
}

enum MeasurementMethodValidationError { invalid }

class MeasurementMethod
    extends FormzInput<String, MeasurementMethodValidationError> {
  const MeasurementMethod.pure() : super.pure('');
  const MeasurementMethod.dirty([String value = '']) : super.dirty(value);

  @override
  MeasurementMethodValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : MeasurementMethodValidationError.invalid;
  }
}

enum MeasurementValidationError { invalid }

class Measurement extends FormzInput<String, MeasurementValidationError> {
  const Measurement.pure() : super.pure('');
  const Measurement.dirty([String value = '']) : super.dirty(value);

  @override
  MeasurementValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : MeasurementValidationError.invalid;
  }
}

enum MeasurementUnitValidationError { invalid }

class MeasurementUnit
    extends FormzInput<String, MeasurementUnitValidationError> {
  const MeasurementUnit.pure() : super.pure('');
  const MeasurementUnit.dirty([String value = '']) : super.dirty(value);

  @override
  MeasurementUnitValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : MeasurementUnitValidationError.invalid;
  }
}

enum SizeValidationError { invalid }

class Size extends FormzInput<String, SizeValidationError> {
  const Size.pure() : super.pure('');
  const Size.dirty([String value = '']) : super.dirty(value);

  @override
  SizeValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : SizeValidationError.invalid;
  }
}

enum SizeNumberValidationError { invalid }

class SizeNumber extends FormzInput<String, SizeNumberValidationError> {
  const SizeNumber.pure() : super.pure('');
  const SizeNumber.dirty([String value = '']) : super.dirty(value);

  @override
  SizeNumberValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : SizeNumberValidationError.invalid;
  }
}
