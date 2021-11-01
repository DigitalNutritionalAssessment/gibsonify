part of 'recipe_bloc.dart';

class RecipeState extends Equatable {
  // final RecipeName recipeName;
  // final RecipeNumber recipeNumber;
  // final RecipeVolume recipeVolume;
  // final FormzStatus recipeStatus;
  final List<Recipe> recipes;
  // final List<Ingredient> ingredients;

  const RecipeState({
    // this.recipeName = const RecipeName.pure(),
    // this.recipeNumber = const RecipeNumber.pure(),
    // this.recipeVolume = const RecipeVolume.pure(),
    // this.recipeStatus = FormzStatus.pure,
    this.recipes = const <Recipe>[],
    // this.ingredients = const <Ingredient>[]
  });

  RecipeState copyWith({
    // RecipeName? recipeName,
    // RecipeNumber? recipeNumber,
    // RecipeVolume? recipeVolume,
    // FormzStatus? recipeStatus,
    List<Recipe>? recipes,
    // List<Ingredient>? ingredients
  }) {
    return RecipeState(
      // recipeName: recipeName ?? this.recipeName,
      // recipeNumber: recipeNumber ?? this.recipeNumber,
      // recipeVolume: recipeVolume ?? this.recipeVolume,
      // recipeStatus: recipeStatus ?? this.recipeStatus,
      recipes: recipes ?? this.recipes,
      // ingredients: ingredients ?? this.ingredients
    );
  }

  @override
  List<Object> get props => [
        // recipeName, recipeNumber, recipeVolume,
        recipes,
        // ingredients
      ];
}
