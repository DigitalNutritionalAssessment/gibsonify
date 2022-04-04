import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'package:gibsonify_api/gibsonify_api.dart';

class GibsonsForm extends Equatable {
  GibsonsForm(
      {String? id,
      this.employeeNumber,
      this.householdId,
      this.respondentName,
      this.respondentCountryCode,
      this.respondentTelNumberPrefix,
      this.respondentTelNumber,
      this.sensitizationDate,
      this.recallDay, // TODO: rename to recallDayType
      this.interviewDate,
      this.interviewStartTime,
      this.geoLocation,
      this.pictureChartCollected,
      this.pictureChartNotCollectedReason,
      this.interviewEndTime,
      this.interviewFinishedInOneVisit,
      this.secondInterviewVisitDate,
      this.secondVisitReason,
      this.interviewOutcome,
      this.interviewOutcomeNotCompletedReason,
      this.comments,
      this.finished = false,
      this.foodItems = const <FoodItem>[]})
      : id = id ?? const Uuid().v4();

  final String id;
  final String? employeeNumber;
  final String? householdId;
  final String? respondentName;
  final String? respondentCountryCode;
  final String? respondentTelNumberPrefix;
  final String? respondentTelNumber;
  final String? sensitizationDate;
  final String? recallDay; // TODO: change to an enum
  final String? interviewDate;
  final String? interviewStartTime;
  final String? geoLocation;
  final String? pictureChartCollected; // TODO: change to a bool
  final String? pictureChartNotCollectedReason;
  final String? interviewEndTime;
  final String? interviewFinishedInOneVisit; // TODO: change to a bool
  final String? secondInterviewVisitDate;
  final String? secondVisitReason;
  final String? interviewOutcome; // TODO: change to an enum
  final String? interviewOutcomeNotCompletedReason;
  final String? comments;
  final bool finished;
  final List<FoodItem> foodItems;

  // TODO: implement code generation JSON serialization using json_serializable
  // and/or json_annotation

  GibsonsForm.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        employeeNumber = json['employeeNumber'],
        householdId = json['householdId'],
        respondentName = json['respondentName'],
        respondentCountryCode = json['respondentCountryCode'],
        respondentTelNumberPrefix = json['respondentTelNumberPrefix'],
        respondentTelNumber = json['respondentTelNumber'],
        sensitizationDate = json['sensitizationDate'],
        recallDay = json['recallDay'],
        interviewDate = json['interviewDate'],
        interviewStartTime = json['interviewStartTime'],
        geoLocation = json['geoLocation'],
        pictureChartCollected = json['pictureChartCollected'],
        pictureChartNotCollectedReason = json['pictureChartNotCollectedReason'],
        interviewEndTime = json['interviewEndTime'],
        interviewFinishedInOneVisit = json['interviewFinishedInOneVisit'],
        secondInterviewVisitDate = json['secondInterviewVisitDate'],
        secondVisitReason = json['secondVisitReason'],
        interviewOutcome = json['interviewOutcome'],
        interviewOutcomeNotCompletedReason =
            json['interviewOutcomeNotCompletedReason'],
        comments = json['comments'],
        finished = json['finished'] == 'true' ? true : false,
        foodItems = _jsonDecodeFoodItems(json['foodItems']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employeeNumber'] = employeeNumber;
    data['householdId'] = householdId;
    data['respondentName'] = respondentName;
    data['respondentCountryCode'] = respondentCountryCode;
    data['respondentTelNumberPrefix'] = respondentTelNumberPrefix;
    data['respondentTelNumber'] = respondentTelNumber;
    data['sensitizationDate'] = sensitizationDate;
    data['recallDay'] = recallDay;
    data['interviewDate'] = interviewDate;
    data['interviewStartTime'] = interviewStartTime;
    data['geoLocation'] = geoLocation;
    data['pictureChartCollected'] = pictureChartCollected;
    data['pictureChartNotCollectedReason'] = pictureChartNotCollectedReason;
    data['interviewEndTime'] = interviewEndTime;
    data['interviewFinishedInOneVisit'] = interviewFinishedInOneVisit;
    data['secondInterviewVisitDate'] = secondInterviewVisitDate;
    data['secondVisitReason'] = secondVisitReason;
    data['interviewOutcome'] = interviewOutcome;
    data['interviewOutcomeNotCompletedReason'] =
        interviewOutcomeNotCompletedReason;
    data['comments'] = comments;
    data['finished'] = finished.toString();
    data['foodItems'] = jsonEncode(foodItems); // This calls toJson on each one
    return data;
  }
  // TODO: add a fromCsv constructor

