part of 'recipe_bloc.dart';

class RecipeState extends Equatable {
  final List<Recipe> recipes;
  final String? ingredientsJson;

  const RecipeState({
    this.recipes = const <Recipe>[],
    this.ingredientsJson,
  });

  RecipeState copyWith({
    List<Recipe>? recipes,
    String? ingredientsJson,
  }) {
    return RecipeState(
      recipes: recipes ?? this.recipes,
      ingredientsJson: ingredientsJson ?? this.ingredientsJson,
    );
  }

  @override
  List<Object?> get props => [recipes, ingredientsJson];

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
