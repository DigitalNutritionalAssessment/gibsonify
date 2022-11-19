part of 'household_bloc.dart';

class HouseholdState extends Equatable {
  final Household? household;
  const HouseholdState({this.household});

  @override
  List<Object?> get props => [household];
}

class HouseholdInitial extends HouseholdState {
  const HouseholdInitial() : super();
}

class HouseholdLoaded extends HouseholdState {
  const HouseholdLoaded(household) : super(household: household);
}

class HouseholdNotFound extends HouseholdState {
  const HouseholdNotFound() : super();
}