  String toCsv() {
    String gibsonsFormInfo =
        '"$id","$employeeNumber","$householdId","$respondentName",'
        '"$respondentCountryCode","$respondentTelNumberPrefix","$respondentTelNumber",'
        '"$sensitizationDate","$recallDay","$interviewDate","$interviewStartTime",'
        '"$geoLocation","$pictureChartCollected","$pictureChartNotCollectedReason",'
        '"$interviewEndTime","$interviewFinishedInOneVisit","$secondInterviewVisitDate",'
        '"$secondVisitReason","$interviewOutcome","$interviewOutcomeNotCompletedReason",'
        '"$comments","${finished.toString()}",';
    String csv = '';
    for (FoodItem foodItem in foodItems) {
      csv = csv + gibsonsFormInfo + foodItem.toCsv() + '\n';
    }
    return csv;
  }

  GibsonsForm copyWith(
      {String? id,
      String? employeeNumber,
      String? householdId,
      String? respondentName,
      String? respondentCountryCode,
      String? respondentTelNumberPrefix,
      String? respondentTelNumber,
      String? sensitizationDate,
      String? recallDay,
      String? interviewDate,
      String? interviewStartTime,
      String? geoLocation,
      String? pictureChartCollected,
      String? pictureChartNotCollectedReason,
      String? interviewEndTime,
      String? interviewFinishedInOneVisit,
      String? secondInterviewVisitDate,
      String? secondVisitReason,
      String? interviewOutcome,
      String? interviewOutcomeNotCompletedReason,
      String? comments,
      bool? finished,
      List<FoodItem>? foodItems}) {
    return GibsonsForm(
        id: id ?? this.id,
        employeeNumber: employeeNumber ?? this.employeeNumber,
        householdId: householdId ?? this.householdId,
        respondentName: respondentName ?? this.respondentName,
        respondentCountryCode:
            respondentCountryCode ?? this.respondentCountryCode,
        respondentTelNumberPrefix:
            respondentTelNumberPrefix ?? this.respondentTelNumberPrefix,
        respondentTelNumber: respondentTelNumber ?? this.respondentTelNumber,
        sensitizationDate: sensitizationDate ?? this.sensitizationDate,
        recallDay: recallDay ?? this.recallDay,
        interviewDate: interviewDate ?? this.interviewDate,
        interviewStartTime: interviewStartTime ?? this.interviewStartTime,
        geoLocation: geoLocation ?? this.geoLocation,
        pictureChartCollected:
            pictureChartCollected ?? this.pictureChartCollected,
        pictureChartNotCollectedReason: pictureChartNotCollectedReason ??
            this.pictureChartNotCollectedReason,
        interviewEndTime: interviewEndTime ?? this.interviewEndTime,
        interviewFinishedInOneVisit:
            interviewFinishedInOneVisit ?? this.interviewFinishedInOneVisit,
        secondInterviewVisitDate:
            secondInterviewVisitDate ?? this.secondInterviewVisitDate,
        secondVisitReason: secondVisitReason ?? this.secondVisitReason,
        interviewOutcome: interviewOutcome ?? this.interviewOutcome,
        interviewOutcomeNotCompletedReason:
            interviewOutcomeNotCompletedReason ??
                this.interviewOutcomeNotCompletedReason,
        comments: comments ?? this.comments,
        finished: finished ?? this.finished,
        foodItems: foodItems ?? this.foodItems);
  }

  @override
  String toString() {
    return '\n *** \nGibson\'s Form:\n'
        'UUID: $id\n'
        'Employee Number: $employeeNumber\n'
        'HouseholdID: $householdId\n'
        'Repondent Name: $respondentName\n'
        'Repondent Country Code: $respondentCountryCode\n'
        'Respondent Tel Number Prefix: $respondentTelNumberPrefix\n'
        'Respondent Tel Number: $respondentTelNumber\n'
        'Sensitization Date: $sensitizationDate\n'
        'Recall Day: $recallDay\n'
        'Interview Date: $interviewDate\n'
        'Interview Start Time: $interviewStartTime\n'
        'Geo Location: $geoLocation\n'
        'Picture Chart Collected: $pictureChartCollected\n'
        'Picture Chart Not Collected Reason: $pictureChartNotCollectedReason\n'
        'Interview End Time: $interviewEndTime\n'
        'Interview finished in one visit: $interviewFinishedInOneVisit\n'
        'Second interview visit date: $secondInterviewVisitDate\n'
        'Second visit reason: $secondVisitReason\n'
        'Interview Outcome: $interviewOutcome\n'
        'Interview Outcome Not Completed Reason: '
        '$interviewOutcomeNotCompletedReason\n'
        'Comments: $comments\n'
        'Finished: $finished\n'
        'Food Items: $foodItems'
        '\n *** \n';
  }

