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
