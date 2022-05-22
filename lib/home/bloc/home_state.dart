part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.gibsonsForms = const [],
  });

  final List<GibsonsForm?> gibsonsForms;

  HomeState copyWith({
    List<GibsonsForm?>? gibsonsForms,
  }) {
    return HomeState(
      gibsonsForms: gibsonsForms ?? this.gibsonsForms,
    );
  }

  @override
  List<Object?> get props => [
        gibsonsForms,
      ];
}
