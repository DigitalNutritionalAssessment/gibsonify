// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodItemAdapter extends TypeAdapter<FoodItem> {
  @override
  final int typeId = 7;

  @override
  FoodItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodItem(
      id: fields[0] as String,
      name: fields[1] as String?,
      timePeriod: fields[2] as String?,
      source: fields[3] as String?,
      description: fields[4] as String?,
      preparationMethod: fields[5] as String?,
      customPreparationMethod: fields[6] as String?,
      measurements: (fields[7] as List).cast<Measurement>(),
      recipe: fields[8] as Recipe?,
      confirmed: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FoodItem obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.timePeriod)
      ..writeByte(3)
      ..write(obj.source)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.preparationMethod)
      ..writeByte(6)
      ..write(obj.customPreparationMethod)
      ..writeByte(7)
      ..write(obj.measurements)
      ..writeByte(8)
      ..write(obj.recipe)
      ..writeByte(9)
      ..write(obj.confirmed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
