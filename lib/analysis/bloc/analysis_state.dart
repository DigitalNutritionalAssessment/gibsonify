part of 'analysis_bloc.dart';

class AnalysisState extends Equatable {
  final String surveyId;
  final Survey? survey;
  final List<FlatCollection>? collections;

  const AnalysisState({required this.surveyId, this.survey, this.collections});

  AnalysisState copyWith(
      {String? surveyId, Survey? survey, List<FlatCollection>? collections}) {
    return AnalysisState(
        surveyId: surveyId ?? this.surveyId,
        survey: survey ?? this.survey,
        collections: collections ?? this.collections);
  }

  @override
  List<Object> get props => [surveyId];
}
