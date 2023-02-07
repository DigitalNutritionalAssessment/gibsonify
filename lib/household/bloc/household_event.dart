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

class DeleteRespondentRequested extends HouseholdEvent {
  final int index;

  const DeleteRespondentRequested({required this.index});

  @override
  List<Object> get props => [index];
}

class RespondentOpened extends HouseholdEvent {
  final int index;

  const RespondentOpened({required this.index});

  @override
  List<Object> get props => [index];
}

class EditRespondentSaveRequested extends HouseholdEvent {
  final Respondent respondent;

  const EditRespondentSaveRequested({required this.respondent});

  @override
  List<Object> get props => [respondent];
}

class CollectionOpened extends HouseholdEvent {
  final int index;

  const CollectionOpened({required this.index});

  @override
  List<Object> get props => [index];
}

class SaveCollectionRequested extends HouseholdEvent {
  final GibsonsForm gibsonsForm;

  const SaveCollectionRequested({required this.gibsonsForm});

  @override
  List<Object> get props => [gibsonsForm];
}

class DeleteCollectionRequested extends HouseholdEvent {
  final int index;

  const DeleteCollectionRequested({required this.index});

  @override
  List<Object> get props => [index];
}
