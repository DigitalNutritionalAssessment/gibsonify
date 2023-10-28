import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:gibsonify_api/gibsonify_api.dart';

part 'gibsons_form.g.dart';

@HiveType(typeId: 6)
enum PhysioStatus {
  @HiveField(0)
  notApplicable,
  @HiveField(1)
  pregnant,
  @HiveField(2)
  lactatingH1,
  @HiveField(3)
  lactatingH2
}

String physioStatusToString(PhysioStatus physioStatus) {
  switch (physioStatus) {
    case PhysioStatus.notApplicable:
      return "N/A";
    case PhysioStatus.pregnant:
      return "Pregnant";
    case PhysioStatus.lactatingH1:
      return "Lactating - 0 to 5 months";
    case PhysioStatus.lactatingH2:
      return "Lactating - 6 to 12 months";
  }
}

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 5)
class GibsonsForm extends Equatable {
  const GibsonsForm({
    required this.id,
    this.surveyId,
    this.recallDay, // TODO: rename to recallDayType
    this.interviewDate,
    this.interviewStartTime,
    required this.physioStatus,
    this.pictureChartCollected,
    this.pictureChartNotCollectedReason,
    this.interviewEndTime,
    this.interviewFinishedInOneVisit,
    this.secondInterviewVisitDate,
    this.secondVisitReason,
    this.interviewOutcome,
    this.interviewOutcomeNotCompletedReason,
    this.comments,
    required this.finished,
    required this.foodItems,
    required this.metadata,
  });

  GibsonsForm.create({required String employeeId})
      : id = Uuid().v4(),
        surveyId = null,
        recallDay = null,
        interviewDate = null,
        interviewStartTime = null,
        physioStatus = PhysioStatus.notApplicable,
        pictureChartCollected = null,
        pictureChartNotCollectedReason = null,
        interviewEndTime = null,
        interviewFinishedInOneVisit = null,
        secondInterviewVisitDate = null,
        secondVisitReason = null,
        interviewOutcome = null,
        interviewOutcomeNotCompletedReason = null,
        comments = null,
        finished = false,
        foodItems = [],
        metadata = Metadata.create(createdBy: employeeId);

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String? surveyId;
  @HiveField(2)
  final String? recallDay; // TODO: change to an enum
  @HiveField(3)
  final String? interviewDate;
  @HiveField(4)
  final String? interviewStartTime;
  @HiveField(5)
  final PhysioStatus physioStatus;
  @HiveField(6)
  final String? pictureChartCollected; // TODO: change to a bool
  @HiveField(7)
  final String? pictureChartNotCollectedReason;
  @HiveField(8)
  final String? interviewEndTime;
  @HiveField(9)
  final String? interviewFinishedInOneVisit; // TODO: change to a bool
  @HiveField(10)
  final String? secondInterviewVisitDate;
  @HiveField(11)
  final String? secondVisitReason;
  @HiveField(12)
  final String? interviewOutcome; // TODO: change to an enum
  @HiveField(13)
  final String? interviewOutcomeNotCompletedReason;
  @HiveField(14)
  final String? comments;
  @HiveField(15)
  final bool finished;
  @HiveField(16)
  final List<FoodItem> foodItems;
  @HiveField(17)
  final Metadata metadata;

  factory GibsonsForm.fromJson(Map<String, dynamic> json) =>
      _$GibsonsFormFromJson(json);

  Map<String, dynamic> toJson() => _$GibsonsFormToJson(this);

  // TODO: add a fromCsv constructor

