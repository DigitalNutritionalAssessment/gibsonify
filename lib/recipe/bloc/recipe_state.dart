part of 'recipe_bloc.dart';

class RecipeState extends Equatable {
  final List<Recipe> recipes;
  final String? ingredientsJson;
  final String? recipeImportStatus;

  const RecipeState({
    this.recipes = const <Recipe>[],
    this.ingredientsJson,
    this.recipeImportStatus,
  });

  RecipeState copyWith({
    List<Recipe>? recipes,
    String? ingredientsJson,
    String? recipeImportStatus,
  }) {
    return RecipeState(
      recipes: recipes ?? this.recipes,
      ingredientsJson: ingredientsJson ?? this.ingredientsJson,
      recipeImportStatus: recipeImportStatus ?? this.recipeImportStatus,
    );
  }

  @override
  List<Object?> get props => [recipes, ingredientsJson, recipeImportStatus];

  // TODO: These methods should be deleted and moved to the API if needed
  Map<String, dynamic> toMap() {
    return {
      'recipes': recipes.map((x) => x.toJson()).toList(),
    };
  }

  factory RecipeState.fromMap(Map<String, dynamic> map) {
    return RecipeState(
      recipes:
          List<Recipe>.from(map['recipes']?.map((x) => Recipe.fromJson(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipeState.fromJson(String source) =>
      RecipeState.fromMap(json.decode(source));
}
