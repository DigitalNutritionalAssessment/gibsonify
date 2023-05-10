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
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer
      ..writeByte(11)
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
      ..write(obj.saved);
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
