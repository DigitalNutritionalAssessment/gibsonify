import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:latlong2/latlong.dart';

part 'survey.g.dart';

class Area {
  final LatLng center;
  final int radius;
  final double zoom;

  Area(this.center, this.radius, this.zoom);
}

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

  Survey(
      {required this.surveyId,
      required this.name,
      required this.country,
      this.description,
      this.comments,
      required this.minAge,
      required this.maxAge,
      this.requiredSex,
      this.geoArea});

  Survey copyWith(
      {String? surveyId,
      String? name,
      String? country,
      String? description,
      String? comments,
      int? minAge,
      int? maxAge,
      Sex? requiredSex,
      String? geoArea}) {
    return Survey(
        surveyId: surveyId ?? this.surveyId,
        name: name ?? this.name,
        country: country ?? this.country,
        description: description ?? this.description,
        comments: comments ?? this.comments,
        minAge: minAge ?? this.minAge,
        maxAge: maxAge ?? this.maxAge,
        requiredSex: requiredSex ?? this.requiredSex,
        geoArea: geoArea ?? this.geoArea);
  }

  Map<String, dynamic> toJson() {
    return {
      'surveyId': surveyId,
      'name': name,
      'country': country,
      'description': description,
      'comments': comments,
      'minAge': minAge,
      'maxAge': maxAge,
      'requiredSex': requiredSex?.name,
      'geoArea': geoArea
    };
  }

  factory Survey.fromJson(Map<String, dynamic> json) {
    Sex? requiredSex;

    if (json['requiredSex'] != null) {
      requiredSex = Sex.values
          .singleWhere((element) => element.name == json['requiredSex']);
    }

    return Survey(
        surveyId: json['surveyId'],
        name: json['name'],
        country: json['country'],
        description: json['description'],
        comments: json['comments'],
        minAge: json['minAge'],
        maxAge: json['maxAge'],
        requiredSex: requiredSex,
        geoArea: json['geoArea']);
  }

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
        geoArea
      ];

  Area getArea() {
    final parts = geoArea!.split(',');
    final center = LatLng(double.parse(parts[0]), double.parse(parts[1]));
    final radius = int.parse(parts[2]);
    final zoom = double.parse(parts[3]);

    return Area(center, radius, zoom);
  }
}
