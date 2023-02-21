import 'package:equatable/equatable.dart';
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

  Survey(
      {this.id = Isar.autoIncrement,
      required this.surveyId,
      required this.name,
      required this.country,
      this.description,
      this.comments});

  Survey copyWith(
      {Id? id,
      String? surveyId,
      String? name,
      String? country,
      String? description,
      String? comments}) {
    return Survey(
        id: id ?? this.id,
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
  @ignore
  List<Object?> get props =>
      [id, surveyId, name, country, description, comments];
}
