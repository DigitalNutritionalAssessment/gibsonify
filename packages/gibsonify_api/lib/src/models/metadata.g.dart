// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MetadataAdapter extends TypeAdapter<Metadata> {
  @override
  final int typeId = 15;

  @override
  Metadata read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Metadata(
      createdAt: fields[0] as DateTime,
      createdBy: fields[1] as String,
      lastModifiedAt: fields[2] as DateTime,
      lastModifiedBy: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Metadata obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.createdAt)
      ..writeByte(1)
      ..write(obj.createdBy)
      ..writeByte(2)
      ..write(obj.lastModifiedAt)
      ..writeByte(3)
      ..write(obj.lastModifiedBy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MetadataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