  String toCsv(
      String householdId,
      String respondentName,
      String respondentCountryCode,
      String respondentTelNumberPrefix,
      String respondentTelNumber,
      String sensitizationDate,
      String geoLocation) {
    String gibsonsFormInfo = '"$id","$householdId","$respondentName",'
        '"$respondentCountryCode","$respondentTelNumberPrefix","$respondentTelNumber",'
        '"$sensitizationDate","$recallDay","$interviewDate","$interviewStartTime","$physioStatus",'
        '"$geoLocation","$pictureChartCollected","$pictureChartNotCollectedReason",'
        '"$interviewEndTime","$interviewFinishedInOneVisit","$secondInterviewVisitDate",'
        '"$secondVisitReason","$interviewOutcome","$interviewOutcomeNotCompletedReason",'
        '"$comments","${finished.toString()}",';
    String csv = '';
    for (FoodItem foodItem in foodItems) {
      csv += gibsonsFormInfo + foodItem.toCsv() + '\n';
    }
    return csv;
  }

  GibsonsForm copyWith(
      {String? id,
      String? householdId,
      String? surveyId,
      String? recallDay,
      String? interviewDate,
      String? interviewStartTime,
      PhysioStatus? physioStatus,
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
      List<FoodItem>? foodItems,
      Metadata? metadata}) {
    return GibsonsForm(
        id: id ?? this.id,
        surveyId: surveyId ?? this.surveyId,
        recallDay: recallDay ?? this.recallDay,
        interviewDate: interviewDate ?? this.interviewDate,
        interviewStartTime: interviewStartTime ?? this.interviewStartTime,
        physioStatus: physioStatus ?? this.physioStatus,
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
        foodItems: foodItems ?? this.foodItems,
        metadata: metadata ?? this.metadata);
  }

  @override
  String toString() {
    return '\n *** \nGibson\'s Form:\n'
        'UUID: $id\n'
        'Survey ID: $surveyId\n'
        'Recall Day: $recallDay\n'
        'Interview Date: $interviewDate\n'
        'Interview Start Time: $interviewStartTime\n'
        'Physio Status: $physioStatus\n'
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
        'Food Items: $foodItems\n'
        'Metadata: $metadata\n'
        '\n *** \n';
  }

  @override
  List<Object?> get props => [
        id,
        surveyId,
        recallDay,
        interviewDate,
        interviewStartTime,
        physioStatus,
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
        foodItems,
        metadata
      ];

  bool isSurveyIdValid() {
    return isFieldNotNullAndNotEmpty(surveyId);
  }

  bool isRecallDayValid() {
    return isFieldNotNullAndNotEmpty(recallDay);
  }

  bool isInterviewStartTimeValid() {
    return isFieldNotNullAndNotEmpty(interviewStartTime);
  }

  bool isSensitizationValid() {
    bool sensitizationValid =
        isSurveyIdValid() && isRecallDayValid() && isInterviewStartTimeValid();
    return sensitizationValid;
  }

  bool isFirstPassValid() {
    return foodItems.every((foodItem) =>
        isFieldNotNullAndNotEmpty(foodItem.name) &&
        isFieldNotNullAndNotEmpty(foodItem.timePeriod));
  }

  bool isSecondPassValid() {
    return foodItems.every((foodItem) =>
        isFieldNotNullAndNotEmpty(foodItem.source) &&
        isFieldNotNullAndNotEmpty(foodItem.preparationMethod) &&
        (!foodItem.preparationMethod!.contains('Other') ||
            isFieldNotNullAndNotEmpty(foodItem.customPreparationMethod)) &&
        foodItem.recipe != null);
  }

  bool isThirdPassValid() {
    return foodItems.every((foodItem) => foodItem.measurements
        .every((measurement) => measurement.isMeasurementFilled()));
  }

  bool allFoodItemsConfirmed() {
    return foodItems.every((foodItem) => foodItem.confirmed);
  }

  bool isFinishCollectionValid() {
    return isPictureChartCollectedValid() &&
        (isPictureChartCollected() ||
            isPictureChartNotCollectedReasonValid()) &&
        isInterviewEndTimeValid() &&
        isInterviewFinishedInOneVisitValid() &&
        (isInterviewFinishedInOneVisit() ||
            (isSecondInterviewVisitDateValid() &&
                isSecondVisitReasonValid())) &&
        isInterviewOutcomeValid() &&
        (isInterviewOutcomeCompleted() ||
            isInterviewOutcomeNotCompletedReasonValid());
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
