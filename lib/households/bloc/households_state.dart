part of 'households_bloc.dart';

class HouseholdsState extends Equatable {
  const HouseholdsState({
    this.households = const [],
    this.distances = const [],
    this.sortBy = HouseholdsSortBy.householdId,
    this.location,
    this.subscription,
  });

  final List<Household> households;
  final List<int> distances;
  final HouseholdsSortBy sortBy;
  final Position? location;
  final StreamSubscription<void>? subscription;

  HouseholdsState copyWith({
    List<Household>? households,
    List<int>? distances,
    HouseholdsSortBy? sortBy,
    Position? location,
    StreamSubscription<void>? subscription,
  }) {
    return HouseholdsState(
      households: households ?? this.households,
      distances: distances ?? this.distances,
      sortBy: sortBy ?? this.sortBy,
      location: location ?? this.location,
      subscription: subscription ?? this.subscription,
    );
  }

  @override
  List<Object?> get props =>
      [households, distances, sortBy, location, subscription];
}
