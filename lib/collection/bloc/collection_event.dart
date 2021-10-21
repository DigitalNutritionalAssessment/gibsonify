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

class FoodItemAdded extends CollectionEvent {}

// TODO: delete this event
class FoodItemChanged extends CollectionEvent {
  final FoodItem foodItem;

  const FoodItemChanged({required this.foodItem});

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
