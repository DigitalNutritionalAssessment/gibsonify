import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

part 'households_event.dart';
part 'households_state.dart';

class HouseholdsBloc extends Bloc<HouseholdsEvent, HouseholdsState> {
  final IsarRepository _isarRepository;

  HouseholdsBloc({
    required IsarRepository isarRepository,
  })  : _isarRepository = isarRepository,
        super(const HouseholdsState()) {
    on<HouseholdsRequested>(_onHouseholdsRequested);
    on<HouseholdDeleteRequested>(_onHouseholdDeleteRequested);
  }

  void _onHouseholdsRequested(
      HouseholdsRequested event, Emitter<HouseholdsState> emit) async {
    // TODO: implement a subscription to a stream of households
    final households = await _isarRepository.readHouseholds();
    emit(state.copyWith(households: households));
  }

  void _onHouseholdDeleteRequested(
      HouseholdDeleteRequested event, Emitter<HouseholdsState> emit) async {
    await _isarRepository.deleteHousehold(event.id);
    add(const HouseholdsRequested());
  }
}
