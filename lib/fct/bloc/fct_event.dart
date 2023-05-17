part of 'fct_bloc.dart';

abstract class FCTEvent extends Equatable {
  const FCTEvent();

  @override
  List<Object> get props => [];
}

class FCTOpened extends FCTEvent {
  const FCTOpened();

  @override
  List<Object> get props => [];
}

class SearchQueryChanged extends FCTEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
