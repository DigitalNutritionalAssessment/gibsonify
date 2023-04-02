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
        comments: event.comments);
    _hiveRepository.saveNewHousehold(household);
    emit(HouseholdLoaded(household: household));
  }

  void _onNewRespondentSaveRequested(
      NewRespondentSaveRequested event, Emitter<HouseholdState> emit) {
    final household = state.household!.copyWith(
        respondents: [...state.household!.respondents, event.respondent]);
    _hiveRepository.saveNewHousehold(household);
    emit(HouseholdLoaded(household: household));
  }

  void _onDeleteRespondentRequested(
      DeleteRespondentRequested event, Emitter<HouseholdState> emit) {
    var respondents = state.household!.respondents.toList();
    final household = state.household!
        .copyWith(respondents: respondents..removeAt(event.index));
    _hiveRepository.saveNewHousehold(household);
    emit(HouseholdLoaded(household: household));
  }

  void _onRespondentOpened(
      RespondentOpened event, Emitter<HouseholdState> emit) {
    emit(HouseholdLoaded(
        household: state.household!, selectedRespondentIndex: event.index));
  }

  void _onEditRespondentSaveRequested(
      EditRespondentSaveRequested event, Emitter<HouseholdState> emit) {
    var respondents = state.household!.respondents.toList();
    respondents[state.selectedRespondentIndex!] = event.respondent;
    final household = state.household!.copyWith(respondents: respondents);
    _hiveRepository.saveNewHousehold(household);
    emit(HouseholdLoaded(
        household: household,
        selectedRespondentIndex: state.selectedRespondentIndex!));
  }

  void _onCollectionOpened(
      CollectionOpened event, Emitter<HouseholdState> emit) async {
    emit(HouseholdLoaded(
        household: state.household!,
        selectedRespondentIndex: state.selectedRespondentIndex!,
        selectedCollectionIndex: event.index));
  }

  void _onSaveCollectionRequested(
      SaveCollectionRequested event, Emitter<HouseholdState> emit) {
    final respondent =
        state.household!.respondents[state.selectedRespondentIndex!];
    late Respondent updatedRespondent;

    if (state.selectedCollectionIndex == null) {
      // New collection
      updatedRespondent = respondent.copyWith(
          collections: [...respondent.collections, event.gibsonsForm]);
    } else {
      // Modified collection
      final collections = respondent.collections.toList();
      collections[state.selectedCollectionIndex!] = event.gibsonsForm;
      updatedRespondent = respondent.copyWith(collections: collections);
    }

    var respondents = state.household!.respondents.toList();
    respondents[state.selectedRespondentIndex!] = updatedRespondent;
    final household = state.household!.copyWith(respondents: respondents);
    _hiveRepository.saveNewHousehold(household);
    emit(HouseholdLoaded(
        household: household,
        selectedRespondentIndex: state.selectedRespondentIndex!));
  }

  void _onDeleteCollectionRequested(
      DeleteCollectionRequested event, Emitter<HouseholdState> emit) {
    final respondent =
        state.household!.respondents[state.selectedRespondentIndex!];
    final collections = respondent.collections.toList();
    collections.removeAt(event.index);
    final updatedRespondent = respondent.copyWith(collections: collections);
    var respondents = state.household!.respondents.toList();
    respondents[state.selectedRespondentIndex!] = updatedRespondent;
    final household = state.household!.copyWith(respondents: respondents);
    _hiveRepository.saveNewHousehold(household);
    emit(HouseholdLoaded(
        household: household,
        selectedRespondentIndex: state.selectedRespondentIndex!));
  }

  void _onNewAnthropometricsSaveRequested(
      NewAnthropometricsSaveRequested event, Emitter<HouseholdState> emit) {
    final respondent =
        state.household!.respondents[state.selectedRespondentIndex!];
    final updatedRespondent = respondent.copyWith(anthropometrics: [
      ...respondent.anthropometrics,
      event.anthropometrics
    ]);
    var respondents = state.household!.respondents.toList();
    respondents[state.selectedRespondentIndex!] = updatedRespondent;
    final household = state.household!.copyWith(respondents: respondents);
    _hiveRepository.saveNewHousehold(household);
    emit(HouseholdLoaded(
        household: household,
        selectedRespondentIndex: state.selectedRespondentIndex!));
  }

  void _onDeleteAnthropometricsRequested(
      DeleteAnthropometricsRequested event, Emitter<HouseholdState> emit) {
    final respondent =
        state.household!.respondents[state.selectedRespondentIndex!];
    final anthropometrics = respondent.anthropometrics.toList();
    anthropometrics.removeAt(event.index);
    final updatedRespondent =
        respondent.copyWith(anthropometrics: anthropometrics);
    var respondents = state.household!.respondents.toList();
    respondents[state.selectedRespondentIndex!] = updatedRespondent;
    final household = state.household!.copyWith(respondents: respondents);
    _hiveRepository.saveNewHousehold(household);
    emit(HouseholdLoaded(
        household: household,
        selectedRespondentIndex: state.selectedRespondentIndex!));
  }
}
