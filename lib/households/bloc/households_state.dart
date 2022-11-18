part of 'households_bloc.dart';

class HouseholdsState extends Equatable {
  const HouseholdsState({
    this.households = const [],
  });

  final List<Household> households;

  HouseholdsState copyWith({
    List<Household>? households,
  }) {
    return HouseholdsState(
      households: households ?? this.households,
    );
  }

  @override
  List<Object?> get props => [
        households,
      ];
}
