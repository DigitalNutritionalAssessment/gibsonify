import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

part 'household_event.dart';
part 'household_state.dart';

class HouseholdBloc extends Bloc<HouseholdEvent, HouseholdState> {
  final HiveRepository _hiveRepository;
  HouseholdBloc({
    required HiveRepository hiveRepository,
  })  : _hiveRepository = hiveRepository,
        super(const HouseholdInitial()) {
    on<HouseholdOpened>(_onHouseholdOpened);
    on<EditHouseholdSaveRequested>(_onEditHouseholdSaveRequested);
    on<NewRespondentSaveRequested>(_onNewRespondentSaveRequested);
    on<DeleteRespondentRequested>(_onDeleteRespondentRequested);
    on<RespondentOpened>(_onRespondentOpened);
    on<EditRespondentSaveRequested>(_onEditRespondentSaveRequested);
    on<SaveCollectionRequested>(_onSaveCollectionRequested);
    on<CollectionOpened>(_onCollectionOpened);
    on<DeleteCollectionRequested>(_onDeleteCollectionRequested);
    on<NewAnthropometricsSaveRequested>(_onNewAnthropometricsSaveRequested);
    on<DeleteAnthropometricsRequested>(_onDeleteAnthropometricsRequested);
  }

  void _onHouseholdOpened(HouseholdOpened event, Emitter<HouseholdState> emit) {
    final household = _hiveRepository.readHousehold(event.id);
    if (household != null) {
      emit(HouseholdLoaded(household: household));
    } else {
      emit(const HouseholdNotFound());
    }
  }

  void _onEditHouseholdSaveRequested(
      EditHouseholdSaveRequested event, Emitter<HouseholdState> emit) {
    Household household = state.household!.copyWith(
        geoLocation: event.geoLocation,
        sensitizationDate: event.sensitizationDate,
        comments: event.comments,
        metadata:
            state.household!.metadata.modify(lastModifiedBy: event.employeeId));
    _hiveRepository.saveNewHousehold(household);
    emit(HouseholdLoaded(household: household));
  }

  void _onNewRespondentSaveRequested(
      NewRespondentSaveRequested event, Emitter<HouseholdState> emit) {
    var respondents = {...state.household!.respondents};
    respondents[event.respondent.id] = event.respondent;
    final household = state.household!.copyWith(respondents: respondents);
    _hiveRepository.saveNewHousehold(household);
    emit(HouseholdLoaded(household: household));
  }

  void _onDeleteRespondentRequested(
      DeleteRespondentRequested event, Emitter<HouseholdState> emit) {
    var respondents = {...state.household!.respondents};
    respondents.remove(event.id);
    final household = state.household!.copyWith(respondents: respondents);
    _hiveRepository.saveNewHousehold(household);
    emit(HouseholdLoaded(household: household));
  }

  void _onRespondentOpened(
      RespondentOpened event, Emitter<HouseholdState> emit) {
    emit(HouseholdLoaded(
        household: state.household!, selectedRespondentId: event.id));
  }

  void _onEditRespondentSaveRequested(
      EditRespondentSaveRequested event, Emitter<HouseholdState> emit) {
    var respondents = {...state.household!.respondents};
    respondents[state.selectedRespondentId!] = event.respondent;
    final household = state.household!.copyWith(respondents: respondents);
    _hiveRepository.saveNewHousehold(household);
    emit(HouseholdLoaded(
        household: household,
        selectedRespondentId: state.selectedRespondentId!));
  }

  void _onCollectionOpened(
      CollectionOpened event, Emitter<HouseholdState> emit) async {
    emit(HouseholdLoaded(
        household: state.household!,
        selectedRespondentId: state.selectedRespondentId!,
        selectedCollectionId: event.id));
  }

  void _onSaveCollectionRequested(
      SaveCollectionRequested event, Emitter<HouseholdState> emit) {
    var respondents = {...state.household!.respondents};
    var respondent = respondents[state.selectedRespondentId!]!;
    final collections = {...respondent.collections};
    collections[event.gibsonsForm.id] = event.gibsonsForm;
    respondents[state.selectedRespondentId!] =
        respondent.copyWith(collections: collections);
    final household = state.household!.copyWith(respondents: respondents);
    _hiveRepository.saveNewHousehold(household);
    emit(HouseholdLoaded(
        household: household,
        selectedRespondentId: state.selectedRespondentId!));
  }

  void _onDeleteCollectionRequested(
      DeleteCollectionRequested event, Emitter<HouseholdState> emit) {
    final respondent =
        state.household!.respondents[state.selectedRespondentId!]!;
    final collections = {...respondent.collections};
    collections.remove(event.id);
    final updatedRespondent = respondent.copyWith(collections: collections);
    var respondents = {...state.household!.respondents};
    respondents[state.selectedRespondentId!] = updatedRespondent;
    final household = state.household!.copyWith(respondents: respondents);
    _hiveRepository.saveNewHousehold(household);
    emit(HouseholdLoaded(
        household: household,
        selectedRespondentId: state.selectedRespondentId!));
  }

  void _onNewAnthropometricsSaveRequested(
      NewAnthropometricsSaveRequested event, Emitter<HouseholdState> emit) {
    final respondent =
        state.household!.respondents[state.selectedRespondentId!]!;
    final updatedRespondent = respondent.copyWith(anthropometrics: [
      ...respondent.anthropometrics,
      event.anthropometrics
    ]);
    var respondents = {...state.household!.respondents};
    respondents[state.selectedRespondentId!] = updatedRespondent;
    final household = state.household!.copyWith(respondents: respondents);
    _hiveRepository.saveNewHousehold(household);
    emit(HouseholdLoaded(
        household: household,
        selectedRespondentId: state.selectedRespondentId!));
  }

  void _onDeleteAnthropometricsRequested(
      DeleteAnthropometricsRequested event, Emitter<HouseholdState> emit) {
    final respondent =
        state.household!.respondents[state.selectedRespondentId!]!;
    final anthropometrics = respondent.anthropometrics.toList();
    anthropometrics.removeAt(event.index);
    final updatedRespondent =
        respondent.copyWith(anthropometrics: anthropometrics);
    var respondents = {...state.household!.respondents};
    respondents[state.selectedRespondentId!] = updatedRespondent;
    final household = state.household!.copyWith(respondents: respondents);
    _hiveRepository.saveNewHousehold(household);
    emit(HouseholdLoaded(
        household: household,
        selectedRespondentId: state.selectedRespondentId!));
  }
}
