part of 'household_bloc.dart';

class HouseholdState extends Equatable {
  final Household? household;
  final int? selectedRespondentIndex;
  final int? selectedCollectionIndex;

  const HouseholdState(
      {this.household,
      this.selectedRespondentIndex,
      this.selectedCollectionIndex});

  @override
  List<Object?> get props =>
      [household, selectedRespondentIndex, selectedCollectionIndex];
}

class HouseholdInitial extends HouseholdState {
  const HouseholdInitial() : super();
}

class HouseholdLoaded extends HouseholdState {
  const HouseholdLoaded(
      {required Household household,
      int? selectedRespondentIndex,
      int? selectedCollectionIndex})
      : super(
            household: household,
            selectedRespondentIndex: selectedRespondentIndex,
            selectedCollectionIndex: selectedCollectionIndex);
}

class HouseholdNotFound extends HouseholdState {
  const HouseholdNotFound() : super();
}
