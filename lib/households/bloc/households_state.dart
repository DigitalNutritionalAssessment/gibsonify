part of 'households_bloc.dart';

class HouseholdsState extends Equatable {
  const HouseholdsState({
    this.households = const [],
    this.sortBy = HouseholdsSortBy.householdId,
    this.subscription,
  });

  final List<Household> households;
  final HouseholdsSortBy sortBy;
  final StreamSubscription<void>? subscription;

  HouseholdsState copyWith({
    List<Household>? households,
    HouseholdsSortBy? sortBy,
    StreamSubscription<void>? subscription,
  }) {
    return HouseholdsState(
      households: households ?? this.households,
      sortBy: sortBy ?? this.sortBy,
      subscription: subscription ?? this.subscription,
    );
  }

  @override
  List<Object?> get props => [households, sortBy, subscription];
}
