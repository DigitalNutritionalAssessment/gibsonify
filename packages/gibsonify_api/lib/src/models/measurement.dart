import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class Measurement extends Equatable {
  Measurement(
      {this.measurementMethod,
      this.measurementUnit,
      this.measurementValue,
      String? id})
      : id = id ?? const Uuid().v4();

  final String? measurementMethod;
  final String? measurementUnit;
  final String? measurementValue;
  final String id;
  static final List<String> measurementMethods = [
    "Direct weight",
    "Volume of water",
    "Volume of food",
    "Play dough",
    "Number",
    "Size (photo)"
  ];
  static final List<String> measurementUnits = [
    "Small Spoon",
    "Big spoon",
    "Small standard cup",
    "Medium standard cup",
    "Large standard cup",
    "Small",
    "Medium",
    "Large",
    "Grams",
    "Millilitres"
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
}
