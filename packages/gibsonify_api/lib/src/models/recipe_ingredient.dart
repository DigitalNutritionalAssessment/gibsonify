import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:gibsonify_api/gibsonify_api.dart';

class Ingredient extends Equatable {
  Ingredient(
      {this.name,
      this.customName,
      this.description,
      this.cookingState,
      List<Measurement>? measurements,
      this.foodComposition,
      this.saved = false,
      String? id})
      : id = id ?? const Uuid().v4(),
        measurements = measurements ?? [Measurement()];

  final String? name;
  final String? customName;
  final String? description;
  final String? cookingState;
  final List<Measurement> measurements;
  final Map<String, dynamic>? foodComposition;
  final bool saved;
  final String id;

  Ingredient copyWith(
      {String? name,
      String? customName,
      String? description,
      String? cookingState,
      List<Measurement>? measurements,
      Map<String, dynamic>? foodComposition,
      bool? saved,
      String? id}) {
    return Ingredient(
        name: name ?? this.name,
        customName: customName ?? this.customName,
        description: description ?? this.description,
        cookingState: cookingState ?? this.cookingState,
        measurements: measurements ?? this.measurements,
        foodComposition: foodComposition ?? this.foodComposition,
        saved: saved ?? this.saved,
        id: id ?? this.id);
  }

  @override
  List<Object?> get props => [
        name,
        customName,
        description,
        cookingState,
        measurements,
        foodComposition,
        saved,
        id
      ];

  // TODO: move this to the main app, this shouldn't be a method of this class
  static Future<String> getIngredients() {
    return rootBundle.loadString('assets/ingredients/ingredients.json');
  }

  Ingredient.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        customName = json['customName'],
        description = json['description'],
        cookingState = json['cookingState'],
        measurements = Measurement.jsonDecodeMeasurements(json['measurements']),
        foodComposition = jsonDecode(json['foodComposition']),
        saved = json['saved'] == 'true' ? true : false,
        id = json['id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['customName'] = customName;
    data['description'] = description;
    data['cookingState'] = cookingState;
    data['measurements'] = jsonEncode(measurements);
    data['foodComposition'] = jsonEncode(foodComposition);
    data['saved'] = saved.toString();
    data['id'] = id;
    return data;
  }

  String toCsv() {
    String measurementsCombined = combineMeasurements(measurements);

    // TODO: how should customName be handled?
    return '"${name ?? customName}","$description",'
        '"$cookingState","$measurementsCombined"';
  }
}
