part of 'collection_bloc.dart';

class CollectionState extends Equatable {
  final GibsonsForm gibsonsForm;

  CollectionState({GibsonsForm? gibsonsForm})
      : gibsonsForm = gibsonsForm ?? GibsonsForm();

  CollectionState copyWith({GibsonsForm? gibsonsForm}) {
    return CollectionState(gibsonsForm: gibsonsForm ?? this.gibsonsForm);
  }

  @override
  List<Object> get props => [gibsonsForm];
}
