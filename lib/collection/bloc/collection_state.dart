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

class CollectionState extends Equatable {
  final GibsonsForm gibsonsForm;
  final int selectedScreenIndex;
  // TODO: Investigate how to make this nullable without linter warnings
  final GeoLocationStatus geoLocationStatus;

  CollectionState(
      {GibsonsForm? gibsonsForm,
      this.selectedScreenIndex = 0,
      this.geoLocationStatus = GeoLocationStatus.none})
      : gibsonsForm = gibsonsForm ?? GibsonsForm();

  CollectionState copyWith(
      {GibsonsForm? gibsonsForm,
      int? selectedScreenIndex,
      GeoLocationStatus? geoLocationStatus}) {
    return CollectionState(
        gibsonsForm: gibsonsForm ?? this.gibsonsForm,
        selectedScreenIndex: selectedScreenIndex ?? this.selectedScreenIndex,
        geoLocationStatus: geoLocationStatus ?? this.geoLocationStatus);
  }

  @override
  List<Object> get props =>
      [gibsonsForm, selectedScreenIndex, geoLocationStatus];
}
