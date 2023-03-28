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
  final int minAge;
  final int maxAge;
  @Enumerated(EnumType.ordinal32)
  final Sex? requiredSex;

  Survey(
      {this.id = Isar.autoIncrement,
      required this.surveyId,
      required this.name,
      required this.country,
      this.description,
      this.comments,
      required this.minAge,
      required this.maxAge,
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
      'requiredSex': requiredSex?.name
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
        requiredSex: requiredSex);
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

  List<String> checkParameters({required Respondent respondent}) {
    // TODO: add household location check

    final errors = <String>[];
    final respondentAge =
        DateTime.now().difference(respondent.dateOfBirth!).inDays / 365;

    if (respondentAge < minAge) {
      errors.add('Respondent is too young.');
    }

    if (maxAge != 100 && respondentAge > maxAge) {
      errors.add('Respondent is too old.');
    }

    if (requiredSex != null && respondent.sex != requiredSex) {
      errors.add('Respondent must be ${requiredSex!.name}.');
    }

    return errors;
  }
}
