part of 'collection_bloc.dart';

abstract class CollectionEvent extends Equatable {
  const CollectionEvent();

  @override
  List<Object> get props => [];
}

// TODO: modularize this into more atomic events as
// CollectionHouseholdIdUpdated, CollectionFoodAdded, etc.
class CollectionUpdated extends CollectionEvent {
  final Collection collection;

  const CollectionUpdated(this.collection);

  @override
  List<Object> get props => [collection];
}


// TODO: implement: class CollectionHouseholdIdUpdated extend CollectionEvent {}
// and then in collection bloc add logic that will check the new id
// and then add different collection states — probably something like
// CollectionSucces and CollectionFailure - or maybe even more atomic
// with CollectionHouseholdIdFailure or so
// basically have to think about the BLoC API - what should the black box
// do, what events receive for the form and what states to output