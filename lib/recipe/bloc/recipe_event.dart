part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

class RecipeNameChanged extends RecipeEvent {
  final String recipeName;

  const RecipeNameChanged({required this.recipeName});

  @override
  List<Object> get props => [recipeName];
}

class RecipeNameUnfocused extends RecipeEvent {}

class RecipeNumberChanged extends RecipeEvent {
  final String recipeNumber;

  const RecipeNumberChanged({required this.recipeNumber});

  @override
  List<Object> get props => [recipeNumber];
}

class RecipeNumberUnfocused extends RecipeEvent {}

class RecipeVolumeChanged extends RecipeEvent {
  final String recipeVolume;

  const RecipeVolumeChanged({required this.recipeVolume});

  @override
  List<Object> get props => [recipeVolume];
}

class RecipeVolumeUnfocused extends RecipeEvent {}

class AddIngredient extends RecipeEvent {
  const AddIngredient();
}
