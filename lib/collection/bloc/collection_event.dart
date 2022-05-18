part of 'collection_bloc.dart';

abstract class CollectionEvent extends Equatable {
  const CollectionEvent();

  @override
  List<Object> get props => [];
}

class SelectedScreenChanged extends CollectionEvent {
  final SelectedScreen changedSelectedScreen;
  const SelectedScreenChanged({required this.changedSelectedScreen});

  @override
  List<Object> get props => [changedSelectedScreen];
}

class HouseholdIdChanged extends CollectionEvent {
  final String householdId;

  const HouseholdIdChanged({required this.householdId});

  @override
  List<Object> get props => [householdId];
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
  // TODO: delete foodItem and pass only uuid instead
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;
  const FoodItemDeleted({required this.foodItem});

  @override
  List<Object> get props => [foodItem];
}

class FoodItemNameChanged extends CollectionEvent {
  final String foodItemName;
  // TODO: delete foodItem and pass only uuid instead
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;

  const FoodItemNameChanged(
      {required this.foodItemName, required this.foodItem});

  @override
  List<Object> get props => [foodItemName, foodItem];
}

class FoodItemTimePeriodChanged extends CollectionEvent {
  final String foodItemTimePeriod; // TODO: change to an enum?
  // TODO: delete foodItem and pass only uuid instead
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;

  const FoodItemTimePeriodChanged(
      {required this.foodItemTimePeriod, required this.foodItem});

  @override
  List<Object> get props => [foodItemTimePeriod, foodItem];
}

class FoodItemSourceChanged extends CollectionEvent {
  final String foodItemSource; // TODO: change to an enum?
  // TODO: delete foodItem and pass only uuid instead
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;

  const FoodItemSourceChanged(
      {required this.foodItemSource, required this.foodItem});

  @override
  List<Object> get props => [foodItemSource, foodItem];
}

class FoodItemDescriptionChanged extends CollectionEvent {
  final String foodItemDescription;
  // TODO: delete foodItem and pass only uuid instead
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;

  const FoodItemDescriptionChanged(
      {required this.foodItemDescription, required this.foodItem});

  @override
  List<Object> get props => [foodItemDescription, foodItem];
}

class FoodItemPreparationMethodChanged extends CollectionEvent {
  final String foodItemPreparationMethod; // TODO: change to an enum?
  // TODO: delete foodItem and pass only uuid instead
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;

  const FoodItemPreparationMethodChanged(
      {required this.foodItemPreparationMethod, required this.foodItem});

  @override
  List<Object> get props => [foodItemPreparationMethod, foodItem];
}

class FoodItemCustomPreparationMethodChanged extends CollectionEvent {
  final String foodItemCustomPreparationMethod;
  // TODO: delete foodItem and pass only uuid instead
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;

  const FoodItemCustomPreparationMethodChanged(
      {required this.foodItemCustomPreparationMethod, required this.foodItem});

  @override
  List<Object> get props => [foodItemCustomPreparationMethod, foodItem];
}

class FoodItemMeasurementAdded extends CollectionEvent {
  // TODO: delete foodItem and pass only uuid instead
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;

  const FoodItemMeasurementAdded({required this.foodItem});

  @override
  List<Object> get props => [foodItem];
}

class FoodItemMeasurementDeleted extends CollectionEvent {
  // TODO: delete foodItem and pass only uuid instead
  final FoodItem foodItem;
  final int measurementIndex;

  const FoodItemMeasurementDeleted(
      {required this.foodItem, required this.measurementIndex});

  @override
  List<Object> get props => [foodItem, measurementIndex];
}

class FoodItemMeasurementMethodChanged extends CollectionEvent {
  // TODO: delete foodItem and pass only uuid instead
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;
  final int measurementIndex;
  // TODO: rename to just measurementMethod, do also for Value and Unit events
  final String foodItemMeasurementMethod; // TODO: change to an enum?

  const FoodItemMeasurementMethodChanged({
    required this.measurementIndex,
    required this.foodItemMeasurementMethod,
    required this.foodItem,
  });

  @override
  List<Object> get props =>
      [measurementIndex, foodItemMeasurementMethod, foodItem];
}

class FoodItemMeasurementValueChanged extends CollectionEvent {
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;
  final int measurementIndex;
  final String foodItemMeasurementValue; // TODO: change to an enum?
  // TODO: delete foodItem and pass only uuid instead

  const FoodItemMeasurementValueChanged(
      {required this.measurementIndex,
      required this.foodItemMeasurementValue,
      required this.foodItem});

  @override
  List<Object> get props =>
      [measurementIndex, foodItemMeasurementValue, foodItem];
}

class FoodItemMeasurementUnitChanged extends CollectionEvent {
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;
  final int measurementIndex;
  final String foodItemMeasurementUnit; // TODO: change to an enum?
  // TODO: delete foodItem and pass only uuid instead

  const FoodItemMeasurementUnitChanged(
      {required this.measurementIndex,
      required this.foodItemMeasurementUnit,
      required this.foodItem});

  @override
  List<Object> get props =>
      [measurementIndex, foodItemMeasurementUnit, foodItem];
}

class FoodItemConfirmationChanged extends CollectionEvent {
  final bool foodItemConfirmed;
  // TODO: delete foodItem and pass only uuid instead
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;

  const FoodItemConfirmationChanged(
      {required this.foodItemConfirmed, required this.foodItem});

  @override
  List<Object> get props => [foodItemConfirmed, foodItem];
}

class FoodItemRecipeChanged extends CollectionEvent {
  final Recipe foodItemRecipe;
  final String foodItemId;

  const FoodItemRecipeChanged(
      {required this.foodItemId, required this.foodItemRecipe});

  @override
  List<Object> get props => [foodItemId, foodItemRecipe];
}

class GibsonsFormSaved extends CollectionEvent {
  const GibsonsFormSaved();

  @override
  List<Object> get props => [];
}

class GibsonsFormProvided extends CollectionEvent {
  final GibsonsForm gibsonsForm;
  const GibsonsFormProvided({required this.gibsonsForm});

  @override
  List<Object> get props => [gibsonsForm];
}

// TODO: This event is temporary until it is implemented that CollectionBloc
// takes a GibsonsForm when instantiated — if none is passed, it creates a new
// one
class GibsonsFormCreated extends CollectionEvent {
  final String employeeNumber;

  const GibsonsFormCreated({required this.employeeNumber});

  @override
  List<Object> get props => [employeeNumber];
}

class GibsonsFormDuplicated extends CollectionEvent {
  final String employeeNumber;
  final GibsonsForm gibsonsForm;
  const GibsonsFormDuplicated(
      {required this.employeeNumber, required this.gibsonsForm});

  @override
  List<Object> get props => [employeeNumber, gibsonsForm];
}

class CollectionFinished extends CollectionEvent {
  const CollectionFinished();

  @override
  List<Object> get props => [];
}
