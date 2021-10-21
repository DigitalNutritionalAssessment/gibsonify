part of 'collection_bloc.dart';

class CollectionState extends Equatable {
  final HouseholdId householdId;
  final RespondentName respondentName;
  final InterviewDate interviewDate;
  final RespondentTelNumber respondentTelNumber;
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
      this.sensitizationStatus = FormzStatus.pure,
      // TODO: find a way how to initialize foodItems with one FoodItem inside
      this.foodItems =
          const <FoodItem>[]}); // TODO: maybe change to ordered map???

  CollectionState copyWith(
      {HouseholdId? householdId,
      RespondentName? respondentName,
      InterviewDate? interviewDate,
      RespondentTelNumber? respondentTelNumber,
      FormzStatus? sensitizationStatus,
      List<FoodItem>? foodItems}) {
    return CollectionState(
        householdId: householdId ?? this.householdId,
        respondentName: respondentName ?? this.respondentName,
        respondentTelNumber: respondentTelNumber ?? this.respondentTelNumber,
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
        foodItems
      ];
}
