part of 'edit_household_bloc.dart';

abstract class EditHouseholdEvent extends Equatable {
  const EditHouseholdEvent();

  @override
  List<Object> get props => [];
}

class EditHouseholdOpened extends EditHouseholdEvent {
  final int id;

  const EditHouseholdOpened({required this.id});

  @override
  List<Object> get props => [id];
}

class EditHouseholdSaveRequested extends EditHouseholdEvent {
  final DateTime sensitizationDate;
  final String geoLocation;
  final String comments;

  const EditHouseholdSaveRequested(
      {required this.sensitizationDate,
      required this.geoLocation,
      required this.comments});

  @override
  List<Object> get props => [sensitizationDate, geoLocation, comments];
}
