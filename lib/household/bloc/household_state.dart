part of 'household_bloc.dart';

class HouseholdState extends Equatable {
  final Household? household;
  final String? selectedRespondentId;
  final int? selectedCollectionIndex;

  const HouseholdState(
      {this.household,
      this.selectedRespondentId,
      this.selectedCollectionIndex});

  @override
  List<Object?> get props =>
      [household, selectedRespondentId, selectedCollectionIndex];
}

class HouseholdInitial extends HouseholdState {
  const HouseholdInitial() : super();
}

class HouseholdLoaded extends HouseholdState {
  const HouseholdLoaded(
      {required Household household,
      String? selectedRespondentId,
      int? selectedCollectionIndex})
      : super(
            household: household,
            selectedRespondentId: selectedRespondentId,
            selectedCollectionIndex: selectedCollectionIndex);
}

class HouseholdNotFound extends HouseholdState {
  const HouseholdNotFound() : super();
}
