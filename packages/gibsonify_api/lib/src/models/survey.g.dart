// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SurveyAdapter extends TypeAdapter<Survey> {
  @override
  final int typeId = 14;

  @override
  Survey read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Survey(
      surveyId: fields[0] as String,
      name: fields[1] as String,
      country: fields[2] as String,
      description: fields[3] as String?,
      comments: fields[4] as String?,
      minAge: fields[5] as int,
      maxAge: fields[6] as int,
      requiredSex: fields[7] as Sex?,
      geoArea: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Survey obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.surveyId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.country)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.comments)
      ..writeByte(5)
      ..write(obj.minAge)
      ..writeByte(6)
      ..write(obj.maxAge)
      ..writeByte(7)
      ..write(obj.requiredSex)
      ..writeByte(8)
      ..write(obj.geoArea);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurveyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
