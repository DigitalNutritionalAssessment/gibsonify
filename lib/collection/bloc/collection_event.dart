part of 'collection_bloc.dart';

abstract class CollectionEvent extends Equatable {
  const CollectionEvent();

  @override
  List<Object> get props => [];
}

class HouseholdIdChanged extends CollectionEvent {
  final String householdId;

  const HouseholdIdChanged({required this.householdId});

  @override
  List<Object> get props => [householdId];
}

class HouseholdIdUnfocused extends CollectionEvent {}

class RespondentNameChanged extends CollectionEvent {
  final String respondentName;

  const RespondentNameChanged({required this.respondentName});

  @override
  List<Object> get props => [respondentName];
}

class RespondentNameUnfocused extends CollectionEvent {}

class RespondentTelNumberChanged extends CollectionEvent {
  final String respondentTelNumber;

  const RespondentTelNumberChanged({required this.respondentTelNumber});

  @override
  List<Object> get props => [respondentTelNumber];
}

class RespondentTelNumberUnfocused extends CollectionEvent {}

class InterviewDateChanged extends CollectionEvent {
  final String interviewDate;

  const InterviewDateChanged({required this.interviewDate});

  @override
  List<Object> get props => [interviewDate];
}

class InterviewDateUnfocused extends CollectionEvent {}
