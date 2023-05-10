import 'package:equatable/equatable.dart';
import 'dart:convert';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:hive/hive.dart';

part 'measurement.g.dart';

@HiveType(typeId: 8)
class Measurement extends Equatable {
  Measurement({this.method, this.unit, this.value, this.id = ""});

  @HiveField(0)
  final String? method;
  @HiveField(1)
  final String? unit;
  @HiveField(2)
  final String? value;
  @HiveField(3)
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

  Measurement copyWith(
      {String? measurementMethod,
      String? measurementUnit,
      String? measurementValue,
      String? id}) {
    return Measurement(
        method: measurementMethod ?? this.method,
        unit: measurementUnit ?? this.unit,
        value: measurementValue ?? this.value,
        id: id ?? this.id);
  }

  @override
  String toString() {
    return '\n *** \Measurement:\n'
        'UUID: $id\n'
        'Method: $method\n'
        'Unit: $unit\n'
        'Value: $value\n'
        '\n *** \n';
  }

  @override
  List<Object?> get props => [method, unit, value];

  Measurement.fromJson(Map<String, dynamic> json)
      : method = json['measurementMethod'],
        unit = json['measurementUnit'],
        value = json['measurementValue'],
        id = json['id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['measurementMethod'] = method;
    data['measurementUnit'] = unit;
    data['measurementValue'] = value;
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
    if (method == null) {
      return ['Choose a measurement method first'];
    } else {
      return Measurement.measurementUnitsOfMethod[method] ??
          ['No units for given method'];
    }
  }

  bool isMethodValid() {
    // TODO: add checks for different options
    return !isFieldModifiedAndEmpty(method);
  }

  bool isValueValid() {
    // TODO: refactor null checks to something nicer
    if (value == null) {
      return true; // currently meaning that it is untouched, change to a
      // separate method later
    } else if ((value ?? '').isNotEmpty &&
        (value ?? '').length <= 4 &&
        _measurementValueRegex.hasMatch(value ?? '')) {
      return true;
    } else {
      return false;
    }
  }

  bool isUnitValid() {
    if (['Choose a measurement method first', 'No units for given method']
        .contains(unit)) {
      return false;
    } else {
      return !isFieldModifiedAndEmpty(unit);
    }
  }

  bool isMeasurementFilled() {
    return (isFieldNotNullAndNotEmpty(method) &&
        isMethodValid() &&
        isFieldNotNullAndNotEmpty(unit) &&
        isUnitValid() &&
        isFieldNotNullAndNotEmpty(value) &&
        isValueValid());
  }
}
