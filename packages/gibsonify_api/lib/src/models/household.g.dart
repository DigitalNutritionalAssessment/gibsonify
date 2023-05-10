// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HouseholdAdapter extends TypeAdapter<Household> {
  @override
  final int typeId = 0;

  @override
  Household read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Household(
      householdId: fields[0] as String,
      sensitizationDate: fields[1] as DateTime,
      geoLocation: fields[2] as String,
      comments: fields[3] as String,
      respondents: (fields[4] as Map).cast<String, Respondent>(),
    );
  }

  @override
  void write(BinaryWriter writer, Household obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.householdId)
      ..writeByte(1)
      ..write(obj.sensitizationDate)
      ..writeByte(2)
      ..write(obj.geoLocation)
      ..writeByte(3)
      ..write(obj.comments)
      ..writeByte(4)
      ..write(obj.respondents);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HouseholdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
