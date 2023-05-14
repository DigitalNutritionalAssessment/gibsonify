import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

part 'analysis_event.dart';
part 'analysis_state.dart';

class FlatCollection {
  final String householdId;
  final String respondentId;
  final String respondentName;
  final GibsonsForm collection;

  const FlatCollection(
      {required this.householdId,
      required this.respondentId,
      required this.respondentName,
      required this.collection});
}

class AnalysisBloc extends Bloc<AnalysisEvent, AnalysisState> {
  final GibsonifyRepository _gibsonifyRepository;
  final HiveRepository _hiveRepository;
  final FCTRepository _fctRepository;

  AnalysisBloc(
      {required gibsonifyRepository,
      required hiveRepository,
      required fctRepository,
      required String surveyId})
      : _gibsonifyRepository = gibsonifyRepository,
        _hiveRepository = hiveRepository,
        _fctRepository = fctRepository,
        super(AnalysisState(surveyId: surveyId)) {
    on<AnalysisStarted>(_onAnalysisStarted);
  }

  void _onAnalysisStarted(
      AnalysisStarted event, Emitter<AnalysisState> emit) async {
    final survey = _hiveRepository.readSurvey(state.surveyId)!;
    final households = _hiveRepository.readHouseholds();
    final collections = <FlatCollection>[];

    for (final household in households) {
      for (final respondent in household.respondents.values) {
        for (final collection in respondent.collections.values) {
          collections.add(FlatCollection(
              householdId: household.householdId,
              respondentId: respondent.id,
              respondentName: respondent.name,
              collection: collection));
        }
      }
    }

    emit(state.copyWith(survey: survey, collections: collections));
  }
}
