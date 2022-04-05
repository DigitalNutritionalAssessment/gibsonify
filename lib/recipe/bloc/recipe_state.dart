part of 'recipe_bloc.dart';

class RecipeState extends Equatable {
  final List<Recipe> recipes;
  final String? ingredientsJson;
  final String? recipeImportStatus;

  const RecipeState(
      {this.recipes = const <Recipe>[],
      this.ingredientsJson,
      this.recipeImportStatus});

  RecipeState copyWith(
      {List<Recipe>? recipes,
      String? ingredientsJson,
      String? recipeImportStatus}) {
    return RecipeState(
        recipes: recipes ?? this.recipes,
        ingredientsJson: ingredientsJson ?? this.ingredientsJson,
        recipeImportStatus: recipeImportStatus ?? this.recipeImportStatus);
  }

  @override
  List<Object?> get props => [
        recipes,
        ingredientsJson,
        recipeImportStatus,
      ];
}
