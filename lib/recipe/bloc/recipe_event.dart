part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

class RecipeAdded extends RecipeEvent {
  final String recipeType;

  const RecipeAdded({required this.recipeType});

  @override
  List<Object> get props => [recipeType];
}

class RecipeDeleted extends RecipeEvent {
  final Recipe recipe;

  const RecipeDeleted({required this.recipe});

  @override
  List<Object> get props => [recipe];
}

class RecipeNameChanged extends RecipeEvent {
  final String recipeName;
  final Recipe recipe;

  const RecipeNameChanged({required this.recipeName, required this.recipe});

  @override
  List<Object> get props => [recipeName, recipe];
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

class ProbeAdded extends RecipeEvent {
  final Recipe recipe;

  const ProbeAdded({required this.recipe});

  @override
  List<Object> get props => [recipe];
}

class ProbeChanged extends RecipeEvent {
  final Recipe recipe;
  final String probeName;
  final int probeIndex;

  const ProbeChanged(
      {required this.recipe,
      required this.probeName,
      required this.probeIndex});

  @override
  List<Object> get props => [recipe, probeName, probeIndex];
}

class ProbeDeleted extends RecipeEvent {
  final Recipe recipe;
  final Map<String, dynamic> probe;

  const ProbeDeleted({required this.recipe, required this.probe});

  @override
  List<Object> get props => [recipe, probe];
}

class IngredientAdded extends RecipeEvent {
  final Recipe recipe;

  const IngredientAdded({required this.recipe});

  @override
  List<Object> get props => [recipe];
}

class IngredientDeleted extends RecipeEvent {
  final Recipe recipe;
  final Ingredient ingredient;

  const IngredientDeleted({required this.recipe, required this.ingredient});

  @override
  List<Object> get props => [recipe, ingredient];
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

class IngredientCookingStateChanged extends RecipeEvent {
  final String cookingState;
  final Ingredient ingredient;
  final Recipe recipe;

  const IngredientCookingStateChanged(
      {required this.cookingState,
      required this.ingredient,
      required this.recipe});

  @override
  List<Object> get props => [cookingState, ingredient, recipe];
}

class IngredientMeasurementMethodChanged extends RecipeEvent {
  final String measurementMethod;
  final Ingredient ingredient;
  final Recipe recipe;

  const IngredientMeasurementMethodChanged(
      {required this.measurementMethod,
      required this.ingredient,
      required this.recipe});

  @override
  List<Object> get props => [measurementMethod, ingredient, recipe];
}

class IngredientMeasurementChanged extends RecipeEvent {
  final String measurement;
  final Ingredient ingredient;
  final Recipe recipe;

  const IngredientMeasurementChanged(
      {required this.measurement,
      required this.ingredient,
      required this.recipe});

  @override
  List<Object> get props => [measurement, ingredient, recipe];
}

class IngredientMeasurementUnitChanged extends RecipeEvent {
  final String measurementUnit;
  final Ingredient ingredient;
  final Recipe recipe;

  const IngredientMeasurementUnitChanged(
      {required this.measurementUnit,
      required this.ingredient,
      required this.recipe});

  @override
  List<Object> get props => [measurementUnit, ingredient, recipe];
}

class IngredientSizeChanged extends RecipeEvent {
  final String size;
  final Ingredient ingredient;
  final Recipe recipe;

  const IngredientSizeChanged(
      {required this.size, required this.ingredient, required this.recipe});

  @override
  List<Object> get props => [size, ingredient, recipe];
}

class IngredientSizeNumberChanged extends RecipeEvent {
  final String sizeNumber;
  final Ingredient ingredient;
  final Recipe recipe;

  const IngredientSizeNumberChanged(
      {required this.sizeNumber,
      required this.ingredient,
      required this.recipe});

  @override
  List<Object> get props => [sizeNumber, ingredient, recipe];
}

// This is for recipes being saved to API, not their status changing to saved
// TODO: Find consistent naming for saving recipes
// TODO:
// class RecipesSaved extends RecipeEvent {
//   const RecipesSaved();

//   @override
//   List<Object> get props => [];
// }
