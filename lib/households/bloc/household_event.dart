part of 'household_bloc.dart';

abstract class HouseholdEvent extends Equatable {
  const HouseholdEvent();

  @override
  List<Object> get props => [];
}

class HouseholdOpened extends HouseholdEvent {
  final int id;
  const HouseholdOpened({required this.id});
}
