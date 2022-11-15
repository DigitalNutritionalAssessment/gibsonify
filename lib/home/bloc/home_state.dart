part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.gibsonsForms = const [],
    this.households = const [],
  });

  final List<GibsonsForm?> gibsonsForms;
  final List<Household> households;

  HomeState copyWith({
    List<GibsonsForm?>? gibsonsForms,
    List<Household>? households,
  }) {
    return HomeState(
      gibsonsForms: gibsonsForms ?? this.gibsonsForms,
      households: households ?? this.households,
    );
  }

  @override
  List<Object?> get props => [
        gibsonsForms,
        households,
      ];
}
