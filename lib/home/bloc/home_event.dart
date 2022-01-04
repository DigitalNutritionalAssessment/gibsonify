part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GibsonsFormsLoaded extends HomeEvent {
  const GibsonsFormsLoaded();

  @override
  List<Object> get props => [];
}

class GibsonsFormDeleted extends HomeEvent {
  final String id;
  const GibsonsFormDeleted({required this.id});

  @override
  List<Object> get props => [id];
}
