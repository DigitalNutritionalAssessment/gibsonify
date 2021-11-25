part of 'collection_bloc.dart';

class CollectionState extends Equatable {
  final GibsonsForm gibsonsForm;

  const CollectionState({this.gibsonsForm = const GibsonsForm()});

  CollectionState copyWith({GibsonsForm? gibsonsForm}) {
    return CollectionState(gibsonsForm: gibsonsForm ?? this.gibsonsForm);
  }

  @override
  List<Object> get props => [gibsonsForm];
}
