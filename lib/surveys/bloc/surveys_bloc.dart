import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

part 'surveys_event.dart';
part 'surveys_state.dart';

class SurveysBloc extends Bloc<SurveysEvent, SurveysState> {
  final IsarRepository _isarRepository;

  SurveysBloc({
    required IsarRepository isarRepository,
  })  : _isarRepository = isarRepository,
        super(const SurveysState()) {
    on<SurveysPageOpened>(_onSurveysPageOpened);
    on<SurveySaveRequested>(_onSurveySaveRequested);
    on<SurveyDeleteRequested>(_onSurveyDeleteRequested);
    on<SurveyOpened>(_onSurveyOpened);
  }

  void _onSurveysPageOpened(
      SurveysPageOpened event, Emitter<SurveysState> emit) async {
    final surveys = await _isarRepository.readSurveys();
    emit(state.copyWith(surveys: surveys));
  }

  void _onSurveySaveRequested(
      SurveySaveRequested event, Emitter<SurveysState> emit) async {
    await _isarRepository.saveSurvey(event.survey);
    add(const SurveysPageOpened());
  }

  void _onSurveyDeleteRequested(
      SurveyDeleteRequested event, Emitter<SurveysState> emit) async {
    await _isarRepository.deleteSurvey(event.id);
    add(const SurveysPageOpened());
  }

  void _onSurveyOpened(SurveyOpened event, Emitter<SurveysState> emit) async {
    emit(state.copyWith(selectedSurveyIndex: event.index));
  }
}
