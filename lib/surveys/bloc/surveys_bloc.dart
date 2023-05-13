import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

part 'surveys_event.dart';
part 'surveys_state.dart';

class SurveysBloc extends Bloc<SurveysEvent, SurveysState> {
  final HiveRepository _hiveRepository;
  final FCTRepository _fctRepository;

  SurveysBloc(
      {required HiveRepository hiveRepository,
      required FCTRepository fctRepository})
      : _hiveRepository = hiveRepository,
        _fctRepository = fctRepository,
        super(const SurveysState()) {
    on<SurveysPageOpened>(_onSurveysPageOpened);
    on<SurveySaveRequested>(_onSurveySaveRequested);
    on<SurveyDeleteRequested>(_onSurveyDeleteRequested);
  }

  void _onSurveysPageOpened(
      SurveysPageOpened event, Emitter<SurveysState> emit) {
    final surveys = _hiveRepository.readSurveys();
    final fctIds = _fctRepository.getFCTIds();
    emit(state.copyWith(surveys: surveys.toList(), fctIds: fctIds.toList()));
  }

  void _onSurveySaveRequested(
      SurveySaveRequested event, Emitter<SurveysState> emit) {
    _hiveRepository.saveSurvey(event.survey);
    add(const SurveysPageOpened());
  }

  void _onSurveyDeleteRequested(
      SurveyDeleteRequested event, Emitter<SurveysState> emit) {
    _hiveRepository.deleteSurvey(event.id);
    add(const SurveysPageOpened());
  }
}
