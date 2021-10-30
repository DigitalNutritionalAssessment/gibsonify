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

class RecipeNumberChanged extends RecipeEvent {
  final String recipeNumber;

  const RecipeNumberChanged({required this.recipeNumber});

  @override
  List<Object> get props => [recipeNumber];
}

class RecipeVolumeChanged extends RecipeEvent {
  final String recipeVolume;

  const RecipeVolumeChanged({required this.recipeVolume});

  @override
  List<Object> get props => [recipeVolume];
}

class IngredientAdded extends RecipeEvent {}

class IngredientNameChanged extends RecipeEvent {
  final String ingredientName;
  final Ingredient ingredient;

  const IngredientNameChanged(
      {required this.ingredientName, required this.ingredient});

  @override
  List<Object> get props => [ingredientName, ingredient];
}

class IngredientDescriptionChanged extends RecipeEvent {
  final String ingredientDescription;
  final Ingredient ingredient;

  const IngredientDescriptionChanged(
      {required this.ingredientDescription, required this.ingredient});

  @override
  List<Object> get props => [ingredientDescription, ingredient];
}

class CookingStateChanged extends RecipeEvent {
  final String cookingState;
  final Ingredient ingredient;

  const CookingStateChanged(
      {required this.cookingState, required this.ingredient});

  @override
  List<Object> get props => [cookingState, ingredient];
}

class MeasurementMethodChanged extends RecipeEvent {
  final String measurementMethod;
  final Ingredient ingredient;

  const MeasurementMethodChanged(
      {required this.measurementMethod, required this.ingredient});

  @override
  List<Object> get props => [measurementMethod, ingredient];
}

class MeasurementChanged extends RecipeEvent {
  final String measurement;
  final Ingredient ingredient;

  const MeasurementChanged(
      {required this.measurement, required this.ingredient});

  @override
  List<Object> get props => [measurement, ingredient];
}

class MeasurementUnitChanged extends RecipeEvent {
  final String measurementUnit;
  final Ingredient ingredient;

  const MeasurementUnitChanged(
      {required this.measurementUnit, required this.ingredient});

  @override
  List<Object> get props => [measurementUnit, ingredient];
}

class SizeChanged extends RecipeEvent {
  final String size;
  final Ingredient ingredient;

  const SizeChanged({required this.size, required this.ingredient});

  @override
  List<Object> get props => [size, ingredient];
}

class SizeNumberChanged extends RecipeEvent {
  final String sizeNumber;
  final Ingredient ingredient;

  const SizeNumberChanged({required this.sizeNumber, required this.ingredient});

  @override
  List<Object> get props => [sizeNumber, ingredient];
}
