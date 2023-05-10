part of 'household_bloc.dart';

class HouseholdState extends Equatable {
  final Household? household;
  final String? selectedRespondentId;
  final String? selectedCollectionId;

  const HouseholdState(
      {this.household, this.selectedRespondentId, this.selectedCollectionId});

  @override
  List<Object?> get props =>
      [household, selectedRespondentId, selectedCollectionId];
}

class HouseholdInitial extends HouseholdState {
  const HouseholdInitial() : super();
}

class HouseholdLoaded extends HouseholdState {
  const HouseholdLoaded(
      {required Household household,
      String? selectedRespondentId,
      String? selectedCollectionId})
      : super(
            household: household,
            selectedRespondentId: selectedRespondentId,
            selectedCollectionId: selectedCollectionId);
}

class HouseholdNotFound extends HouseholdState {
  const HouseholdNotFound() : super();
}
