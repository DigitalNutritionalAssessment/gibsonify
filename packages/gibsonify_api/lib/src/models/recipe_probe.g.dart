// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_probe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProbeOptionAdapter extends TypeAdapter<ProbeOption> {
  @override
  final int typeId = 12;

  @override
  ProbeOption read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProbeOption(
      option: fields[0] as String?,
      id: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProbeOption obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.option)
      ..writeByte(1)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProbeOptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProbeAdapter extends TypeAdapter<Probe> {
  @override
  final int typeId = 11;

  @override
  Probe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Probe(
      name: fields[0] as String?,
      checked: fields[1] as bool,
      answer: fields[2] as String?,
      probeOptions: (fields[3] as List).cast<ProbeOption>(),
    );
  }

  @override
  void write(BinaryWriter writer, Probe obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.checked)
      ..writeByte(2)
      ..write(obj.answer)
      ..writeByte(3)
      ..write(obj.probeOptions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProbeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProbeOption _$ProbeOptionFromJson(Map<String, dynamic> json) => ProbeOption(
      option: json['option'] as String?,
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$ProbeOptionToJson(ProbeOption instance) =>
    <String, dynamic>{
      'option': instance.option,
      'id': instance.id,
    };

Probe _$ProbeFromJson(Map<String, dynamic> json) => Probe(
      name: json['name'] as String?,
      checked: json['checked'] as bool? ?? false,
      answer: json['answer'] as String?,
      probeOptions: (json['probeOptions'] as List<dynamic>?)
              ?.map((e) => ProbeOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProbeToJson(Probe instance) => <String, dynamic>{
      'name': instance.name,
      'checked': instance.checked,
      'answer': instance.answer,
      'probeOptions': instance.probeOptions.map((e) => e.toJson()).toList(),
    };
