import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

part 'household_event.dart';
part 'household_state.dart';

class HouseholdBloc extends Bloc<HouseholdEvent, HouseholdState> {
  final IsarRepository _isarRepository;
  HouseholdBloc({
    required IsarRepository isarRepository,
  })  : _isarRepository = isarRepository,
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
  }

  void _onHouseholdOpened(
      HouseholdOpened event, Emitter<HouseholdState> emit) async {
    final household = await _isarRepository.readHousehold(event.id);
    if (household != null) {
      emit(HouseholdLoaded(household: household));
    } else {
      emit(const HouseholdNotFound());
    }
  }

  void _onEditHouseholdSaveRequested(
      EditHouseholdSaveRequested event, Emitter<HouseholdState> emit) async {
    Household household = state.household!.copyWith(
        geoLocation: event.geoLocation,
        sensitizationDate: event.sensitizationDate,
        comments: event.comments);
    await _isarRepository.saveNewHousehold(household);
    emit(HouseholdLoaded(household: household));
  }

  void _onNewRespondentSaveRequested(
      NewRespondentSaveRequested event, Emitter<HouseholdState> emit) async {
    final household = state.household!.copyWith(
        respondents: [...state.household!.respondents, event.respondent]);
    await _isarRepository.saveNewHousehold(household);
    emit(HouseholdLoaded(household: household));
  }

  void _onDeleteRespondentRequested(
      DeleteRespondentRequested event, Emitter<HouseholdState> emit) async {
    var respondents = state.household!.respondents.toList();
    final household = state.household!
        .copyWith(respondents: respondents..removeAt(event.index));
    await _isarRepository.saveNewHousehold(household);
    emit(HouseholdLoaded(household: household));
  }

  void _onRespondentOpened(
      RespondentOpened event, Emitter<HouseholdState> emit) async {
    emit(HouseholdLoaded(
        household: state.household!, selectedRespondentIndex: event.index));
  }

  void _onEditRespondentSaveRequested(
      EditRespondentSaveRequested event, Emitter<HouseholdState> emit) async {
    var respondents = state.household!.respondents.toList();
    respondents[state.selectedRespondentIndex!] = event.respondent;
    final household = state.household!.copyWith(respondents: respondents);
    await _isarRepository.saveNewHousehold(household);
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
    _isarRepository.saveNewHousehold(household);
    emit(HouseholdLoaded(
        household: household,
        selectedRespondentIndex: state.selectedRespondentIndex!));
  }

  void _onDeleteCollectionRequested(
      DeleteCollectionRequested event, Emitter<HouseholdState> emit) async {
    final respondent =
        state.household!.respondents[state.selectedRespondentIndex!];
    final collections = respondent.collections.toList();
    collections.removeAt(event.index);
    final updatedRespondent = respondent.copyWith(collections: collections);
    var respondents = state.household!.respondents.toList();
    respondents[state.selectedRespondentIndex!] = updatedRespondent;
    final household = state.household!.copyWith(respondents: respondents);
    await _isarRepository.saveNewHousehold(household);
    emit(HouseholdLoaded(
        household: household,
        selectedRespondentIndex: state.selectedRespondentIndex!));
  }
}