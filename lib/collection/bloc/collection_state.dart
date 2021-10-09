part of 'collection_bloc.dart';

class CollectionState extends Equatable {
  final HouseholdId householdId;
  final RespondentName respondentName;
  final InterviewDate interviewDate;
  final RespondentTelNumber respondentTelNumber;
  final FormzStatus sensitizationStatus;

  const CollectionState(
      {this.householdId = const HouseholdId.pure(),
      this.respondentName = const RespondentName.pure(),
      this.respondentTelNumber = const RespondentTelNumber.pure(),
      this.interviewDate = const InterviewDate.pure(),
      this.sensitizationStatus = FormzStatus.pure});

  CollectionState copyWith(
      {HouseholdId? householdId,
      RespondentName? respondentName,
      InterviewDate? interviewDate,
      RespondentTelNumber? respondentTelNumber,
      FormzStatus? sensitizationStatus}) {
    return CollectionState(
        householdId: householdId ?? this.householdId,
        respondentName: respondentName ?? this.respondentName,
        respondentTelNumber: respondentTelNumber ?? this.respondentTelNumber,
        interviewDate: interviewDate ?? this.interviewDate,
        sensitizationStatus: sensitizationStatus ?? this.sensitizationStatus);
  }

  @override
  List<Object> get props => [
        householdId,
        respondentName,
        sensitizationStatus,
        respondentTelNumber,
        interviewDate
      ];
}
