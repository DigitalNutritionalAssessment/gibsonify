part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

class RecipeAdded extends RecipeEvent {}

class RecipeNameChanged extends RecipeEvent {
  final String recipeName;
  final Recipe recipe;

  const RecipeNameChanged({required this.recipeName, required this.recipe});

  @override
  List<Object> get props => [recipeName, recipe];
}

class RecipeNumberChanged extends RecipeEvent {
  final String recipeNumber;
  final Recipe recipe;

  const RecipeNumberChanged({required this.recipeNumber, required this.recipe});

  @override
  List<Object> get props => [recipeNumber, recipe];
}

class RecipeVolumeChanged extends RecipeEvent {
  final String recipeVolume;
  final Recipe recipe;

  const RecipeVolumeChanged({required this.recipeVolume, required this.recipe});

  @override
  List<Object> get props => [recipeVolume, recipe];
}

class RecipeStatusChanged extends RecipeEvent {
  final bool recipeSaved;
  final Recipe recipe;

  const RecipeStatusChanged({required this.recipeSaved, required this.recipe});

  @override
  List<Object> get props => [recipeSaved, recipe];
}

class IngredientAdded extends RecipeEvent {
  final Recipe recipe;

  const IngredientAdded({required this.recipe});

  @override
  List<Object> get props => [recipe];
}

class IngredientStatusChanged extends RecipeEvent {
  final bool ingredientSaved;
  final Ingredient ingredient;
  final Recipe recipe;

  const IngredientStatusChanged(
      {required this.ingredientSaved,
      required this.ingredient,
      required this.recipe});

  @override
  List<Object> get props => [ingredientSaved, ingredient, recipe];
}

class IngredientNameChanged extends RecipeEvent {
  final String ingredientName;
  final Ingredient ingredient;
  final Recipe recipe;

  const IngredientNameChanged(
      {required this.ingredientName,
      required this.ingredient,
      required this.recipe});

  @override
  List<Object> get props => [ingredientName, ingredient, recipe];
}

class IngredientDescriptionChanged extends RecipeEvent {
  final String ingredientDescription;
  final Ingredient ingredient;
  final Recipe recipe;

  const IngredientDescriptionChanged(
      {required this.ingredientDescription,
      required this.ingredient,
      required this.recipe});

  @override
  List<Object> get props => [ingredientDescription, ingredient, recipe];
}

class CookingStateChanged extends RecipeEvent {
  final String cookingState;
  final Ingredient ingredient;
  final Recipe recipe;

  const CookingStateChanged(
      {required this.cookingState,
      required this.ingredient,
      required this.recipe});

  @override
  List<Object> get props => [cookingState, ingredient, recipe];
}

class MeasurementMethodChanged extends RecipeEvent {
  final String measurementMethod;
  final Ingredient ingredient;
  final Recipe recipe;

  const MeasurementMethodChanged(
      {required this.measurementMethod,
      required this.ingredient,
      required this.recipe});

  @override
  List<Object> get props => [measurementMethod, ingredient, recipe];
}

class MeasurementChanged extends RecipeEvent {
  final String measurement;
  final Ingredient ingredient;
  final Recipe recipe;

  const MeasurementChanged(
      {required this.measurement,
      required this.ingredient,
      required this.recipe});

  @override
  List<Object> get props => [measurement, ingredient, recipe];
}

class MeasurementUnitChanged extends RecipeEvent {
  final String measurementUnit;
  final Ingredient ingredient;
  final Recipe recipe;

  const MeasurementUnitChanged(
      {required this.measurementUnit,
      required this.ingredient,
      required this.recipe});

  @override
  List<Object> get props => [measurementUnit, ingredient, recipe];
}

class SizeChanged extends RecipeEvent {
  final String size;
  final Ingredient ingredient;
  final Recipe recipe;

  const SizeChanged(
      {required this.size, required this.ingredient, required this.recipe});

  @override
  List<Object> get props => [size, ingredient, recipe];
}

class SizeNumberChanged extends RecipeEvent {
  final String sizeNumber;
  final Ingredient ingredient;
  final Recipe recipe;

  const SizeNumberChanged(
      {required this.sizeNumber,
      required this.ingredient,
      required this.recipe});

  @override
  List<Object> get props => [sizeNumber, ingredient, recipe];
}
