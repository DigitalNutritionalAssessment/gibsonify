part of 'create_household_bloc.dart';

abstract class CreateHouseholdEvent extends Equatable {
  const CreateHouseholdEvent();

  @override
  List<Object> get props => [];
}

class NewHouseholdSaveRequested extends CreateHouseholdEvent {
  final Household household;

  const NewHouseholdSaveRequested({required this.household});

  @override
  List<Object> get props => [household];
}
