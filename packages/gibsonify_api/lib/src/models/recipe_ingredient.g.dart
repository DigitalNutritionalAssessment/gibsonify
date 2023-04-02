// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_ingredient.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IngredientAdapter extends TypeAdapter<Ingredient> {
  @override
  final int typeId = 10;

  @override
  Ingredient read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ingredient(
      name: fields[0] as String?,
      customName: fields[1] as String?,
      description: fields[2] as String?,
      cookingState: fields[3] as String?,
      customCookingState: fields[4] as String?,
      measurements: (fields[5] as List).cast<Measurement>(),
      saved: fields[6] as bool,
      id: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Ingredient obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.customName)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.cookingState)
      ..writeByte(4)
      ..write(obj.customCookingState)
      ..writeByte(5)
      ..write(obj.measurements)
      ..writeByte(6)
      ..write(obj.saved)
      ..writeByte(7)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
