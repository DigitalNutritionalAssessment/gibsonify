import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

part 'edit_household_event.dart';
part 'edit_household_state.dart';

class EditHouseholdBloc extends Bloc<EditHouseholdEvent, EditHouseholdState> {
  final IsarRepository _isarRepository;

  EditHouseholdBloc({
    required IsarRepository isarRepository,
  })  : _isarRepository = isarRepository,
        super(const EditHouseholdState()) {
    on<EditHouseholdOpened>(_onEditHouseholdOpened);
    on<EditHouseholdSaveRequested>(_onEditHouseholdSaveRequested);
  }

  void _onEditHouseholdOpened(
      EditHouseholdOpened event, Emitter<EditHouseholdState> emit) async {
    final household = await _isarRepository.readHousehold(event.id);
    if (household == null) {
      throw Exception('Household not found');
    }

    emit(EditHouseholdLoaded(household));
  }

  void _onEditHouseholdSaveRequested(EditHouseholdSaveRequested event,
      Emitter<EditHouseholdState> emit) async {
    if (state is EditHouseholdLoaded) {
      Household household = state.household!.copyWith(
          geoLocation: event.geoLocation,
          sensitizationDate: event.sensitizationDate,
          comments: event.comments);
      household.id = state.household!.id;
      await _isarRepository.saveNewHousehold(household);
    }
  }
}
