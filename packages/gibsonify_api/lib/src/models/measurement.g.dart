// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MeasurementAdapter extends TypeAdapter<Measurement> {
  @override
  final int typeId = 8;

  @override
  Measurement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Measurement(
      method: fields[0] as String?,
      unit: fields[1] as String?,
      value: fields[2] as String?,
      id: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Measurement obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.method)
      ..writeByte(1)
      ..write(obj.unit)
      ..writeByte(2)
      ..write(obj.value)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeasurementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Measurement _$MeasurementFromJson(Map<String, dynamic> json) => Measurement(
      method: json['method'] as String?,
      unit: json['unit'] as String?,
      value: json['value'] as String?,
      id: json['id'] as String? ?? "",
    );

Map<String, dynamic> _$MeasurementToJson(Measurement instance) =>
    <String, dynamic>{
      'method': instance.method,
      'unit': instance.unit,
      'value': instance.value,
      'id': instance.id,
    };
