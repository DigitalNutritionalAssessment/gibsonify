// TODO: rename filename to gibsons_form.dart
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