  @override
  List<Object?> get props => [
        id,
        employeeNumber,
        householdId,
        respondentName,
        respondentCountryCode,
        respondentTelNumberPrefix,
        respondentTelNumber,
        sensitizationDate,
        recallDay,
        interviewDate,
        interviewStartTime,
        geoLocation,
        pictureChartCollected,
        pictureChartNotCollectedReason,
        interviewEndTime,
        interviewFinishedInOneVisit,
        secondInterviewVisitDate,
        secondVisitReason,
        interviewOutcome,
        interviewOutcomeNotCompletedReason,
        comments,
        finished,
        foodItems
      ];

  bool isHouseholdIdValid() {
    if (householdId != null) {
      if (householdId!.length >= 10 && householdId!.length <= 15) {
        return true;
      }
    }
    return false;
  }

  bool isRespondentNameValid() {
    return isFieldNotNullAndNotEmpty(respondentName);
  }

  bool isRespondentTelNumberValid() {
    return isFieldNotNullAndNotEmpty(respondentTelNumber);
  }

  bool isSensitizationDateValid() {
    return isFieldNotNullAndNotEmpty(sensitizationDate);
  }

  bool isRecallDayValid() {
    return isFieldNotNullAndNotEmpty(recallDay);
  }

  bool isInterviewDateValid() {
    if (sensitizationDate == null || interviewDate == null) {
      return false;
    }
    try {
      // TODO: refactor sensitizationDate and interviewDate to be DateTime fields
      // so that wouldn't have to parse in this method, just compare
      var parsedSensitizationDate = DateTime.parse(sensitizationDate!);
      var parsedInterviewDate = DateTime.parse(interviewDate!);
      bool isInterviewAtLeastTwoDaysAfterSensitization = parsedInterviewDate
          .subtract(Duration(days: 1))
          .isAfter(parsedSensitizationDate);
      return isInterviewAtLeastTwoDaysAfterSensitization;
    } catch (e) {
      return false;
    }
  }

  bool isInterviewStartTimeValid() {
    return isFieldNotNullAndNotEmpty(interviewStartTime);
  }

  bool isGeoLocationValid() {
    return isFieldNotNullAndNotEmpty(geoLocation);
  }

  bool isSensitizationValid() {
    bool sensitizationValid = isHouseholdIdValid() &&
        isRespondentNameValid() &&
        isRespondentTelNumberValid() &&
        isSensitizationDateValid() &&
        isRecallDayValid() &&
        isInterviewDateValid() &&
        isInterviewStartTimeValid() &&
        isGeoLocationValid();
    return sensitizationValid;
  }

  bool allFoodItemsConfirmed() {
    return foodItems.every((foodItem) => foodItem.confirmed);
  }

  bool isPictureChartCollectedValid() {
    return isFieldNotNullAndNotEmpty(pictureChartCollected);
  }

  bool isPictureChartCollected() {
    return pictureChartCollected?.toLowerCase() == 'yes';
  }

  bool isPictureChartNotCollectedReasonValid() {
    return isFieldNotNullAndNotEmpty(pictureChartNotCollectedReason);
  }

  bool isInterviewEndTimeValid() {
    return isFieldNotNullAndNotEmpty(interviewEndTime);
  }

  bool isInterviewFinishedInOneVisitValid() {
    return isFieldNotNullAndNotEmpty(interviewFinishedInOneVisit);
  }

  bool isInterviewFinishedInOneVisit() {
    return interviewFinishedInOneVisit?.toLowerCase() == 'yes';
  }

  bool isSecondInterviewVisitDateValid() {
    // TODO: add parsing checks to ensure it is after first interview date
    return isFieldNotNullAndNotEmpty(secondInterviewVisitDate);
  }

  bool isSecondVisitReasonValid() {
    return isFieldNotNullAndNotEmpty(secondVisitReason);
  }

  bool isInterviewOutcomeValid() {
    return isFieldNotNullAndNotEmpty(interviewOutcome);
  }

  bool isInterviewOutcomeCompleted() {
    return interviewOutcome?.toLowerCase() == 'completed';
  }

  bool isInterviewOutcomeNotCompletedReasonValid() {
    return isFieldNotNullAndNotEmpty(interviewOutcomeNotCompletedReason);
  }

  bool areCommentsValid() {
    return true; // comments are not mandatory
  }
}

List<FoodItem> _jsonDecodeFoodItems(jsonEncodedFoodItems) {
  List<dynamic> partiallyDecodedFoodItems = jsonDecode(jsonEncodedFoodItems);
  List<FoodItem> fullyDecodedFoodItems =
      partiallyDecodedFoodItems.map((e) => FoodItem.fromJson(e)).toList();
  return fullyDecodedFoodItems;
}
