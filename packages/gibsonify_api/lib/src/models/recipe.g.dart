// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = 9;

  @override
  Recipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recipe(
      name: fields[0] as String?,
      employeeNumber: fields[1] as String?,
      number: fields[2] as String,
      date: fields[3] as String?,
      type: fields[4] as String,
      measurements: (fields[5] as List).cast<Measurement>(),
      ingredients: (fields[6] as List).cast<Ingredient>(),
      probes: (fields[7] as List).cast<Probe>(),
      allProbeAnswersStandard: fields[9] as bool,
      allProbesChecked: fields[8] as bool,
      saved: fields[10] as bool,
      surveyId: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.employeeNumber)
      ..writeByte(2)
      ..write(obj.number)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.measurements)
      ..writeByte(6)
      ..write(obj.ingredients)
      ..writeByte(7)
      ..write(obj.probes)
      ..writeByte(8)
      ..write(obj.allProbesChecked)
      ..writeByte(9)
      ..write(obj.allProbeAnswersStandard)
      ..writeByte(10)
      ..write(obj.saved)
      ..writeByte(11)
      ..write(obj.surveyId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      name: json['name'] as String?,
      employeeNumber: json['employeeNumber'] as String?,
      number: json['number'] as String? ?? "",
      date: json['date'] as String?,
      type: json['type'] as String? ?? "",
      measurements: (json['measurements'] as List<dynamic>?)
              ?.map((e) => Measurement.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      ingredients: (json['ingredients'] as List<dynamic>?)
              ?.map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Ingredient>[],
      probes: (json['probes'] as List<dynamic>?)
              ?.map((e) => Probe.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Probe>[],
      allProbeAnswersStandard: json['allProbeAnswersStandard'] as bool? ?? true,
      allProbesChecked: json['allProbesChecked'] as bool? ?? false,
      saved: json['saved'] as bool? ?? false,
      surveyId: json['surveyId'] as String?,
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'name': instance.name,
      'employeeNumber': instance.employeeNumber,
      'number': instance.number,
      'date': instance.date,
      'type': instance.type,
      'measurements': instance.measurements.map((e) => e.toJson()).toList(),
      'ingredients': instance.ingredients.map((e) => e.toJson()).toList(),
      'probes': instance.probes.map((e) => e.toJson()).toList(),
      'allProbesChecked': instance.allProbesChecked,
      'allProbeAnswersStandard': instance.allProbeAnswersStandard,
      'saved': instance.saved,
      'surveyId': instance.surveyId,
    };
