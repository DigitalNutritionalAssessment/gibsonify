import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'survey.g.dart';

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

  Survey(
      {required this.surveyId,
      required this.name,
      required this.country,
      this.description,
      this.comments});

  Survey copyWith(
      {String? surveyId,
      String? name,
      String? country,
      String? description,
      String? comments}) {
    return Survey(
        surveyId: surveyId ?? this.surveyId,
        name: name ?? this.name,
        country: country ?? this.country,
        description: description ?? this.description,
        comments: comments ?? this.comments);
  }

  Map<String, dynamic> toJson() {
    return {
      'surveyId': surveyId,
      'name': name,
      'country': country,
      'description': description,
      'comments': comments
    };
  }

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
        surveyId: json['surveyId'],
        name: json['name'],
        country: json['country'],
        description: json['description'],
        comments: json['comments']);
  }

  @override
  List<Object?> get props => [surveyId, name, country, description, comments];
}
