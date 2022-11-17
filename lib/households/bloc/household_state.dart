part of 'household_bloc.dart';

class HouseholdState extends Equatable {
  const HouseholdState();

  @override
  List<Object> get props => [];
}

class HouseholdInitial extends HouseholdState {
  const HouseholdInitial() : super();
}

class HouseholdLoaded extends HouseholdState {
  final Household household;
  const HouseholdLoaded(this.household) : super();
}

class HouseholdNotFound extends HouseholdState {
  const HouseholdNotFound() : super();
}
