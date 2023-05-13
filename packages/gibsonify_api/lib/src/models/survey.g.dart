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
      fctId: fields[9] == null ? 'ifct2017' : fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Survey obj) {
    writer
      ..writeByte(10)
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
      ..write(obj.geoArea)
      ..writeByte(9)
      ..write(obj.fctId);
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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Survey _$SurveyFromJson(Map<String, dynamic> json) => Survey(
      surveyId: json['surveyId'] as String,
      name: json['name'] as String,
      country: json['country'] as String,
      description: json['description'] as String?,
      comments: json['comments'] as String?,
      minAge: json['minAge'] as int,
      maxAge: json['maxAge'] as int,
      requiredSex: $enumDecodeNullable(_$SexEnumMap, json['requiredSex']),
      geoArea: json['geoArea'] as String?,
      fctId: json['fctId'] as String,
    );

Map<String, dynamic> _$SurveyToJson(Survey instance) => <String, dynamic>{
      'surveyId': instance.surveyId,
      'name': instance.name,
      'country': instance.country,
      'description': instance.description,
      'comments': instance.comments,
      'minAge': instance.minAge,
      'maxAge': instance.maxAge,
      'requiredSex': _$SexEnumMap[instance.requiredSex],
      'geoArea': instance.geoArea,
      'fctId': instance.fctId,
    };

const _$SexEnumMap = {
  Sex.male: 'male',
  Sex.female: 'female',
};
