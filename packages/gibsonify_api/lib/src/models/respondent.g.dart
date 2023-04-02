// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'respondent.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RespondentAdapter extends TypeAdapter<Respondent> {
  @override
  final int typeId = 1;

  @override
  Respondent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Respondent(
      name: fields[0] as String,
      phoneNumber: fields[1] as String,
      dateOfBirth: fields[2] as DateTime?,
      sex: fields[3] as Sex?,
      literacyLevel: fields[4] as LiteracyLevel?,
      occupation: fields[5] as Occupation?,
      comments: fields[6] as String,
      collections: (fields[7] as List).cast<GibsonsForm>(),
      anthropometrics: (fields[8] as List).cast<Anthropometrics>(),
    );
  }

  @override
  void write(BinaryWriter writer, Respondent obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.dateOfBirth)
      ..writeByte(3)
      ..write(obj.sex)
      ..writeByte(4)
      ..write(obj.literacyLevel)
      ..writeByte(5)
      ..write(obj.occupation)
      ..writeByte(6)
      ..write(obj.comments)
      ..writeByte(7)
      ..write(obj.collections)
      ..writeByte(8)
      ..write(obj.anthropometrics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RespondentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SexAdapter extends TypeAdapter<Sex> {
  @override
  final int typeId = 2;

  @override
  Sex read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Sex.male;
      case 1:
        return Sex.female;
      default:
        return Sex.male;
    }
  }

  @override
  void write(BinaryWriter writer, Sex obj) {
    switch (obj) {
      case Sex.male:
        writer.writeByte(0);
        break;
      case Sex.female:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SexAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LiteracyLevelAdapter extends TypeAdapter<LiteracyLevel> {
  @override
  final int typeId = 3;

  @override
  LiteracyLevel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LiteracyLevel.illiterate;
      case 1:
        return LiteracyLevel.readWrite;
      case 2:
        return LiteracyLevel.readOnly;
      case 3:
        return LiteracyLevel.signatureOnly;
      default:
        return LiteracyLevel.illiterate;
    }
  }

  @override
  void write(BinaryWriter writer, LiteracyLevel obj) {
    switch (obj) {
      case LiteracyLevel.illiterate:
        writer.writeByte(0);
        break;
      case LiteracyLevel.readWrite:
        writer.writeByte(1);
        break;
      case LiteracyLevel.readOnly:
        writer.writeByte(2);
        break;
      case LiteracyLevel.signatureOnly:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LiteracyLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OccupationAdapter extends TypeAdapter<Occupation> {
  @override
  final int typeId = 4;

  @override
  Occupation read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Occupation.domestic;
      case 1:
        return Occupation.farmer;
      case 2:
        return Occupation.agriculturalLabour;
      case 3:
        return Occupation.casualLabour;
      case 4:
        return Occupation.mgnrega;
      case 5:
        return Occupation.salariedNonAgricultural;
      case 6:
        return Occupation.ownAccountEmployment;
      case 7:
        return Occupation.collectiveNonAgricultural;
      case 8:
        return Occupation.unableToWork;
      case 9:
        return Occupation.student;
      case 10:
        return Occupation.salariedGovernment;
      case 11:
        return Occupation.other;
      default:
        return Occupation.domestic;
    }
  }

  @override
  void write(BinaryWriter writer, Occupation obj) {
    switch (obj) {
      case Occupation.domestic:
        writer.writeByte(0);
        break;
      case Occupation.farmer:
        writer.writeByte(1);
        break;
      case Occupation.agriculturalLabour:
        writer.writeByte(2);
        break;
      case Occupation.casualLabour:
        writer.writeByte(3);
        break;
      case Occupation.mgnrega:
        writer.writeByte(4);
        break;
      case Occupation.salariedNonAgricultural:
        writer.writeByte(5);
        break;
      case Occupation.ownAccountEmployment:
        writer.writeByte(6);
        break;
      case Occupation.collectiveNonAgricultural:
        writer.writeByte(7);
        break;
      case Occupation.unableToWork:
        writer.writeByte(8);
        break;
      case Occupation.student:
        writer.writeByte(9);
        break;
      case Occupation.salariedGovernment:
        writer.writeByte(10);
        break;
      case Occupation.other:
        writer.writeByte(11);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OccupationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
