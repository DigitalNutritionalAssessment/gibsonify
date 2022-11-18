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
  }

  void _onHouseholdOpened(event, emit) async {
    final household = await _isarRepository.readHousehold(event.id);
    if (household != null) {
      emit(HouseholdLoaded(household));
    } else {
      emit(const HouseholdNotFound());
    }
  }
}
