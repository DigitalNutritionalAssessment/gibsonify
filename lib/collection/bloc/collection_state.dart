part of 'collection_bloc.dart';

class CollectionState extends Equatable {
  final GibsonsForm gibsonsForm;
  int selectedScreenIndex;

  CollectionState({GibsonsForm? gibsonsForm, this.selectedScreenIndex = 0})
      : gibsonsForm = gibsonsForm ?? GibsonsForm();

  CollectionState copyWith(
      {GibsonsForm? gibsonsForm, int? selectedScreenIndex}) {
    return CollectionState(
        gibsonsForm: gibsonsForm ?? this.gibsonsForm,
        selectedScreenIndex: selectedScreenIndex ?? this.selectedScreenIndex);
  }

  @override
  List<Object> get props => [gibsonsForm, selectedScreenIndex];
}
