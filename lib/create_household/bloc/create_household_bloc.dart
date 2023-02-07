import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

part 'create_household_event.dart';
part 'create_household_state.dart';

class CreateHouseholdBloc
    extends Bloc<CreateHouseholdEvent, CreateHouseholdState> {
  final IsarRepository _isarRepository;

  CreateHouseholdBloc({
    required IsarRepository isarRepository,
  })  : _isarRepository = isarRepository,
        super(const CreateHouseholdState()) {
    on<NewHouseholdSaveRequested>(_onNewHouseholdSaveRequested);
  }

  void _onNewHouseholdSaveRequested(NewHouseholdSaveRequested event,
      Emitter<CreateHouseholdState> emit) async {
    // TODO: Handle household ID clash
    await _isarRepository.saveNewHousehold(event.household);
  }
}
