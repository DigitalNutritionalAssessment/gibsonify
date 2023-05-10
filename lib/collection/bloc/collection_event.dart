part of 'collection_bloc.dart';

abstract class CollectionEvent extends Equatable {
  const CollectionEvent();

  @override
  List<Object> get props => [];
}

class ActiveStepChanged extends CollectionEvent {
  final int changedActiveStep;
  const ActiveStepChanged({required this.changedActiveStep});

  @override
  List<Object> get props => [changedActiveStep];
}

class RespondentNameChanged extends CollectionEvent {
  final String respondentName;

  const RespondentNameChanged({required this.respondentName});

  @override
  List<Object> get props => [respondentName];
}

class RespondentTelInfoChanged extends CollectionEvent {
  final String respondentCountryCode;
  final String respondentTelNumberPrefix;
  final String respondentTelNumber;

  const RespondentTelInfoChanged(
      {required this.respondentCountryCode,
      required this.respondentTelNumberPrefix,
      required this.respondentTelNumber});

  @override
  List<Object> get props =>
      [respondentCountryCode, respondentTelNumberPrefix, respondentTelNumber];
}

class SensitizationDateChanged extends CollectionEvent {
  final String sensitizationDate;

  const SensitizationDateChanged({required this.sensitizationDate});

  @override
  List<Object> get props => [sensitizationDate];
}

class SurveyChanged extends CollectionEvent {
  final String surveyId;

  const SurveyChanged({required this.surveyId});

  @override
  List<Object> get props => [surveyId];
}

class RecallDayChanged extends CollectionEvent {
  final String recallDay;

  const RecallDayChanged({required this.recallDay});

  @override
  List<Object> get props => [recallDay];
}

class InterviewDateChanged extends CollectionEvent {
  final String interviewDate;

  const InterviewDateChanged({required this.interviewDate});

  @override
  List<Object> get props => [interviewDate];
}

class InterviewStartTimeChanged extends CollectionEvent {
  final String interviewStartTime;

  const InterviewStartTimeChanged({required this.interviewStartTime});

  @override
  List<Object> get props => [interviewStartTime];
}

class PhysioStatusChanged extends CollectionEvent {
  final PhysioStatus physioStatus;

  const PhysioStatusChanged({required this.physioStatus});
}

class GeoLocationRequested extends CollectionEvent {
  const GeoLocationRequested();

  @override
  List<Object> get props => [];
}

class PictureChartCollectedChanged extends CollectionEvent {
  final String pictureChartCollected;

  const PictureChartCollectedChanged({required this.pictureChartCollected});

  @override
  List<Object> get props => [pictureChartCollected];
}

class PictureChartNotCollectedReasonChanged extends CollectionEvent {
  final String pictureChartNotCollectedReason;

  const PictureChartNotCollectedReasonChanged(
      {required this.pictureChartNotCollectedReason});

  @override
  List<Object> get props => [pictureChartNotCollectedReason];
}

class InterviewEndTimeChanged extends CollectionEvent {
  final String interviewEndTime;

  const InterviewEndTimeChanged({required this.interviewEndTime});

  @override
  List<Object> get props => [interviewEndTime];
}

class InterviewFinishedInOneVisitChanged extends CollectionEvent {
  final String interviewFinishedInOneVisit;

  const InterviewFinishedInOneVisitChanged(
      {required this.interviewFinishedInOneVisit});

  @override
  List<Object> get props => [interviewFinishedInOneVisit];
}

class SecondInterviewVisitDateChanged extends CollectionEvent {
  final String secondInterviewVisitDate;

  const SecondInterviewVisitDateChanged(
      {required this.secondInterviewVisitDate});

  @override
  List<Object> get props => [secondInterviewVisitDate];
}

class SecondVisitReasonChanged extends CollectionEvent {
  final String secondVisitReason;

  const SecondVisitReasonChanged({required this.secondVisitReason});

  @override
  List<Object> get props => [secondVisitReason];
}

class InterviewOutcomeChanged extends CollectionEvent {
  final String interviewOutcome;

  const InterviewOutcomeChanged({required this.interviewOutcome});

  @override
  List<Object> get props => [interviewOutcome];
}

class InterviewOutcomeNotCompletedReasonChanged extends CollectionEvent {
  final String interviewOutcomeNotCompletedReason;

  const InterviewOutcomeNotCompletedReasonChanged(
      {required this.interviewOutcomeNotCompletedReason});

  @override
  List<Object> get props => [interviewOutcomeNotCompletedReason];
}

class CommentsChanged extends CollectionEvent {
  final String comments;

  const CommentsChanged({required this.comments});

