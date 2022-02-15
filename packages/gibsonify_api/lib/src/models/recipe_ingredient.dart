import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'measurement.dart';

class Ingredient extends Equatable {
  Ingredient(
      {this.name,
      this.otherName,
      this.description,
      this.cookingState,
      List<Measurement>? measurements,
      this.saved = false,
      String? id})
      : id = id ?? const Uuid().v4(),
        measurements = measurements ?? [Measurement()];

  final String? name;
  final String? otherName;
  final String? description;
  final String? cookingState;
  final List<Measurement> measurements;
  final bool saved;
  final String id;
  // TODO: Either add a Map? variable to hold ALL nutritional details of
  // ingredient or add a String variable to hold C_CODE of ingredient

  Ingredient copyWith(
      {String? name,
      String? otherName,
      String? description,
      String? cookingState,
      List<Measurement>? measurements,
      bool? saved,
      String? id}) {
    return Ingredient(
        name: name ?? this.name,
        otherName: otherName ?? this.otherName,
        description: description ?? this.description,
        cookingState: cookingState ?? this.cookingState,
        measurements: measurements ?? this.measurements,
        saved: saved ?? this.saved,
        id: id ?? this.id);
  }

  @override
  List<Object?> get props =>
      [name, otherName, description, cookingState, measurements, saved, id];

  static Future<String> getIngredients() {
    return rootBundle.loadString('assets/ingredients/ingredients.json');
  }

  Ingredient.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        otherName = json['otherName'],
        description = json['description'],
        cookingState = json['cookingState'],
        measurements = Measurement.jsonDecodeMeasurements(json['measurements']),
        saved = json['saved'] == 'true' ? true : false,
        id = json['id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['otherName'] = otherName;
    data['description'] = description;
    data['cookingState'] = cookingState;
    data['measurements'] = jsonEncode(measurements);
    data['saved'] = saved.toString();
    data['id'] = id;
    return data;
  }
}
