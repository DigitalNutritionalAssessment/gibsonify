part of 'collection_bloc.dart';

enum SelectedScreen {
  sensitization,
  firstPass,
  secondPass,
  thirdPass,
  fourthPass,
  finish
}

class CollectionState extends Equatable {
  final GibsonsForm gibsonsForm;
  final int activeStep;

  const CollectionState({required this.gibsonsForm, this.activeStep = 0});

  CollectionState copyWith({
    GibsonsForm? gibsonsForm,
    int? activeStep,
  }) {
    return CollectionState(
        gibsonsForm: gibsonsForm ?? this.gibsonsForm,
        activeStep: activeStep ?? this.activeStep);
  }

  @override
  List<Object> get props => [gibsonsForm, activeStep];
}
