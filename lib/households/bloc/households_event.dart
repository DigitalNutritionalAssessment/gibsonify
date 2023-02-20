part of 'households_bloc.dart';

abstract class HouseholdsEvent extends Equatable {
  const HouseholdsEvent();

  @override
  List<Object> get props => [];
}

class HouseholdsPageOpened extends HouseholdsEvent {
  const HouseholdsPageOpened();

  @override
  List<Object> get props => [];
}

class HouseholdDeleteRequested extends HouseholdsEvent {
  final int id;
  const HouseholdDeleteRequested({required this.id});

  @override
  List<Object> get props => [id];
}

class HouseholdsUpdateRequested extends HouseholdsEvent {
  const HouseholdsUpdateRequested();

  @override
  List<Object> get props => [];
}

class NewHouseholdSaveRequested extends HouseholdsEvent {
  final Household household;

  const NewHouseholdSaveRequested({required this.household});

  @override
  List<Object> get props => [household];
}
