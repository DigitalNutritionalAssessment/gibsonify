part of 'recipe_bloc.dart';

class RecipeState extends Equatable {
  final List<Recipe> recipes;

  const RecipeState({
    this.recipes = const <Recipe>[],
  });

  RecipeState copyWith({
    List<Recipe>? recipes,
  }) {
    return RecipeState(
      recipes: recipes ?? this.recipes,
    );
  }

  @override
  List<Object> get props => [recipes];
}
