part of 'collection_bloc.dart';

class CollectionState extends Equatable {
  final Collection collection;
  const CollectionState(this.collection);

  @override
  List<Object> get props => [collection];
}

// class CollectionSuccess extends CollectionState {

//   const CollectionSuccess(collection: this.collection);

//   @override
//   List<Object> get props => [collection];
// }
