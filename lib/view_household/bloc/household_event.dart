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

class EditHouseholdSaveRequested extends HouseholdEvent {
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

class NewRespondentSaveRequested extends HouseholdEvent {
  final Respondent respondent;

  const NewRespondentSaveRequested({required this.respondent});

  @override
  List<Object> get props => [respondent];
}
