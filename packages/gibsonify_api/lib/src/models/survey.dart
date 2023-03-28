import 'package:equatable/equatable.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:isar/isar.dart';

part 'survey.g.dart';

@Collection(inheritance: false)
class Survey extends Equatable {
  final Id id;
  @Index(unique: true, replace: true)
  final String surveyId;
  final String name;
  final String country;
  final String? description;
  final String? comments;
  final int? minAge;
  final int? maxAge;
  @Enumerated(EnumType.ordinal32)
  final Sex? requiredSex;

  Survey(
      {this.id = Isar.autoIncrement,
      required this.surveyId,
      required this.name,
      required this.country,
      this.description,
      this.comments,
      this.minAge,
      this.maxAge,
      this.requiredSex});

  Survey copyWith(
      {Id? id,
      String? surveyId,
      String? name,
      String? country,
      String? description,
      String? comments,
      int? minAge,
      int? maxAge,
      Sex? requiredSex}) {
    return Survey(
        id: id ?? this.id,
        surveyId: surveyId ?? this.surveyId,
        name: name ?? this.name,
        country: country ?? this.country,
        description: description ?? this.description,
        comments: comments ?? this.comments,
        minAge: minAge ?? this.minAge,
        maxAge: maxAge ?? this.maxAge,
        requiredSex: requiredSex ?? this.requiredSex);
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
      'requiredSex': requiredSex
    };
  }

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
        surveyId: json['surveyId'],
        name: json['name'],
        country: json['country'],
        description: json['description'],
        comments: json['comments'],
        minAge: json['minAge'],
        maxAge: json['maxAge'],
        requiredSex: json['requiredSex']);
  }

  @override
  @ignore
  List<Object?> get props => [
        id,
        surveyId,
        name,
        country,
        description,
        comments,
        minAge,
        maxAge,
        requiredSex
      ];
}
