part of 'create_household_bloc.dart';

class CreateHouseholdState extends Equatable {
  const CreateHouseholdState({
    this.households = const [],
  });

  final List<Household> households;

  CreateHouseholdState copyWith({
    List<Household>? households,
  }) {
    return CreateHouseholdState(
      households: households ?? this.households,
    );
  }

  @override
  List<Object?> get props => [
        households,
      ];
}
