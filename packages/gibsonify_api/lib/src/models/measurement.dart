import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

import 'package:gibsonify_api/gibsonify_api.dart';

class Measurement extends Equatable {
  Measurement(
      // TODO: refactor to just `method`, `unit`, and `value` as these are fields
      // of `Measurement` already
      {this.measurementMethod,
      this.measurementUnit,
      this.measurementValue,
      String? id})
      : id = id ?? const Uuid().v4();

  final String? measurementMethod;
  final String? measurementUnit;
  final String? measurementValue;
  final String id; // TODO: investigate whether the id is needed
  static final List<String> measurementMethods = [
    'Direct weight',
    'Volume of water',
    'Volume of food',
    'Play dough',
    'Number',
    'Size number (from photo)'
  ];

  static final Map<String, List<String>> measurementUnitsOfMethod = {
    'Direct weight': ['Grams'],
    'Volume of water': [
      'Millilitres',
      'Small Spoon',
      'Big spoon',
      'Small standard cup',
      'Medium standard cup',
      'Large standard cup',
    ],
    'Volume of food': [
      'Millilitres',
      'Small Spoon',
      'Big spoon',
      'Small standard cup',
      'Medium standard cup',
      'Large standard cup',
    ],
    // TODO: Confirm play dough units with ICRISAT
    'Play dough': [
      'Small Spoon',
      'Big spoon',
      'Small standard cup',
      'Medium standard cup',
      'Large standard cup',
    ],
    'Number': ['Quantity'],
    'Size number (from photo)': [
      'Size 1',
      'Size 2',
      'Size 3',
      'Size 4',
      'Size 5',
      'Size 6'
    ]
  };

  static final List<String> measurementUnits = [
    'Small Spoon',
    'Big spoon',
    'Small standard cup',
    'Medium standard cup',
    'Large standard cup',
    'Size number (photo)',
    'Grams',
    'Millilitres'
  ];

  Measurement copyWith(
      {String? measurementMethod,
      String? measurementUnit,
      String? measurementValue,
      String? id}) {
    return Measurement(
        measurementMethod: measurementMethod ?? this.measurementMethod,
        measurementUnit: measurementUnit ?? this.measurementUnit,
        measurementValue: measurementValue ?? this.measurementValue,
        id: id ?? this.id);
  }

  @override
  String toString() {
    return '\n *** \Measurement:\n'
        'UUID: $id\n'
        'Method: $measurementMethod\n'
        'Unit: $measurementUnit\n'
        'Value: $measurementValue\n'
        '\n *** \n';
  }

  @override
  List<Object?> get props =>
      [measurementMethod, measurementUnit, measurementValue, id];

  Measurement.fromJson(Map<String, dynamic> json)
      : measurementMethod = json['measurementMethod'],
        measurementUnit = json['measurementUnit'],
        measurementValue = json['measurementValue'],
        id = json['id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['measurementMethod'] = measurementMethod;
    data['measurementUnit'] = measurementUnit;
    data['measurementValue'] = measurementValue;
    data['id'] = id;
    return data;
  }

  static List<Measurement> jsonDecodeMeasurements(jsonEncodedMeasurements) {
    List<dynamic> partiallyDecodedMeasurements =
        jsonDecode(jsonEncodedMeasurements);
    List<Measurement> fullyDecodedMeasurements = List<Measurement>.from(
        partiallyDecodedMeasurements.map((x) => Measurement.fromJson(x)));
    return fullyDecodedMeasurements;
  }

  static final _measurementValueRegex = RegExp(
    r'^\d+$', // numeric only
  );

  List<String> getMeasurementUnitsForMethod() {
    if (measurementMethod == null) {
      return ['Choose a measurement method first'];
    } else {
      return Measurement.measurementUnitsOfMethod[measurementMethod] ??
          ['No units for given method'];
    }
  }

  bool isMethodValid() {
    // TODO: add checks for different options
    return !isFieldModifiedAndEmpty(measurementMethod);
  }

  bool isValueValid() {
    // TODO: refactor null checks to something nicer
    if (measurementValue == null) {
      return true; // currently meaning that it is untouched, change to a
      // separate method later
    } else if ((measurementValue ?? '').isNotEmpty &&
        (measurementValue ?? '').length <= 4 &&
        _measurementValueRegex.hasMatch(measurementValue ?? '')) {
      return true;
    } else {
      return false;
    }
  }

  bool isUnitValid() {
    if (['Choose a measurement method first', 'No units for given method']
        .contains(measurementUnit)) {
      return false;
    } else {
      return !isFieldModifiedAndEmpty(measurementUnit);
    }
  }

  bool isMeasurementFilled() {
    return (isFieldNotNullAndNotEmpty(measurementMethod) &&
        isMethodValid() &&
        isFieldNotNullAndNotEmpty(measurementUnit) &&
        isUnitValid() &&
        isFieldNotNullAndNotEmpty(measurementValue) &&
        isValueValid());
  }
}
