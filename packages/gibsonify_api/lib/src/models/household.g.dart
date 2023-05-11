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
      metadata: fields[5] as Metadata,
    );
  }

  @override
  void write(BinaryWriter writer, Household obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.householdId)
      ..writeByte(1)
      ..write(obj.sensitizationDate)
      ..writeByte(2)
      ..write(obj.geoLocation)
      ..writeByte(3)
      ..write(obj.comments)
      ..writeByte(4)
      ..write(obj.respondents)
      ..writeByte(5)
      ..write(obj.metadata);
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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Household _$HouseholdFromJson(Map<String, dynamic> json) => Household(
      householdId: json['householdId'] as String,
      sensitizationDate: DateTime.parse(json['sensitizationDate'] as String),
      geoLocation: json['geoLocation'] as String,
      comments: json['comments'] as String,
      respondents: (json['respondents'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Respondent.fromJson(e as Map<String, dynamic>)),
      ),
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HouseholdToJson(Household instance) => <String, dynamic>{
      'householdId': instance.householdId,
      'sensitizationDate': instance.sensitizationDate.toIso8601String(),
      'geoLocation': instance.geoLocation,
      'comments': instance.comments,
      'respondents':
          instance.respondents.map((k, e) => MapEntry(k, e.toJson())),
      'metadata': instance.metadata.toJson(),
    };
