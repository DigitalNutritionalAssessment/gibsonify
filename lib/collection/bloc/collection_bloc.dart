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
    on<FoodItemMeasurementAdded>(_onFoodItemMeasurementAdded);
    on<FoodItemMeasurementDeleted>(_onFoodItemMeasurementDeleted);
    on<FoodItemMeasurementMethodChanged>(_onFoodItemMeasurementMethodChanged);
    on<FoodItemMeasurementValueChanged>(_onFoodItemMeasurementValueChanged);
    on<FoodItemMeasurementUnitChanged>(_onFoodItemMeasurementUnitChanged);
    on<FoodItemConfirmationChanged>(_onFoodItemConfirmationChanged);
    on<FoodItemRecipeChanged>(_onFoodItemRecipeChanged);
    on<GibsonsFormSaved>(_onGibsonsFormSaved);
    on<GibsonsFormProvided>(_onGibsonsFormProvided);
    on<GibsonsFormCreated>(_onGibsonsFormCreated);
    on<GibsonsFormDuplicated>(_onGibsonsFormDuplicated);
    on<CollectionFinished>(_onCollectionFinished);
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
          position.latitude.toString() + ', ' + position.longitude.toString();
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
    final foodItem = FoodItem();
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);
    foodItems.add(foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemDeleted(
      FoodItemDeleted event, Emitter<CollectionState> emit) {
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    foodItems.remove(event.foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemNameChanged(
      FoodItemNameChanged event, Emitter<CollectionState> emit) {
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    FoodItem foodItem = foodItems[changedFoodItemIndex].copyWith(
        name: event.foodItemName,
        confirmed: false); // any change to FoodItem unconfirms it

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemTimePeriodChanged(
      FoodItemTimePeriodChanged event, Emitter<CollectionState> emit) {
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    FoodItem foodItem = foodItems[changedFoodItemIndex]
        .copyWith(timePeriod: event.foodItemTimePeriod, confirmed: false);

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemSourceChanged(
      FoodItemSourceChanged event, Emitter<CollectionState> emit) {
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    FoodItem foodItem = foodItems[changedFoodItemIndex]
        .copyWith(source: event.foodItemSource, confirmed: false);

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemDescriptionChanged(
      FoodItemDescriptionChanged event, Emitter<CollectionState> emit) {
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    FoodItem foodItem = foodItems[changedFoodItemIndex]
        .copyWith(description: event.foodItemDescription, confirmed: false);

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemPreparationMethodChanged(
      FoodItemPreparationMethodChanged event, Emitter<CollectionState> emit) {
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    FoodItem foodItem = foodItems[changedFoodItemIndex].copyWith(
        preparationMethod: event.foodItemPreparationMethod, confirmed: false);

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemMeasurementAdded(
      FoodItemMeasurementAdded event, Emitter<CollectionState> emit) {
    // TODO: refactor all of this finding an item and changing
    // it logic to one reusable function, probably a method of the GibsonsForm
    // class
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    List<Measurement> measurements =
        List.from(foodItems[changedFoodItemIndex].measurements);

    final measurement = Measurement();

    measurements.add(measurement);

    FoodItem foodItem = foodItems[changedFoodItemIndex]
        .copyWith(measurements: measurements, confirmed: false);

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemMeasurementDeleted(
      FoodItemMeasurementDeleted event, Emitter<CollectionState> emit) {
    // TODO: refactor all of this finding an item and changing
    // it logic to one reusable function, probably a method of the GibsonsForm
    // class
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    List<Measurement> measurements =
        List.from(foodItems[changedFoodItemIndex].measurements);

    // TODO: refactor to UUID based indexing of measurements
    int changedmeasurementIndex = event.measurementIndex;

    measurements.removeAt(changedmeasurementIndex);

    FoodItem foodItem = foodItems[changedFoodItemIndex]
        .copyWith(measurements: measurements, confirmed: false);

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemMeasurementMethodChanged(
      FoodItemMeasurementMethodChanged event, Emitter<CollectionState> emit) {
    // TODO: refactor all of this finding an item and changing
    // it logic to one reusable function, probably a method of the GibsonsForm
    // class
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    List<Measurement> measurements =
        List.from(foodItems[changedFoodItemIndex].measurements);
    int changedmeasurementIndex = event.measurementIndex;

    Measurement measurement = measurements[changedmeasurementIndex]
        .copyWith(measurementMethod: event.foodItemMeasurementMethod);

    measurements.removeAt(changedmeasurementIndex);
    measurements.insert(changedmeasurementIndex, measurement);

    FoodItem foodItem = foodItems[changedFoodItemIndex]
        .copyWith(measurements: measurements, confirmed: false);

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemMeasurementValueChanged(
      FoodItemMeasurementValueChanged event, Emitter<CollectionState> emit) {
    // TODO: refactor all of this finding an item and changing
    // it logic to one reusable function, probably a method of the GibsonsForm
    // class
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    List<Measurement> measurements =
        List.from(foodItems[changedFoodItemIndex].measurements);
    int changedmeasurementIndex = event.measurementIndex;

    Measurement measurement = measurements[changedmeasurementIndex]
        .copyWith(measurementValue: event.foodItemMeasurementValue);

    measurements.removeAt(changedmeasurementIndex);
    measurements.insert(changedmeasurementIndex, measurement);

    FoodItem foodItem = foodItems[changedFoodItemIndex]
        .copyWith(measurements: measurements, confirmed: false);

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemMeasurementUnitChanged(
      FoodItemMeasurementUnitChanged event, Emitter<CollectionState> emit) {
    // TODO: refactor all of this finding an item and changing
    // it logic to one reusable function, probably a method of the GibsonsForm
    // class
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    List<Measurement> measurements =
        List.from(foodItems[changedFoodItemIndex].measurements);
    int changedmeasurementIndex = event.measurementIndex;

    Measurement measurement = measurements[changedmeasurementIndex]
        .copyWith(measurementUnit: event.foodItemMeasurementUnit);

    measurements.removeAt(changedmeasurementIndex);
    measurements.insert(changedmeasurementIndex, measurement);

    FoodItem foodItem = foodItems[changedFoodItemIndex]
        .copyWith(measurements: measurements, confirmed: false);

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemConfirmationChanged(
      FoodItemConfirmationChanged event, Emitter<CollectionState> emit) {
    // TODO: refactor all of this finding an item and changing
    // it logic to one reusable function, probably a method of the GibsonsForm
    // class
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    FoodItem foodItem = foodItems[changedFoodItemIndex]
        .copyWith(confirmed: event.foodItemConfirmed);

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemRecipeChanged(
      FoodItemRecipeChanged event, Emitter<CollectionState> emit) {
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    int changedFoodItemIndex =
        foodItems.indexWhere((item) => item.id == event.foodItemId);

    if (changedFoodItemIndex >= 0) {
      FoodItem foodItem = foodItems[changedFoodItemIndex]
          .copyWith(recipe: event.foodItemRecipe, confirmed: false);
      foodItems.removeAt(changedFoodItemIndex);
      foodItems.insert(changedFoodItemIndex, foodItem);
      GibsonsForm changedGibsonsForm =
          state.gibsonsForm.copyWith(foodItems: foodItems);
      emit(state.copyWith(gibsonsForm: changedGibsonsForm));
    } else {
      // TODO: handle item not found case
      print('food item not found!'); // TODO: delete
      emit(state);
    }
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
        : event.gibsonsForm.respondentName! + ' copy';
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
