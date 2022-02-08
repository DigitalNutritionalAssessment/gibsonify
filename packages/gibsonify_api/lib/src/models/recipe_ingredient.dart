import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

import 'measurement.dart';

class Ingredient extends Equatable {
  Ingredient(
      {this.name,
      this.description,
      this.cookingState,
      List<Measurement>? measurements,
      this.saved = false,
      String? id})
      : id = id ?? const Uuid().v4(),
        measurements = measurements ?? [Measurement()];

  final String? name;
  final String? description;
  final String? cookingState;
  final List<Measurement> measurements;
  final bool saved;
  final String id;

  Ingredient copyWith(
      {String? name,
      String? description,
      String? cookingState,
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
  List<Object?> get props =>
      [name, description, cookingState, measurements, saved, id];

  Ingredient.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        cookingState = json['cookingState'],
        measurements = Measurement.jsonDecodeMeasurements(json['measurements']),
        saved = json['saved'] == 'true' ? true : false,
        id = json['id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['description'] = description;
    data['cookingState'] = cookingState;
    data['measurements'] = jsonEncode(measurements);
    data['saved'] = saved.toString();
    data['id'] = id;
    return data;
  }
}
