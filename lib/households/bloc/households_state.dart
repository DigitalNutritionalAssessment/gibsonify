part of 'households_bloc.dart';

class HouseholdsState extends Equatable {
  const HouseholdsState({
    this.households = const [],
    this.subscription,
  });

  final List<Household> households;
  final StreamSubscription<void>? subscription;

  HouseholdsState copyWith({
    List<Household>? households,
    StreamSubscription<void>? subscription,
  }) {
    return HouseholdsState(
      households: households ?? this.households,
      subscription: subscription ?? this.subscription,
    );
  }

  @override
  List<Object?> get props => [households, subscription];
}
