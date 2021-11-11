// This class is not currently used, but hopefully will be in the future
// TODO: implement all fields needed for Collection that are currently kept in
// CollectionState into GibsonsForm

class GibsonsForm {
  GibsonsForm(
      {this.householdId,
      this.respondentName,
      this.respondentTelephoneNumber,
      this.interviewDate});

  String? householdId;
  bool householdIdIsValid = false;
  String? respondentName;
  String? respondentTelephoneNumber;
  String? interviewDate;

  GibsonsForm copyWith(
      {String? householdId,
      String? respondentName,
      String? respondentTelephoneNumber,
      String? interviewDate}) {
    return GibsonsForm(
        householdId: householdId ?? this.householdId,
        respondentName: respondentName ?? this.respondentName,
        respondentTelephoneNumber:
            respondentTelephoneNumber ?? this.respondentTelephoneNumber,
        interviewDate: interviewDate ?? this.interviewDate);
  }
}
