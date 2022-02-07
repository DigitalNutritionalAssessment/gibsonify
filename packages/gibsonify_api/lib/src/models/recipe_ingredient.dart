import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

import 'measurement.dart';

class Ingredient extends Equatable {
  Ingredient(
      {this.name = const Name.pure(),
      this.description = const Description.pure(),
      this.cookingState = const CookingState.pure(),
      List<Measurement>? measurements,
      this.saved = false,
      String? id})
      : id = id ?? const Uuid().v4(),
        measurements = measurements ?? [Measurement()];

  final Name name;
  final Description description;
  final CookingState cookingState;
  final List<Measurement> measurements;
  final bool saved;
  final String id;

  Ingredient copyWith(
      {Name? name,
      Description? description,
      CookingState? cookingState,
      List<Measurement>? measurements,
      bool? saved,
      String? id}) {
    return Ingredient(
        name: name ?? this.name,
        description: description ?? this.description,
        cookingState: cookingState ?? this.cookingState,
        measurements: measurements ?? this.measurements,
        saved: saved ?? this.saved,
        id: id ?? this.id);
  }

  @override
  List<Object> get props =>
      [name, description, cookingState, measurements, saved, id];

  Ingredient.fromJson(Map<String, dynamic> json)
      : name = Name.fromJson(json['name']),
        description = Description.fromJson(json['description']),
        cookingState = CookingState.fromJson(json['cookingState']),
        measurements = Measurement.jsonDecodeMeasurements(json['measurements']),
        saved = json['saved'] == 'true' ? true : false,
        id = json['id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name.toJson();
    data['description'] = description.toJson();
    data['cookingState'] = cookingState.toJson();
    data['measurements'] = jsonEncode(measurements);
    data['saved'] = saved.toString();
    data['id'] = id;
    return data;
  }
}

enum NameValidationError { invalid }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([String value = '']) : super.dirty(value);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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

enum CookingStateValidationError { invalid }

class CookingState extends FormzInput<String, CookingStateValidationError> {
  const CookingState.pure() : super.pure('');
  const CookingState.dirty([String value = '']) : super.dirty(value);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['pure'] = pure.toString();
    return data;
  }

  CookingState.fromJson(Map<String, dynamic> json) : super.dirty(json['value']);

  @override
  CookingStateValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : CookingStateValidationError.invalid;
  }
}