  @override
  List<Object> get props => [comments];
}

class FoodItemAdded extends CollectionEvent {}

class FoodItemDeleted extends CollectionEvent {
  final String foodItemId;
  const FoodItemDeleted({required this.foodItemId});

  @override
  List<Object> get props => [foodItemId];
}

class FoodItemNameChanged extends CollectionEvent {
  final String foodItemName;
  final String foodItemId;

  const FoodItemNameChanged(
      {required this.foodItemName, required this.foodItemId});

  @override
  List<Object> get props => [foodItemName, foodItemId];
}

class FoodItemTimePeriodChanged extends CollectionEvent {
  final String foodItemTimePeriod;
  final String foodItemId;

  const FoodItemTimePeriodChanged(
      {required this.foodItemTimePeriod, required this.foodItemId});

  @override
  List<Object> get props => [foodItemTimePeriod, foodItemId];
}

class FoodItemSourceChanged extends CollectionEvent {
  final String foodItemSource;
  final String foodItemId;

  const FoodItemSourceChanged(
      {required this.foodItemSource, required this.foodItemId});

  @override
  List<Object> get props => [foodItemSource, foodItemId];
}

class FoodItemPreparationMethodChanged extends CollectionEvent {
  final String foodItemPreparationMethod;
  final String foodItemId;

  const FoodItemPreparationMethodChanged(
      {required this.foodItemPreparationMethod, required this.foodItemId});

  @override
  List<Object> get props => [foodItemPreparationMethod, foodItemId];
}

class FoodItemCustomPreparationMethodChanged extends CollectionEvent {
  final String foodItemCustomPreparationMethod;
  final String foodItemId;

  const FoodItemCustomPreparationMethodChanged(
      {required this.foodItemCustomPreparationMethod,
      required this.foodItemId});

  @override
  List<Object> get props => [foodItemCustomPreparationMethod, foodItemId];
}

class FoodItemDescriptionChanged extends CollectionEvent {
  final String foodItemDescription;
  final String foodItemId;

  const FoodItemDescriptionChanged(
      {required this.foodItemDescription, required this.foodItemId});

  @override
  List<Object> get props => [foodItemDescription, foodItemId];
}

class FoodItemRecipeChanged extends CollectionEvent {
  final Recipe foodItemRecipe;
  final String foodItemId;

  const FoodItemRecipeChanged(
      {required this.foodItemId, required this.foodItemRecipe});

  @override
  List<Object> get props => [foodItemRecipe, foodItemId];
}

class FoodItemMeasurementAdded extends CollectionEvent {
  final String foodItemId;

  const FoodItemMeasurementAdded({required this.foodItemId});

  @override
  List<Object> get props => [foodItemId];
}

class FoodItemMeasurementDeleted extends CollectionEvent {
  final int measurementIndex;
  final String foodItemId;

  const FoodItemMeasurementDeleted(
      {required this.measurementIndex, required this.foodItemId});

  @override
  List<Object> get props => [measurementIndex, foodItemId];
}

/// Changes the measurement method and nulls unit and value.
class FoodItemMeasurementMethodChangedOthersNulled extends CollectionEvent {
  final int measurementIndex;
  final String measurementMethod;
  final String foodItemId;

  const FoodItemMeasurementMethodChangedOthersNulled({
    required this.measurementIndex,
    required this.measurementMethod,
    required this.foodItemId,
  });

  @override
  List<Object> get props => [measurementIndex, measurementMethod, foodItemId];
}

class FoodItemMeasurementUnitChanged extends CollectionEvent {
  final int measurementIndex;
  final String measurementUnit;
  final String foodItemId;

  const FoodItemMeasurementUnitChanged(
      {required this.measurementIndex,
      required this.measurementUnit,
      required this.foodItemId});

  @override
  List<Object> get props => [measurementIndex, measurementUnit, foodItemId];
}

class FoodItemMeasurementValueChanged extends CollectionEvent {
  final int measurementIndex;
  final String measurementValue;
  final String foodItemId;

  const FoodItemMeasurementValueChanged(
      {required this.measurementIndex,
      required this.measurementValue,
      required this.foodItemId});

  @override
  List<Object> get props => [measurementIndex, measurementValue, foodItemId];
}

class FoodItemConfirmationChanged extends CollectionEvent {
  final bool foodItemConfirmed;
  final String foodItemId;

  const FoodItemConfirmationChanged(
      {required this.foodItemConfirmed, required this.foodItemId});

  @override
  List<Object> get props => [foodItemConfirmed, foodItemId];
}

class CollectionFinished extends CollectionEvent {
  const CollectionFinished();

  @override
  List<Object> get props => [];
}
