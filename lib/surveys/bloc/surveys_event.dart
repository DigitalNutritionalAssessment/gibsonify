part of 'surveys_bloc.dart';

abstract class SurveysEvent extends Equatable {
  const SurveysEvent();

  @override
  List<Object> get props => [];
}

class SurveysPageOpened extends SurveysEvent {
  const SurveysPageOpened();

  @override
  List<Object> get props => [];
}

class SurveyDeleteRequested extends SurveysEvent {
  final String id;
  const SurveyDeleteRequested({required this.id});

  @override
  List<Object> get props => [id];
}

class SurveySaveRequested extends SurveysEvent {
  final Survey survey;
  const SurveySaveRequested({required this.survey});

  @override
  List<Object> get props => [];
}
