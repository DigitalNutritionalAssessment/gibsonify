part of 'collection_bloc.dart';

enum GeoLocationStatus {
  none, // TODO: delete this once the field is nullable in the state
  locationRequested,
  locationDisabled,
  locationDenied,
  locationPermanentlyDenied,
  locationTimedOut,
  locationDetermined,
}

enum SelectedScreen {
  sensitization,
  firstPass,
  secondPass,
  thirdPass,
  fourthPass,
}

class CollectionState extends Equatable {
  final GibsonsForm gibsonsForm;
  final SelectedScreen selectedScreen;
  final int activeStep;
  // TODO: Investigate how to make this nullable without linter warnings
  final GeoLocationStatus geoLocationStatus;

  CollectionState(
      {required this.gibsonsForm,
      this.selectedScreen = SelectedScreen.sensitization,
      this.geoLocationStatus = GeoLocationStatus.none,
      this.activeStep = 0});

  CollectionState copyWith(
      {GibsonsForm? gibsonsForm,
      SelectedScreen? selectedScreen,
      int? activeStep,
      GeoLocationStatus? geoLocationStatus}) {
    return CollectionState(
        gibsonsForm: gibsonsForm ?? this.gibsonsForm,
        selectedScreen: selectedScreen ?? this.selectedScreen,
        activeStep: activeStep ?? this.activeStep,
        geoLocationStatus: geoLocationStatus ?? this.geoLocationStatus);
  }

  @override
  List<Object> get props =>
      [gibsonsForm, selectedScreen, activeStep, geoLocationStatus];

  final Map<SelectedScreen, int> _selectedScreenIndices = {
    SelectedScreen.sensitization: 0,
    SelectedScreen.firstPass: 1,
    SelectedScreen.secondPass: 2,
    SelectedScreen.thirdPass: 3,
    SelectedScreen.fourthPass: 4,
  };

  int selectedScreenIndex() {
    int? index = _selectedScreenIndices[selectedScreen];
    if (index == null) {
      throw const FormatException('Index of selected screen not found');
    } else {
      return index;
    }
  }

  SelectedScreen screenOfSelectedIndex(int index) {
    var indicesToScreens = _selectedScreenIndices.map((k, v) => MapEntry(v, k));
    SelectedScreen? selectedScreen = indicesToScreens[index];
    if (selectedScreen == null) {
      throw const FormatException('Screen of selected index not found');
    } else {
      return selectedScreen;
    }
  }
}
