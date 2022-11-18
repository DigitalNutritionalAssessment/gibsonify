part of 'households_bloc.dart';

abstract class HouseholdsEvent extends Equatable {
  const HouseholdsEvent();

  @override
  List<Object> get props => [];
}

class HouseholdsRequested extends HouseholdsEvent {
  const HouseholdsRequested();

  @override
  List<Object> get props => [];
}

class HouseholdDeleteRequested extends HouseholdsEvent {
  final int id;
  const HouseholdDeleteRequested({required this.id});

  @override
  List<Object> get props => [id];
}
