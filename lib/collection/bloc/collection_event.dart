part of 'collection_bloc.dart';

abstract class CollectionEvent extends Equatable {
  const CollectionEvent();

  @override
  List<Object> get props => [];
}

// TODO: modularize this into more atomic events as
// CollectionNameUpdated, CollectionFoodAdded, etc.
class CollectionUpdated extends CollectionEvent {
  final Collection collection;

  const CollectionUpdated(this.collection);

  @override
  List<Object> get props => [collection];
}
