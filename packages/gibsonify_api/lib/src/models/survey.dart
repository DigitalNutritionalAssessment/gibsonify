import 'package:equatable/equatable.dart';

class Survey extends Equatable {
  final String surveyId;
  final String name;
  final String country;
  final String? description;
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
