import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gibsonify/households/households.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

part 'households_event.dart';
part 'households_state.dart';

class HouseholdsBloc extends Bloc<HouseholdsEvent, HouseholdsState> {
  final IsarRepository _isarRepository;
  StreamSubscription? _locationSubscription;

  HouseholdsBloc({
    required IsarRepository isarRepository,
  })  : _isarRepository = isarRepository,
        super(const HouseholdsState()) {
    on<HouseholdsPageOpened>(_onHouseholdsPageOpened);
    on<HouseholdsUpdateRequested>(_onHouseholdsUpdateRequested);
    on<HouseholdDeleteRequested>(_onHouseholdDeleteRequested);
    on<NewHouseholdSaveRequested>(_onNewHouseholdSaveRequested);
    on<HouseholdsSortOrderUpdated>(_onHouseholdsSortOrderUpdated);
    on<LocationUpdateRequested>(_onLocationUpdateRequested);
    on<LocationUpdated>(_onLocationUpdated);
  }

  void _onHouseholdsPageOpened(
      HouseholdsPageOpened event, Emitter<HouseholdsState> emit) async {
    Stream<void> householdsWatch = _isarRepository.watchHouseholds();
    // Callback fires immediately so no need to manually request an update on initialisation
    final subscription = householdsWatch.listen((event) {
      add(const HouseholdsUpdateRequested());
    });
    emit(state.copyWith(subscription: subscription));

    // Manual refresh is currently preferred over live location
    // streaming due to battery drain concerns. Uncommenting the
    // location subscription will re-enable live location updates.
    add(const LocationUpdateRequested());
    // _locationSubscription = Geolocator.getPositionStream(
    //     locationSettings: const LocationSettings(
    //   accuracy: LocationAccuracy.high,
    //   distanceFilter: 10,
    // )).listen((Position position) {
    //   add(LocationUpdated(position: position));
    // });
  }

  void _onHouseholdDeleteRequested(
      HouseholdDeleteRequested event, Emitter<HouseholdsState> emit) async {
    await _isarRepository.deleteHousehold(event.id);
  }

  void _onHouseholdsUpdateRequested(
      HouseholdsUpdateRequested event, Emitter<HouseholdsState> emit) async {
    late List<Household> households;
    switch (state.sortBy) {
      case HouseholdsSortBy.householdId:
        households = await _isarRepository.readHouseholdsOrderById();
        break;
      case HouseholdsSortBy.sensitizationDate:
        households =
            await _isarRepository.readHouseholdsOrderBySensitizationDate();
        break;
      case HouseholdsSortBy.distance:
        households = await _isarRepository.readHouseholdsOrderById();
        break;
    }

    List<int> distances = [];
    if (state.location != null) {
      for (var household in households) {
        final distance = Geolocator.distanceBetween(state.location!.latitude,
            state.location!.longitude, household.getLat(), household.getLng());
        distances.add(distance.toInt());
      }

      if (state.sortBy == HouseholdsSortBy.distance) {
        List<Map<String, dynamic>> householdsDistances =
            List.generate(households.length, (index) {
          return {'object': households[index], 'distance': distances[index]};
        });

        householdsDistances
            .sort((a, b) => a['distance'].compareTo(b['distance']));
        households =
            householdsDistances.map((e) => e['object'] as Household).toList();
        distances =
            householdsDistances.map((e) => e['distance'] as int).toList();
      }
    }

    emit(state.copyWith(households: households, distances: distances));
  }

  void _onNewHouseholdSaveRequested(
      NewHouseholdSaveRequested event, Emitter<HouseholdsState> emit) async {
    await _isarRepository.saveNewHousehold(event.household);
  }

  void _onHouseholdsSortOrderUpdated(
      HouseholdsSortOrderUpdated event, Emitter<HouseholdsState> emit) async {
    emit(state.copyWith(sortBy: event.sortBy));
    add(const HouseholdsUpdateRequested());
  }

  void _onLocationUpdateRequested(
      LocationUpdateRequested event, Emitter<HouseholdsState> emit) async {
    final position = await getPosition();
    add(LocationUpdated(position: position));
  }

  void _onLocationUpdated(
      LocationUpdated event, Emitter<HouseholdsState> emit) async {
    emit(state.copyWith(location: event.position));
    add(const HouseholdsUpdateRequested());
  }

  @override
  Future<void> close() async {
    await state.subscription?.cancel();
    await _locationSubscription?.cancel();
    return super.close();
  }
}
