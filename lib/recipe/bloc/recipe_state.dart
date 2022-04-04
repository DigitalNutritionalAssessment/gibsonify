part of 'recipe_bloc.dart';

enum RecipesExportStatus {
  notRequested,
  noRecipes,
  noPermissionToSaveFile,
  externalSaveSuccess,
  error
}

class RecipeState extends Equatable {
  final List<Recipe> recipes;
  final String? ingredientsJson;
  final String? recipeImportStatus;
  final int? exportedRecipesNumber;
  final RecipesExportStatus recipesExportStatus;

  const RecipeState(
      {this.recipes = const <Recipe>[],
      this.ingredientsJson,
      this.recipeImportStatus,
      this.exportedRecipesNumber,
      this.recipesExportStatus = RecipesExportStatus.notRequested});

  RecipeState copyWith(
      {List<Recipe>? recipes,
      String? ingredientsJson,
      String? recipeImportStatus,
      int? exportedRecipesNumber,
      RecipesExportStatus? recipesExportStatus}) {
    return RecipeState(
        recipes: recipes ?? this.recipes,
        ingredientsJson: ingredientsJson ?? this.ingredientsJson,
        recipeImportStatus: recipeImportStatus ?? this.recipeImportStatus,
        exportedRecipesNumber:
            exportedRecipesNumber ?? this.exportedRecipesNumber,
        recipesExportStatus: recipesExportStatus ?? this.recipesExportStatus);
  }

  @override
  List<Object?> get props => [
        recipes,
        ingredientsJson,
        recipeImportStatus,
        exportedRecipesNumber,
        recipesExportStatus
      ];
}
