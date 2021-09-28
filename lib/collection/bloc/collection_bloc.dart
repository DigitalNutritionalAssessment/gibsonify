import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:gibsonify/collection/models/models.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  static const Collection _collection = Collection();

  CollectionBloc() : super(const CollectionState(_collection)) {
    // on<CollectionEvent>((event, emit) {
    //   // TODO: implement event handler
    // }
    on<CollectionUpdated>(_onUpdated);
  }

  void _onUpdated(CollectionUpdated event, Emitter<CollectionState> emit) {
    emit(CollectionState(event.collection));
  }

  // Here there will be different events e.g. onCollectionFirstPassCompleted

}
