part of 'collection_bloc.dart';

class CollectionState extends Equatable {
  final HouseholdId householdId;
  final RespondentName respondentName;
  final RespondentTelNumber respondentTelNumber;
  final InterviewDate interviewDate;
  final InterviewStartTime interviewStartTime;
  // TODO: refactor all of the above
  // fields into a single SensitizationForm class
  final FormzStatus sensitizationStatus;
  // final FoodItem foodItem = FoodItem();

  final List<FoodItem> foodItems;

  const CollectionState(
      {this.householdId = const HouseholdId.pure(),
      this.respondentName = const RespondentName.pure(),
      this.respondentTelNumber = const RespondentTelNumber.pure(),
      this.interviewDate = const InterviewDate.pure(),
      this.interviewStartTime = const InterviewStartTime.pure(),
      this.sensitizationStatus = FormzStatus.pure,
      // TODO: find a way how to initialize foodItems with one FoodItem inside
      this.foodItems =
          const <FoodItem>[]}); // TODO: maybe change to ordered map???

  CollectionState copyWith(
      {HouseholdId? householdId,
      RespondentName? respondentName,
      RespondentTelNumber? respondentTelNumber,
      InterviewDate? interviewDate,
      InterviewStartTime? interviewStartTime,
      FormzStatus? sensitizationStatus,
      List<FoodItem>? foodItems}) {
    return CollectionState(
        householdId: householdId ?? this.householdId,
        respondentName: respondentName ?? this.respondentName,
        respondentTelNumber: respondentTelNumber ?? this.respondentTelNumber,
        interviewStartTime: interviewStartTime ?? this.interviewStartTime,
        interviewDate: interviewDate ?? this.interviewDate,
        sensitizationStatus: sensitizationStatus ?? this.sensitizationStatus,
        foodItems: foodItems ?? this.foodItems);
  }

  @override
  List<Object> get props => [
        householdId,
        respondentName,
        sensitizationStatus,
        respondentTelNumber,
        interviewDate,
        interviewStartTime,
        foodItems
      ];
}
