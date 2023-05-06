import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'package:gibsonify_api/gibsonify_api.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  CollectionBloc({required GibsonsForm collection})
      : super(CollectionState(gibsonsForm: collection)) {
    on<SelectedScreenChanged>(_onSelectedScreenChanged);
    on<ActiveStepChanged>(_onActiveStepChanged);
    on<SurveyChanged>(_onSurveyChanged);
    on<RecallDayChanged>(_onRecallDayChanged);
    on<InterviewDateChanged>(_onInterviewDateChanged);
    on<InterviewStartTimeChanged>(_onInterviewStartTimeChanged);
    on<PhysioStatusChanged>(_onPhysioStatusChanged);
    on<PictureChartCollectedChanged>(_onPictureChartCollectedChanged);
    on<PictureChartNotCollectedReasonChanged>(
        _onPictureChartNotCollectedReasonChanged);
    on<InterviewEndTimeChanged>(_onInterviewEndTimeChanged);
    on<InterviewFinishedInOneVisitChanged>(
        _onInterviewFinishedInOneVisitChanged);
    on<SecondInterviewVisitDateChanged>(_onSecondInterviewVisitDateChanged);
    on<SecondVisitReasonChanged>(_onSecondVisitReasonChanged);
    on<InterviewOutcomeChanged>(_onInterviewOutcomeChanged);
    on<InterviewOutcomeNotCompletedReasonChanged>(
        _onInterviewOutcomeNotCompletedReasonChanged);
    on<CommentsChanged>(_onCommentsChanged);
    on<FoodItemAdded>(_onFoodItemAdded);
    on<FoodItemDeleted>(_onFoodItemDeleted);
    on<FoodItemNameChanged>(_onFoodItemNameChanged);
    on<FoodItemTimePeriodChanged>(_onFoodItemTimePeriodChanged);
    on<FoodItemSourceChanged>(_onFoodItemSourceChanged);
    on<FoodItemPreparationMethodChanged>(_onFoodItemPreparationMethodChanged);
    on<FoodItemCustomPreparationMethodChanged>(
        _onFoodItemCustomPreparationMethodChanged);
    on<FoodItemDescriptionChanged>(_onFoodItemDescriptionChanged);
    on<FoodItemRecipeChanged>(_onFoodItemRecipeChanged);
    on<FoodItemMeasurementAdded>(_onFoodItemMeasurementAdded);
    on<FoodItemMeasurementDeleted>(_onFoodItemMeasurementDeleted);
    on<FoodItemMeasurementMethodChangedOthersNulled>(
        _onFoodItemMeasurementMethodChangedOthersNulled);
    on<FoodItemMeasurementUnitChanged>(_onFoodItemMeasurementUnitChanged);
    on<FoodItemMeasurementValueChanged>(_onFoodItemMeasurementValueChanged);
    on<FoodItemConfirmationChanged>(_onFoodItemConfirmationChanged);
    on<CollectionFinished>(_onCollectionFinished);
  }

  /// Returns index of `FoodItem` with matching `id` in a list of `foodItems`.
  /// Adds Error to the Bloc if no `FoodItem` with matching `id` found.
  int _getFoodItemIndexById(List<FoodItem> foodItems, String id) {
    int foodItemIndex = foodItems.indexWhere((item) => item.id == id);
    if (foodItemIndex == -1) {
      addError(
          Exception('No food item with given ID found!'), StackTrace.current);
    }
    return foodItemIndex;
  }

  /// Returns `FoodItem` of matching `id` in the `GibsonsForm` in the `state`.
  FoodItem _getFoodItemById(String id) {
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);
    return foodItems[_getFoodItemIndexById(foodItems, id)];
  }

  /// Finds a `FoodItem` with matching `id` in the `GibsonsForm` in the
  /// `state` and replaces it with the provided one.
  GibsonsForm _replaceFoodItemInGibsonsForm(FoodItem changedFoodItem) {
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);
    int changedFoodItemIndex =
        _getFoodItemIndexById(foodItems, changedFoodItem.id);
    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, changedFoodItem);

    return state.gibsonsForm.copyWith(foodItems: foodItems);
  }

  void _onSelectedScreenChanged(
      SelectedScreenChanged event, Emitter<CollectionState> emit) {
    emit(state.copyWith(selectedScreen: event.changedSelectedScreen));
  }

  void _onActiveStepChanged(
      ActiveStepChanged event, Emitter<CollectionState> emit) {
    emit(state.copyWith(activeStep: event.changedActiveStep));
  }

  void _onSurveyChanged(SurveyChanged event, Emitter<CollectionState> emit) {
    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(surveyId: event.surveyId);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onRecallDayChanged(
      RecallDayChanged event, Emitter<CollectionState> emit) {
    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(recallDay: event.recallDay);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onInterviewDateChanged(
      InterviewDateChanged event, Emitter<CollectionState> emit) {
    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(interviewDate: event.interviewDate);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onInterviewStartTimeChanged(
      InterviewStartTimeChanged event, Emitter<CollectionState> emit) {
    GibsonsForm changedGibsonsForm = state.gibsonsForm
        .copyWith(interviewStartTime: event.interviewStartTime);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onPhysioStatusChanged(
      PhysioStatusChanged event, Emitter<CollectionState> emit) {
    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(physioStatus: event.physioStatus);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onPictureChartCollectedChanged(
      PictureChartCollectedChanged event, Emitter<CollectionState> emit) {
    GibsonsForm changedGibsonsForm = state.gibsonsForm
        .copyWith(pictureChartCollected: event.pictureChartCollected);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onPictureChartNotCollectedReasonChanged(
      PictureChartNotCollectedReasonChanged event,
      Emitter<CollectionState> emit) {
    GibsonsForm changedGibsonsForm = state.gibsonsForm.copyWith(
        pictureChartNotCollectedReason: event.pictureChartNotCollectedReason);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onInterviewEndTimeChanged(
      InterviewEndTimeChanged event, Emitter<CollectionState> emit) {
    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(interviewEndTime: event.interviewEndTime);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onInterviewFinishedInOneVisitChanged(
      InterviewFinishedInOneVisitChanged event, Emitter<CollectionState> emit) {
    GibsonsForm changedGibsonsForm = state.gibsonsForm.copyWith(
        interviewFinishedInOneVisit: event.interviewFinishedInOneVisit);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onSecondInterviewVisitDateChanged(
      SecondInterviewVisitDateChanged event, Emitter<CollectionState> emit) {
    GibsonsForm changedGibsonsForm = state.gibsonsForm
        .copyWith(secondInterviewVisitDate: event.secondInterviewVisitDate);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onSecondVisitReasonChanged(
      SecondVisitReasonChanged event, Emitter<CollectionState> emit) {
    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(secondVisitReason: event.secondVisitReason);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onInterviewOutcomeChanged(
      InterviewOutcomeChanged event, Emitter<CollectionState> emit) {
    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(interviewOutcome: event.interviewOutcome);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onInterviewOutcomeNotCompletedReasonChanged(
      InterviewOutcomeNotCompletedReasonChanged event,
      Emitter<CollectionState> emit) {
    GibsonsForm changedGibsonsForm = state.gibsonsForm.copyWith(
        interviewOutcomeNotCompletedReason:
            event.interviewOutcomeNotCompletedReason);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onCommentsChanged(
      CommentsChanged event, Emitter<CollectionState> emit) {
    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(comments: event.comments);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemAdded(FoodItemAdded event, Emitter<CollectionState> emit) {
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);
    foodItems
        .add(FoodItem(id: const Uuid().v4(), measurements: [Measurement()]));

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemDeleted(
      FoodItemDeleted event, Emitter<CollectionState> emit) {
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    foodItems.removeWhere((item) => item.id == event.foodItemId);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemNameChanged(
      FoodItemNameChanged event, Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItemId);

    FoodItem changedFoodItem = foodItem.copyWith(
        name: event.foodItemName,
        confirmed: false); // any change to FoodItem unconfirms it

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onFoodItemTimePeriodChanged(
      FoodItemTimePeriodChanged event, Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItemId);

    FoodItem changedFoodItem = foodItem.copyWith(
        timePeriod: event.foodItemTimePeriod, confirmed: false);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onFoodItemSourceChanged(
      FoodItemSourceChanged event, Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItemId);

    FoodItem changedFoodItem =
        foodItem.copyWith(source: event.foodItemSource, confirmed: false);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onFoodItemPreparationMethodChanged(
      FoodItemPreparationMethodChanged event, Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItemId);

    FoodItem changedFoodItem = foodItem.copyWith(
        preparationMethod: event.foodItemPreparationMethod, confirmed: false);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onFoodItemCustomPreparationMethodChanged(
      FoodItemCustomPreparationMethodChanged event,
      Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItemId);

    FoodItem changedFoodItem = foodItem.copyWith(
        customPreparationMethod: event.foodItemCustomPreparationMethod,
        confirmed: false);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  // TODO: rename to comments
  void _onFoodItemDescriptionChanged(
      FoodItemDescriptionChanged event, Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItemId);

    FoodItem changedFoodItem = foodItem.copyWith(
        description: event.foodItemDescription, confirmed: false);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onFoodItemRecipeChanged(
      FoodItemRecipeChanged event, Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItemId);

    FoodItem changedFoodItem =
        foodItem.copyWith(recipe: event.foodItemRecipe, confirmed: false);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onFoodItemMeasurementAdded(
      FoodItemMeasurementAdded event, Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItemId);

    List<Measurement> measurements = List.from(foodItem.measurements);

    measurements.add(Measurement(id: const Uuid().v4()));

    FoodItem changedFoodItem =
        foodItem.copyWith(measurements: measurements, confirmed: false);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onFoodItemMeasurementDeleted(
      FoodItemMeasurementDeleted event, Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItemId);

    List<Measurement> measurements = List.from(foodItem.measurements);

    // TODO: refactor to UUID based indexing of measurements (hmm, not sure yet)
    // but definitely refactor changing of measurement later on
    int changedmeasurementIndex = event.measurementIndex;

    measurements.removeAt(changedmeasurementIndex);

    FoodItem changedFoodItem =
        foodItem.copyWith(measurements: measurements, confirmed: false);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onFoodItemMeasurementMethodChangedOthersNulled(
      FoodItemMeasurementMethodChangedOthersNulled event,
      Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItemId);

    List<Measurement> measurements = List.from(foodItem.measurements);

    int changedmeasurementIndex = event.measurementIndex;

    // since copyWith does not allow to null attributes, create new instance and
    // copy the original id and changed method (thus nulling value and unit)
    Measurement measurement = Measurement(id: const Uuid().v4());

    measurement = measurement.copyWith(
        id: measurements[changedmeasurementIndex].id,
        measurementMethod: event.measurementMethod);

    measurements.removeAt(changedmeasurementIndex);
    measurements.insert(changedmeasurementIndex, measurement);

    FoodItem changedFoodItem =
        foodItem.copyWith(measurements: measurements, confirmed: false);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onFoodItemMeasurementUnitChanged(
      FoodItemMeasurementUnitChanged event, Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItemId);

    List<Measurement> measurements = List.from(foodItem.measurements);

    int changedmeasurementIndex = event.measurementIndex;

    Measurement measurement = measurements[changedmeasurementIndex]
        .copyWith(measurementUnit: event.measurementUnit);

    measurements.removeAt(changedmeasurementIndex);
    measurements.insert(changedmeasurementIndex, measurement);

    FoodItem changedFoodItem =
        foodItem.copyWith(measurements: measurements, confirmed: false);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onFoodItemMeasurementValueChanged(
      FoodItemMeasurementValueChanged event, Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItemId);

    List<Measurement> measurements = List.from(foodItem.measurements);

    int changedmeasurementIndex = event.measurementIndex;

    Measurement measurement = measurements[changedmeasurementIndex]
        .copyWith(measurementValue: event.measurementValue);

    measurements.removeAt(changedmeasurementIndex);
    measurements.insert(changedmeasurementIndex, measurement);

    FoodItem changedFoodItem =
        foodItem.copyWith(measurements: measurements, confirmed: false);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onFoodItemConfirmationChanged(
      FoodItemConfirmationChanged event, Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItemId);

    FoodItem changedFoodItem =
        foodItem.copyWith(confirmed: event.foodItemConfirmed);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onCollectionFinished(
      CollectionFinished event, Emitter<CollectionState> emit) async {
    GibsonsForm changedGibsonsForm = state.gibsonsForm.copyWith(finished: true);
    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }
}
