import 'dart:async';

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
    on<HouseholdsPageOpened>(_onHouseholdsPageOpened);
    on<HouseholdsUpdateRequested>(_onHouseholdsUpdateRequested);
    on<HouseholdDeleteRequested>(_onHouseholdDeleteRequested);
    on<NewHouseholdSaveRequested>(_onNewHouseholdSaveRequested);
  }

  void _onHouseholdsPageOpened(
      HouseholdsPageOpened event, Emitter<HouseholdsState> emit) async {
    Stream<void> householdsWatch = _isarRepository.watchHouseholds();
    // Callback fires immediately so no need to manually request an update on initialisation
    final subscription = householdsWatch.listen((event) {
      add(const HouseholdsUpdateRequested());
    });
    emit(state.copyWith(subscription: subscription));
  }

  void _onHouseholdDeleteRequested(
      HouseholdDeleteRequested event, Emitter<HouseholdsState> emit) async {
    await _isarRepository.deleteHousehold(event.id);
  }

  void _onHouseholdsUpdateRequested(
      HouseholdsUpdateRequested event, Emitter<HouseholdsState> emit) async {
    // TODO: implement a subscription to a stream of households
    final households = await _isarRepository.readHouseholds();
    emit(state.copyWith(households: households));
  }

  void _onNewHouseholdSaveRequested(
      NewHouseholdSaveRequested event, Emitter<HouseholdsState> emit) async {
    await _isarRepository.saveNewHousehold(event.household);
  }

  @override
  Future<void> close() async {
    await state.subscription?.cancel();
    return super.close();
  }
}
