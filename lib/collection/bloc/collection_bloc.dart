import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:gibsonify/collection/models/models.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  CollectionBloc() : super(const CollectionState()) {
    on<HouseholdIdChanged>(_onHouseholdIdChanged);
    on<RespondentNameChanged>(_onRespondentNameChanged);
    on<RespondentTelNumberChanged>(_onRespondentTelNumberChanged);
    on<InterviewDateChanged>(_onInterviewDateChanged);
    on<HouseholdIdUnfocused>(_onHouseholdIdUnfocused);
    on<RespondentNameUnfocused>(_onRespondentNameUnfocused);
    on<RespondentTelNumberUnfocused>(_onRespondentTelNumberUnfocused);
    on<InterviewDateUnfocused>(_onInterviewDateUnfocused);
  }

  void _onHouseholdIdChanged(
      HouseholdIdChanged event, Emitter<CollectionState> emit) {
    final householdId = HouseholdId.dirty(event.householdId);
    emit(state.copyWith(
        householdId: householdId, // TODO: investigate using pure here
        sensitizationStatus: Formz.validate([
          householdId,
          state.respondentName,
          state.respondentTelNumber,
          state.interviewDate
        ]) // TODO: validate other sensitization fields once added
        ));
  }

  void _onRespondentNameChanged(
      RespondentNameChanged event, Emitter<CollectionState> emit) {
    final respondentName = RespondentName.dirty(event.respondentName);
    emit(state.copyWith(
        respondentName: respondentName,
        sensitizationStatus: Formz.validate([
          state.householdId,
          respondentName,
          state.respondentTelNumber,
          state.interviewDate
        ])));
  }

  void _onRespondentTelNumberChanged(
      RespondentTelNumberChanged event, Emitter<CollectionState> emit) {
    final respondentTelNumber =
        RespondentTelNumber.dirty(event.respondentTelNumber);
    emit(state.copyWith(
        respondentTelNumber: respondentTelNumber,
        sensitizationStatus: Formz.validate([
          state.householdId,
          state.respondentName,
          respondentTelNumber,
          state.interviewDate
        ])));
  }

  void _onInterviewDateChanged(
      InterviewDateChanged event, Emitter<CollectionState> emit) {
    final interviewDate = InterviewDate.dirty(event.interviewDate);
    emit(state.copyWith(
        interviewDate: interviewDate,
        sensitizationStatus: Formz.validate([
          state.householdId,
          state.respondentName,
          state.respondentTelNumber,
          interviewDate
        ])));
  }

  void _onHouseholdIdUnfocused(
      HouseholdIdUnfocused event, Emitter<CollectionState> emit) {
    final householdId = HouseholdId.dirty(state.householdId.value);
    emit(state.copyWith(
      householdId: householdId,
      sensitizationStatus: Formz.validate([
        householdId,
        state.respondentName,
        state.respondentTelNumber,
        state.interviewDate
      ]),
    ));
  }

  void _onRespondentNameUnfocused(
      RespondentNameUnfocused event, Emitter<CollectionState> emit) {
    final respondentName = RespondentName.dirty(state.respondentName.value);
    emit(state.copyWith(
      respondentName: respondentName,
      sensitizationStatus: Formz.validate([
        state.householdId,
        respondentName,
        state.respondentTelNumber,
        state.interviewDate
      ]),
    ));
  }

  void _onRespondentTelNumberUnfocused(
      RespondentTelNumberUnfocused event, Emitter<CollectionState> emit) {
    final respondentTelNumber =
        RespondentTelNumber.dirty(state.respondentTelNumber.value);
    emit(state.copyWith(
      respondentTelNumber: respondentTelNumber,
      sensitizationStatus: Formz.validate([
        state.householdId,
        state.respondentName,
        respondentTelNumber,
        state.interviewDate
      ]),
    ));
  }

  void _onInterviewDateUnfocused(
      InterviewDateUnfocused event, Emitter<CollectionState> emit) {
    final interviewDate = InterviewDate.dirty(state.interviewDate.value);
    emit(state.copyWith(
      interviewDate: interviewDate,
      sensitizationStatus: Formz.validate([
        state.householdId,
        state.respondentName,
        state.respondentTelNumber,
        interviewDate
      ]),
    ));
  }
}
