import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'survey.g.dart';

class Area {
  final LatLng center;
  final int radius;
  final double zoom;

  Area(this.center, this.radius, this.zoom);
}

@JsonSerializable()
@HiveType(typeId: 14)
class Survey extends Equatable {
  @HiveField(0)
  final String surveyId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String country;
  @HiveField(3)
  final String? description;
  @HiveField(4)
  final String? comments;
  @HiveField(5)
  final int minAge;
  @HiveField(6)
  final int maxAge;
  @HiveField(7)
  final Sex? requiredSex;
  @HiveField(8)
  final String? geoArea;
  @HiveField(9, defaultValue: 'ifct2017')
  final String fctId;

  Survey(
      {required this.surveyId,
      required this.name,
      required this.country,
      this.description,
      this.comments,
      required this.minAge,
      required this.maxAge,
      this.requiredSex,
      this.geoArea,
      required this.fctId});

  Survey copyWith(
      {String? surveyId,
      String? name,
      String? country,
      String? description,
      String? comments,
      int? minAge,
      int? maxAge,
      Sex? requiredSex,
      String? geoArea,
      String? fctId}) {
    return Survey(
        surveyId: surveyId ?? this.surveyId,
        name: name ?? this.name,
        country: country ?? this.country,
        description: description ?? this.description,
        comments: comments ?? this.comments,
        minAge: minAge ?? this.minAge,
        maxAge: maxAge ?? this.maxAge,
        requiredSex: requiredSex ?? this.requiredSex,
        geoArea: geoArea ?? this.geoArea,
        fctId: fctId ?? this.fctId);
  }

  factory Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyToJson(this);

  @override
  List<Object?> get props => [
        surveyId,
        name,
        country,
        description,
        comments,
        minAge,
        maxAge,
        requiredSex,
        geoArea,
        fctId
      ];

  Area getArea() {
    final parts = geoArea!.split(',');
    final center = LatLng(double.parse(parts[0]), double.parse(parts[1]));
    final radius = int.parse(parts[2]);
    final zoom = double.parse(parts[3]);

    return Area(center, radius, zoom);
  }
}
