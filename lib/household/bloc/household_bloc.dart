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
  }

  void _onHouseholdOpened(event, emit) async {
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
}
