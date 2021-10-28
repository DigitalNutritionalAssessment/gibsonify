import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:gibsonify/collection/models/models.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  CollectionBloc() : super(const CollectionState()) {
    on<HouseholdIdChanged>(_onHouseholdIdChanged);
    on<RespondentNameChanged>(_onRespondentNameChanged);
    on<RespondentTelNumberChanged>(_onRespondentTelNumberChanged);
    on<InterviewDateChanged>(_onInterviewDateChanged);
    on<HouseholdIdUnfocused>(_onHouseholdIdUnfocused);
    on<RespondentNameUnfocused>(_onRespondentNameUnfocused);
    on<RespondentTelNumberUnfocused>(_onRespondentTelNumberUnfocused);
    on<InterviewDateUnfocused>(_onInterviewDateUnfocused);
    on<FoodItemAdded>(_onFoodItemAdded);
    on<FoodItemNameChanged>(_onFoodItemNameChanged);
    on<FoodItemTimePeriodChanged>(_onFoodItemTimePeriodChanged);
    on<FoodItemSourceChanged>(_onFoodItemSourceChanged);
    on<FoodItemDescriptionChanged>(_onFoodItemDescriptionChanged);
    on<FoodItemPreparationMethodChanged>(_onFoodItemPreparationMethodChanged);
  }

  void _onHouseholdIdChanged(
      HouseholdIdChanged event, Emitter<CollectionState> emit) {
    final householdId = HouseholdId.dirty(event.householdId);
    emit(state.copyWith(
        householdId: householdId, // TODO: investigate using pure here
        sensitizationStatus: Formz.validate([
          householdId,
          state.respondentName,
          state.respondentTelNumber,
          state.interviewDate
        ]) // TODO: validate other sensitization fields once added
        ));
  }

  void _onRespondentNameChanged(
      RespondentNameChanged event, Emitter<CollectionState> emit) {
    final respondentName = RespondentName.dirty(event.respondentName);
    emit(state.copyWith(
        respondentName: respondentName,
        sensitizationStatus: Formz.validate([
          state.householdId,
          respondentName,
          state.respondentTelNumber,
          state.interviewDate
        ])));
  }

  void _onRespondentTelNumberChanged(
      RespondentTelNumberChanged event, Emitter<CollectionState> emit) {
    final respondentTelNumber =
        RespondentTelNumber.dirty(event.respondentTelNumber);
    emit(state.copyWith(
        respondentTelNumber: respondentTelNumber,
        sensitizationStatus: Formz.validate([
          state.householdId,
          state.respondentName,
          respondentTelNumber,
          state.interviewDate
        ])));
  }

  void _onInterviewDateChanged(
      InterviewDateChanged event, Emitter<CollectionState> emit) {
    final interviewDate = InterviewDate.dirty(event.interviewDate);
    emit(state.copyWith(
        interviewDate: interviewDate,
        sensitizationStatus: Formz.validate([
          state.householdId,
          state.respondentName,
          state.respondentTelNumber,
          interviewDate
        ])));
  }

  void _onHouseholdIdUnfocused(
      HouseholdIdUnfocused event, Emitter<CollectionState> emit) {
    final householdId = HouseholdId.dirty(state.householdId.value);
    emit(state.copyWith(
      householdId: householdId,
      sensitizationStatus: Formz.validate([
        householdId,
        state.respondentName,
        state.respondentTelNumber,
        state.interviewDate
      ]),
    ));
  }

  void _onRespondentNameUnfocused(
      RespondentNameUnfocused event, Emitter<CollectionState> emit) {
    final respondentName = RespondentName.dirty(state.respondentName.value);
    emit(state.copyWith(
      respondentName: respondentName,
      sensitizationStatus: Formz.validate([
        state.householdId,
        respondentName,
        state.respondentTelNumber,
        state.interviewDate
      ]),
    ));
  }

  void _onRespondentTelNumberUnfocused(
      RespondentTelNumberUnfocused event, Emitter<CollectionState> emit) {
    final respondentTelNumber =
        RespondentTelNumber.dirty(state.respondentTelNumber.value);
    emit(state.copyWith(
      respondentTelNumber: respondentTelNumber,
      sensitizationStatus: Formz.validate([
        state.householdId,
        state.respondentName,
        respondentTelNumber,
        state.interviewDate
      ]),
    ));
  }

  void _onInterviewDateUnfocused(
      InterviewDateUnfocused event, Emitter<CollectionState> emit) {
    final interviewDate = InterviewDate.dirty(state.interviewDate.value);
    emit(state.copyWith(
      interviewDate: interviewDate,
      sensitizationStatus: Formz.validate([
        state.householdId,
        state.respondentName,
        state.respondentTelNumber,
        interviewDate
      ]),
    ));
  }

  void _onFoodItemAdded(FoodItemAdded event, Emitter<CollectionState> emit) {
    final foodItem = FoodItem();
    List<FoodItem> foodItems = List.from(state.foodItems);
    foodItems.add(foodItem);

    emit(state.copyWith(foodItems: foodItems));
  }

  void _onFoodItemNameChanged(
      FoodItemNameChanged event, Emitter<CollectionState> emit) {
    List<FoodItem> foodItems = List.from(state.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    FoodItem foodItem = foodItems[changedFoodItemIndex]
        .copyWith(name: Name.dirty(event.foodItemName));

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    emit(state.copyWith(foodItems: foodItems));
  }

  void _onFoodItemTimePeriodChanged(
      FoodItemTimePeriodChanged event, Emitter<CollectionState> emit) {
    List<FoodItem> foodItems = List.from(state.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    FoodItem foodItem = foodItems[changedFoodItemIndex]
        .copyWith(timePeriod: TimePeriod.dirty(event.foodItemTimePeriod));

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    emit(state.copyWith(foodItems: foodItems));
  }

  void _onFoodItemSourceChanged(
      FoodItemSourceChanged event, Emitter<CollectionState> emit) {
    List<FoodItem> foodItems = List.from(state.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    FoodItem foodItem = foodItems[changedFoodItemIndex]
        .copyWith(source: Source.dirty(event.foodItemSource));

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    emit(state.copyWith(foodItems: foodItems));
  }

  void _onFoodItemDescriptionChanged(
      FoodItemDescriptionChanged event, Emitter<CollectionState> emit) {
    List<FoodItem> foodItems = List.from(state.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    FoodItem foodItem = foodItems[changedFoodItemIndex]
        .copyWith(description: Description.dirty(event.foodItemDescription));

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    emit(state.copyWith(foodItems: foodItems));
  }

  void _onFoodItemPreparationMethodChanged(
      FoodItemPreparationMethodChanged event, Emitter<CollectionState> emit) {
    List<FoodItem> foodItems = List.from(state.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    FoodItem foodItem = foodItems[changedFoodItemIndex].copyWith(
        preparationMethod:
            PreparationMethod.dirty(event.foodItemPreparationMethod));

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    emit(state.copyWith(foodItems: foodItems));
  }
}
