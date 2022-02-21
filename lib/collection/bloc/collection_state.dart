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
  // TODO: Investigate how to make this nullable without linter warnings
  final GeoLocationStatus geoLocationStatus;

  CollectionState(
      {GibsonsForm? gibsonsForm,
      this.selectedScreen = SelectedScreen.sensitization,
      this.geoLocationStatus = GeoLocationStatus.none})
      : gibsonsForm = gibsonsForm ?? GibsonsForm();

  CollectionState copyWith(
      {GibsonsForm? gibsonsForm,
      SelectedScreen? selectedScreen,
      GeoLocationStatus? geoLocationStatus}) {
    return CollectionState(
        gibsonsForm: gibsonsForm ?? this.gibsonsForm,
        selectedScreen: selectedScreen ?? this.selectedScreen,
        geoLocationStatus: geoLocationStatus ?? this.geoLocationStatus);
  }

  @override
  List<Object> get props => [gibsonsForm, selectedScreen, geoLocationStatus];

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
