part of 'edit_household_bloc.dart';

class EditHouseholdState extends Equatable {
  final Household? household;

  const EditHouseholdState({this.household});

  @override
  List<Object?> get props => [];
}

class EditHouseholdInitial extends EditHouseholdState {
  const EditHouseholdInitial() : super();
}

class EditHouseholdLoaded extends EditHouseholdState {
  const EditHouseholdLoaded(household) : super(household: household);
}
