part of 'surveys_bloc.dart';

class SurveysState extends Equatable {
  const SurveysState({
    this.surveys = const [],
    this.fctIds = const [],
    this.selectedSurveyIndex,
  });

  final List<Survey> surveys;
  final List<String> fctIds;
  final int? selectedSurveyIndex;

  SurveysState copyWith({
    List<Survey>? surveys,
    List<String>? fctIds,
    int? selectedSurveyIndex,
  }) {
    return SurveysState(
      surveys: surveys ?? this.surveys,
      fctIds: fctIds ?? this.fctIds,
      selectedSurveyIndex: selectedSurveyIndex ?? this.selectedSurveyIndex,
    );
  }

  @override
  List<Object?> get props => [surveys, fctIds, selectedSurveyIndex];
}
