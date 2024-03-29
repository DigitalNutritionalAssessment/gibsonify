// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anthropometrics.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnthropometricsAdapter extends TypeAdapter<Anthropometrics> {
  @override
  final int typeId = 13;

  @override
  Anthropometrics read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Anthropometrics(
      date: fields[0] as DateTime,
      weight: fields[2] as double?,
      height: fields[1] as double?,
      waist: fields[3] as double?,
      armLength: fields[4] as double?,
      handSpan: fields[5] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Anthropometrics obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.height)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.waist)
      ..writeByte(4)
      ..write(obj.armLength)
      ..writeByte(5)
      ..write(obj.handSpan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnthropometricsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Anthropometrics _$AnthropometricsFromJson(Map<String, dynamic> json) =>
    Anthropometrics(
      date: DateTime.parse(json['date'] as String),
      weight: (json['weight'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      waist: (json['waist'] as num?)?.toDouble(),
      armLength: (json['armLength'] as num?)?.toDouble(),
      handSpan: (json['handSpan'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AnthropometricsToJson(Anthropometrics instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'height': instance.height,
      'weight': instance.weight,
      'waist': instance.waist,
      'armLength': instance.armLength,
      'handSpan': instance.handSpan,
    };
