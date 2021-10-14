part of 'recipe_bloc.dart';

class RecipeState extends Equatable {
  final RecipeName recipeName;
  final RecipeNumber recipeNumber;
  final RecipeVolume recipeVolume;
  final FormzStatus recipeStatus;

  const RecipeState(
      {this.recipeName = const RecipeName.pure(),
      this.recipeNumber = const RecipeNumber.pure(),
      this.recipeVolume = const RecipeVolume.pure(),
      this.recipeStatus = FormzStatus.pure});

  RecipeState copyWith(
      {RecipeName? recipeName,
      RecipeNumber? recipeNumber,
      RecipeVolume? recipeVolume,
      FormzStatus? recipeStatus}) {
    return RecipeState(
        recipeName: recipeName ?? this.recipeName,
        recipeNumber: recipeNumber ?? this.recipeNumber,
        recipeVolume: recipeVolume ?? this.recipeVolume,
        recipeStatus: recipeStatus ?? this.recipeStatus);
  }

  @override
  List<Object> get props => [
        recipeName,
        recipeNumber,
        recipeVolume,
      ];
}
