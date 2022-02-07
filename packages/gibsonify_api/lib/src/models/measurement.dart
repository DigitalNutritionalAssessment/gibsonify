import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class Measurement extends Equatable {
  Measurement(
      {this.measurementMethod,
      this.measurementUnit,
      this.measurementVolume,
      String? id})
      : id = id ?? const Uuid().v4();

  final String? measurementMethod;
  final String? measurementUnit;
  final String? measurementVolume;
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
      String? measurementVolume,
      String? id}) {
    return Measurement(
        measurementMethod: measurementMethod ?? this.measurementMethod,
        measurementUnit: measurementUnit ?? this.measurementUnit,
        measurementVolume: measurementVolume ?? this.measurementVolume,
        id: id ?? this.id);
  }

  @override
  List<Object?> get props =>
      [measurementMethod, measurementUnit, measurementVolume, id];

  Measurement.fromJson(Map<String, dynamic> json)
      : measurementMethod = json['measurementMethod'],
        measurementUnit = json['measurementUnit'],
        measurementVolume = json['measurementVolume'],
        id = json['id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['measurementMethod'] = measurementMethod;
    data['measurementUnit'] = measurementUnit;
    data['measurementVolume'] = measurementVolume;
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
