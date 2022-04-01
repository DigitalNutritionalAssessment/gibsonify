part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState(
      {this.gibsonsForms = const [], this.collectionDuplicationMode = false});

  final List<GibsonsForm?> gibsonsForms;
  final bool collectionDuplicationMode;

  HomeState copyWith(
      {List<GibsonsForm?>? gibsonsForms, bool? collectionDuplicationMode}) {
    return HomeState(
        gibsonsForms: gibsonsForms ?? this.gibsonsForms,
        collectionDuplicationMode:
            collectionDuplicationMode ?? this.collectionDuplicationMode);
  }

  @override
  List<Object> get props => [gibsonsForms, collectionDuplicationMode];
}
