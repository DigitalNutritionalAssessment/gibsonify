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

class SaveNewHousehold extends HomeEvent {
  final String householdId;
  final DateTime sensitizationDate;
  final String geoLocation;
  final String comments;

  const SaveNewHousehold({
    required this.householdId,
    required this.sensitizationDate,
    required this.geoLocation,
    required this.comments,
  });

  @override
  List<Object> get props => [
        householdId,
        sensitizationDate,
        geoLocation,
        comments,
      ];
}

class DeleteHousehold extends HomeEvent {
  final int id;
  const DeleteHousehold({required this.id});

  @override
  List<Object> get props => [id];
}
