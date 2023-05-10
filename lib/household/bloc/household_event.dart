part of 'household_bloc.dart';

abstract class HouseholdEvent extends Equatable {
  const HouseholdEvent();

  @override
  List<Object> get props => [];
}

class HouseholdOpened extends HouseholdEvent {
  final String id;
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
  final String id;

  const DeleteRespondentRequested({required this.id});

  @override
  List<Object> get props => [id];
}

class RespondentOpened extends HouseholdEvent {
  final String id;

  const RespondentOpened({required this.id});

  @override
  List<Object> get props => [id];
}

class EditRespondentSaveRequested extends HouseholdEvent {
  final Respondent respondent;

  const EditRespondentSaveRequested({required this.respondent});

  @override
  List<Object> get props => [respondent];
}

class CollectionOpened extends HouseholdEvent {
  final String id;

  const CollectionOpened({required this.id});

  @override
  List<Object> get props => [id];
}

class SaveCollectionRequested extends HouseholdEvent {
  final GibsonsForm gibsonsForm;

  const SaveCollectionRequested({required this.gibsonsForm});

  @override
  List<Object> get props => [gibsonsForm];
}

class DeleteCollectionRequested extends HouseholdEvent {
  final String id;

  const DeleteCollectionRequested({required this.id});

  @override
  List<Object> get props => [id];
}

class NewAnthropometricsSaveRequested extends HouseholdEvent {
  final Anthropometrics anthropometrics;

  const NewAnthropometricsSaveRequested({required this.anthropometrics});

  @override
  List<Object> get props => [anthropometrics];
}

class DeleteAnthropometricsRequested extends HouseholdEvent {
  final int index;

  const DeleteAnthropometricsRequested({required this.index});

  @override
  List<Object> get props => [index];
}
