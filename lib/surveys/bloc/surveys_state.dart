part of 'surveys_bloc.dart';

class SurveysState extends Equatable {
  const SurveysState({
    this.surveys = const [],
    this.selectedSurveyIndex,
  });

  final List<Survey> surveys;
  final int? selectedSurveyIndex;

  SurveysState copyWith({
    List<Survey>? surveys,
    int? selectedSurveyIndex,
  }) {
    return SurveysState(
      surveys: surveys ?? this.surveys,
      selectedSurveyIndex: selectedSurveyIndex ?? this.selectedSurveyIndex,
    );
  }

  @override
  List<Object?> get props => [
        surveys,
      ];
}
