part of 'household_bloc.dart';

class HouseholdState extends Equatable {
  final Household? household;
  final int? selectedRespondentIndex;

  const HouseholdState({this.household, this.selectedRespondentIndex});

  @override
  List<Object?> get props => [household, selectedRespondentIndex];
}

class HouseholdInitial extends HouseholdState {
  const HouseholdInitial() : super();
}

class HouseholdLoaded extends HouseholdState {
  const HouseholdLoaded(
      {required Household household, int? selectedRespondentIndex})
      : super(
            household: household,
            selectedRespondentIndex: selectedRespondentIndex);
}

class HouseholdNotFound extends HouseholdState {
  const HouseholdNotFound() : super();
}
