part of 'recipe_bloc.dart';

class RecipeState extends Equatable {
  final List<Recipe> recipes;
  final String? ingredientsJson;
  final String? recipeImportStatus;
  final bool showMeasurements;
  final bool showIngredients;

  const RecipeState(
      {this.recipes = const <Recipe>[],
      this.ingredientsJson,
      this.recipeImportStatus,
      this.showMeasurements = true,
      this.showIngredients = true});

  RecipeState copyWith(
      {List<Recipe>? recipes,
      String? ingredientsJson,
      String? recipeImportStatus,
      bool? showMeasurements,
      bool? showIngredients}) {
    return RecipeState(
        recipes: recipes ?? this.recipes,
        ingredientsJson: ingredientsJson ?? this.ingredientsJson,
        recipeImportStatus: recipeImportStatus ?? this.recipeImportStatus,
        showMeasurements: showMeasurements ?? this.showMeasurements,
        showIngredients: showIngredients ?? this.showIngredients);
  }

  @override
  List<Object?> get props => [
        recipes,
        ingredientsJson,
        recipeImportStatus,
        showMeasurements,
        showIngredients
      ];
}
