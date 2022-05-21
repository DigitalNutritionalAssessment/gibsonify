import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  final GibsonifyRepository _gibsonifyRepository;

  CollectionBloc({required GibsonifyRepository gibsonifyRepository})
      : _gibsonifyRepository = gibsonifyRepository,
        super(CollectionState()) {
    on<SelectedScreenChanged>(_onSelectedScreenChanged);
    on<HouseholdIdChanged>(_onHouseholdIdChanged);
    on<RespondentNameChanged>(_onRespondentNameChanged);
    on<RespondentTelInfoChanged>(_onRespondentTelInfoChanged);
    on<SensitizationDateChanged>(_onSensitizationDateChanged);
    on<RecallDayChanged>(_onRecallDayChanged);
    on<InterviewDateChanged>(_onInterviewDateChanged);
    on<InterviewStartTimeChanged>(_onInterviewStartTimeChanged);
    on<GeoLocationRequested>(_onGeoLocationRequested);
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
    on<FoodItemDescriptionChanged>(_onFoodItemDescriptionChanged);
    on<FoodItemPreparationMethodChanged>(_onFoodItemPreparationMethodChanged);
    on<FoodItemCustomPreparationMethodChanged>(
        _onFoodItemCustomPreparationMethodChanged);
    on<FoodItemMeasurementAdded>(_onFoodItemMeasurementAdded);
    on<FoodItemMeasurementDeleted>(_onFoodItemMeasurementDeleted);
    on<FoodItemMeasurementMethodChangedOthersNulled>(
        _onFoodItemMeasurementMethodChangedOthersNulled);
    on<FoodItemMeasurementUnitChanged>(_onFoodItemMeasurementUnitChanged);
    on<FoodItemMeasurementValueChanged>(_onFoodItemMeasurementValueChanged);
    on<FoodItemConfirmationChanged>(_onFoodItemConfirmationChanged);
    on<FoodItemRecipeChanged>(_onFoodItemRecipeChanged);
    on<GibsonsFormSaved>(_onGibsonsFormSaved);
    on<GibsonsFormProvided>(_onGibsonsFormProvided);
    on<GibsonsFormCreated>(_onGibsonsFormCreated);
    on<GibsonsFormDuplicated>(_onGibsonsFormDuplicated);
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

  void _onHouseholdIdChanged(
      HouseholdIdChanged event, Emitter<CollectionState> emit) {
    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(householdId: event.householdId);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onRespondentNameChanged(
      RespondentNameChanged event, Emitter<CollectionState> emit) {
    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(respondentName: event.respondentName);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onRespondentTelInfoChanged(
      RespondentTelInfoChanged event, Emitter<CollectionState> emit) {
    GibsonsForm changedGibsonsForm = state.gibsonsForm.copyWith(
        respondentCountryCode: event.respondentCountryCode,
        respondentTelNumberPrefix: event.respondentTelNumberPrefix,
        respondentTelNumber: event.respondentTelNumber);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onSensitizationDateChanged(
      SensitizationDateChanged event, Emitter<CollectionState> emit) {
    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(sensitizationDate: event.sensitizationDate);

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

  Future<void> _onGeoLocationRequested(
      GeoLocationRequested event, Emitter<CollectionState> emit) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      emit(state.copyWith(
          geoLocationStatus: GeoLocationStatus.locationDisabled));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        emit(state.copyWith(
            geoLocationStatus: GeoLocationStatus.locationDenied));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      emit(state.copyWith(
          geoLocationStatus: GeoLocationStatus.locationPermanentlyDenied));
      return;
    }

    emit(
        state.copyWith(geoLocationStatus: GeoLocationStatus.locationRequested));

    String? geoLocationFormatted;

    try {
      Position position = await Geolocator.getCurrentPosition(
          timeLimit: const Duration(seconds: 45));

      geoLocationFormatted =
          '${position.latitude.toString()}, ${position.longitude.toString()}';
    } catch (e) {
      emit(state.copyWith(
          geoLocationStatus: GeoLocationStatus.locationTimedOut));

      geoLocationFormatted = 'Undetermined';
    }

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(geoLocation: geoLocationFormatted);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));

    if (geoLocationFormatted != 'Undetermined') {
      emit(state.copyWith(
          geoLocationStatus: GeoLocationStatus.locationDetermined));
    }
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
    foodItems.add(FoodItem());

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemDeleted(
      FoodItemDeleted event, Emitter<CollectionState> emit) {
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: event.foodItemId
    foodItems.removeWhere((item) => item.id == event.foodItem.id);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemNameChanged(
      FoodItemNameChanged event, Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItem.id); // TODO: foodItemId

    FoodItem changedFoodItem = foodItem.copyWith(
        name: event.foodItemName,
        confirmed: false); // any change to FoodItem unconfirms it

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onFoodItemTimePeriodChanged(
      FoodItemTimePeriodChanged event, Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItem.id); // TODO: foodItemId

    FoodItem changedFoodItem = foodItem.copyWith(
        timePeriod: event.foodItemTimePeriod, confirmed: false);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onFoodItemSourceChanged(
      FoodItemSourceChanged event, Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItem.id); // TODO: foodItemId

    FoodItem changedFoodItem =
        foodItem.copyWith(source: event.foodItemSource, confirmed: false);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onFoodItemDescriptionChanged(
      // TODO: change to comments and move down
      FoodItemDescriptionChanged event,
      Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItem.id); // TODO: foodItemId

    FoodItem changedFoodItem = foodItem.copyWith(
        description: event.foodItemDescription, confirmed: false);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onFoodItemPreparationMethodChanged(
      FoodItemPreparationMethodChanged event, Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItem.id); // TODO: foodItemId

    FoodItem changedFoodItem = foodItem.copyWith(
        preparationMethod: event.foodItemPreparationMethod, confirmed: false);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onFoodItemCustomPreparationMethodChanged(
      FoodItemCustomPreparationMethodChanged event,
      Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItem.id); // TODO: foodItemId

    FoodItem changedFoodItem = foodItem.copyWith(
        customPreparationMethod: event.foodItemCustomPreparationMethod,
        confirmed: false);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onFoodItemMeasurementAdded(
      FoodItemMeasurementAdded event, Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItem.id); // TODO: foodItemId

    List<Measurement> measurements = List.from(foodItem.measurements);

    measurements.add(Measurement());

    FoodItem changedFoodItem =
        foodItem.copyWith(measurements: measurements, confirmed: false);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onFoodItemMeasurementDeleted(
      FoodItemMeasurementDeleted event, Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItem.id); // TODO: foodItemId

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
    FoodItem foodItem = _getFoodItemById(event.foodItem.id); // TODO: foodItemId

    List<Measurement> measurements = List.from(foodItem.measurements);

    int changedmeasurementIndex = event.measurementIndex;

    // since copyWith does not allow to null attributes, create new instance and
    // copy the original id and changed method (thus nulling value and unit)

    Measurement measurement = Measurement();

    measurement = measurement.copyWith(
        id: measurements[changedmeasurementIndex].id,
        measurementMethod: event.foodItemMeasurementMethod);

    measurements.removeAt(changedmeasurementIndex);
    measurements.insert(changedmeasurementIndex, measurement);

    FoodItem changedFoodItem =
        foodItem.copyWith(measurements: measurements, confirmed: false);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onFoodItemMeasurementUnitChanged(
      FoodItemMeasurementUnitChanged event, Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItem.id); // TODO: foodItemId

    List<Measurement> measurements = List.from(foodItem.measurements);

    int changedmeasurementIndex = event.measurementIndex;

    Measurement measurement = measurements[changedmeasurementIndex]
        .copyWith(measurementUnit: event.foodItemMeasurementUnit);

    measurements.removeAt(changedmeasurementIndex);
    measurements.insert(changedmeasurementIndex, measurement);

    FoodItem changedFoodItem =
        foodItem.copyWith(measurements: measurements, confirmed: false);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onFoodItemMeasurementValueChanged(
      FoodItemMeasurementValueChanged event, Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItem.id); // TODO: foodItemId

    List<Measurement> measurements = List.from(foodItem.measurements);

    int changedmeasurementIndex = event.measurementIndex;

    Measurement measurement = measurements[changedmeasurementIndex]
        .copyWith(measurementValue: event.foodItemMeasurementValue);

    measurements.removeAt(changedmeasurementIndex);
    measurements.insert(changedmeasurementIndex, measurement);

    FoodItem changedFoodItem =
        foodItem.copyWith(measurements: measurements, confirmed: false);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  void _onFoodItemConfirmationChanged(
      FoodItemConfirmationChanged event, Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItem.id); // TODO: foodItemId

    FoodItem changedFoodItem =
        foodItem.copyWith(confirmed: event.foodItemConfirmed);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  // TODO: reorder (move up)
  void _onFoodItemRecipeChanged(
      FoodItemRecipeChanged event, Emitter<CollectionState> emit) {
    FoodItem foodItem = _getFoodItemById(event.foodItemId);

    FoodItem changedFoodItem =
        foodItem.copyWith(recipe: event.foodItemRecipe, confirmed: false);

    emit(state.copyWith(
        gibsonsForm: _replaceFoodItemInGibsonsForm(changedFoodItem)));
  }

  // or Future<void> ?
  void _onGibsonsFormSaved(
      GibsonsFormSaved event, Emitter<CollectionState> emit) async {
    await _gibsonifyRepository.saveForm(state.gibsonsForm);
    emit(state);
  }

  // TODO: Delete the async?
  void _onGibsonsFormProvided(
      GibsonsFormProvided event, Emitter<CollectionState> emit) async {
    emit(state.copyWith(
        gibsonsForm: event.gibsonsForm,
        selectedScreen: SelectedScreen.sensitization,
        geoLocationStatus: GeoLocationStatus.none));
  }

  void _onGibsonsFormCreated(
      GibsonsFormCreated event, Emitter<CollectionState> emit) {
    GibsonsForm gibsonsFormCreated =
        GibsonsForm(employeeNumber: event.employeeNumber);
    emit(state.copyWith(
        gibsonsForm: gibsonsFormCreated,
        selectedScreen: SelectedScreen.sensitization,
        geoLocationStatus: GeoLocationStatus.none));
  }

  void _onGibsonsFormDuplicated(
      GibsonsFormDuplicated event, Emitter<CollectionState> emit) async {
    final respondentNameAndCopyText = event.gibsonsForm.respondentName == null
        ? 'Unnamed respondent copy'
        : '${event.gibsonsForm.respondentName!} copy';
    GibsonsForm gibsonsFormDuplicated = event.gibsonsForm.copyWith(
        id: const Uuid().v4(),
        employeeNumber: event.employeeNumber,
        respondentName: respondentNameAndCopyText,
        finished: false);

    emit(state.copyWith(
        gibsonsForm: gibsonsFormDuplicated,
        selectedScreen: SelectedScreen.sensitization,
        geoLocationStatus: GeoLocationStatus.none));

    // TODO: Move saving of collections to HomeBloc to avoid race conditions
    await _gibsonifyRepository.saveForm(state.gibsonsForm);
  }

  void _onCollectionFinished(
      CollectionFinished event, Emitter<CollectionState> emit) async {
    GibsonsForm changedGibsonsForm = state.gibsonsForm.copyWith(finished: true);
    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
    // TODO: Move saving of collections to HomeBloc to avoid race conditions
    await _gibsonifyRepository.saveForm(state.gibsonsForm);
  }
}
