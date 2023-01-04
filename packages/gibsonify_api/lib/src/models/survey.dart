import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'survey.g.dart';

@Collection(inheritance: false)
class Survey extends Equatable {
  final Id id;
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

  @override
  @ignore
  List<Object?> get props =>
      [id, surveyId, name, country, description, comments];
}
