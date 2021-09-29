import 'package:equatable/equatable.dart';

// TODO: look into changing this from Equatable derived
// class to something else, e.g. Formz derived class
class Collection extends Equatable {
  const Collection(
      {this.householdId,
      this.respondentName,
      this.respondentTelephoneNumber,
      this.interviewDate});

  final String? householdId;
  final String? respondentName;
  final String? respondentTelephoneNumber;
  final String? interviewDate;

  Collection copyWith(
      {String? householdId,
      String? respondentName,
      String? respondentTelephoneNumber,
      String? interviewDate}) {
    return Collection(
        householdId: householdId ?? this.householdId,
        respondentName: respondentName ?? this.respondentName,
        respondentTelephoneNumber:
            respondentTelephoneNumber ?? this.respondentTelephoneNumber,
        interviewDate: interviewDate ?? this.interviewDate);
  }

  @override
  List<Object?> get props =>
      [householdId, respondentName, respondentTelephoneNumber, interviewDate];
}
