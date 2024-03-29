part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

class RecipeAdded extends RecipeEvent {
  final String employeeNumber;
  final String type;

  const RecipeAdded({required this.employeeNumber, required this.type});

  @override
  List<Object> get props => [employeeNumber, type];
}

class RecipeDuplicated extends RecipeEvent {
  final Recipe recipe;
  final String employeeNumber;

  const RecipeDuplicated({required this.recipe, required this.employeeNumber});

  @override
  List<Object> get props => [recipe, employeeNumber];
}

class ModifiedRecipeCreated extends RecipeEvent {
  final Recipe recipe;
  final String employeeNumber;

  const ModifiedRecipeCreated(
      {required this.recipe, required this.employeeNumber});

  @override
  List<Object> get props => [recipe, employeeNumber];
}

class RecipeDeleted extends RecipeEvent {
  final Recipe recipe;

  const RecipeDeleted({required this.recipe});

  @override
  List<Object> get props => [recipe];
}

class RecipeNameChanged extends RecipeEvent {
  final String name;
  final Recipe recipe;

  const RecipeNameChanged({required this.name, required this.recipe});

  @override
  List<Object> get props => [name, recipe];
}

class RecipeSurveyIdChanged extends RecipeEvent {
  final String surveyId;
  final Recipe recipe;

  const RecipeSurveyIdChanged({required this.surveyId, required this.recipe});

  @override
  List<Object> get props => [surveyId, recipe];
}

class RecipeMeasurementAdded extends RecipeEvent {
  final Recipe recipe;

  const RecipeMeasurementAdded({required this.recipe});

  @override
  List<Object> get props => [recipe];
}

class RecipeMeasurementDeleted extends RecipeEvent {
  final int measurementIndex;
  final Recipe recipe;

  const RecipeMeasurementDeleted(
      {required this.measurementIndex, required this.recipe});

  @override
  List<Object> get props => [measurementIndex, recipe];
}

/// Changes the measurement method and nulls unit and value.
class RecipeMeasurementMethodChangedOthersNulled extends RecipeEvent {
  final String measurementMethod;
  final int measurementIndex;
  final Recipe recipe;

  const RecipeMeasurementMethodChangedOthersNulled(
      {required this.measurementMethod,
      required this.measurementIndex,
      required this.recipe});

  @override
  List<Object> get props => [measurementMethod, measurementIndex, recipe];
}

class RecipeMeasurementUnitChanged extends RecipeEvent {
  final String measurementUnit;
  final int measurementIndex;
  final Recipe recipe;

  const RecipeMeasurementUnitChanged(
      {required this.measurementUnit,
      required this.measurementIndex,
      required this.recipe});

  @override
  List<Object> get props => [measurementUnit, measurementIndex, recipe];
}

class RecipeMeasurementValueChanged extends RecipeEvent {
  final String measurementValue;
  final int measurementIndex;
  final Recipe recipe;

  const RecipeMeasurementValueChanged(
      {required this.measurementValue,
      required this.measurementIndex,
      required this.recipe});

  @override
  List<Object> get props => [measurementValue, measurementIndex, recipe];
}

class RecipeStatusChanged extends RecipeEvent {
  final bool recipeSaved;
  final Recipe recipe;

  const RecipeStatusChanged({required this.recipeSaved, required this.recipe});

  @override
  List<Object> get props => [recipeSaved, recipe];
}

class RecipeShowMeasurementsChanged extends RecipeEvent {
  final bool showMeasurements;

  const RecipeShowMeasurementsChanged({required this.showMeasurements});

  @override
  List<Object> get props => [showMeasurements];
}

class RecipeShowIngredientsChanged extends RecipeEvent {
  final bool showIngredients;

  const RecipeShowIngredientsChanged({required this.showIngredients});

  @override
  List<Object> get props => [showIngredients];
}

class ProbeAdded extends RecipeEvent {
  final Recipe recipe;

  const ProbeAdded({required this.recipe});

  @override
  List<Object> get props => [recipe];
}

class ProbeDuplicated extends RecipeEvent {
  final Recipe recipe;
  final Probe probe;

  const ProbeDuplicated({required this.recipe, required this.probe});

  @override
  List<Object> get props => [recipe, probe];
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

class ProbeChecked extends RecipeEvent {
  final Recipe recipe;
  final bool probeCheck;
  final int probeIndex;

  const ProbeChecked(
      {required this.recipe,
      required this.probeCheck,
      required this.probeIndex});

  @override
  List<Object> get props => [recipe, probeCheck, probeIndex];
}

class ProbeDeleted extends RecipeEvent {
  final Recipe recipe;
  final Probe probe;

  const ProbeDeleted({required this.recipe, required this.probe});

  @override
  List<Object> get props => [recipe, probe];
}

class ProbeOptionAdded extends RecipeEvent {
  final Recipe recipe;
  final int probeIndex;

  const ProbeOptionAdded({required this.recipe, required this.probeIndex});

  @override
  List<Object> get props => [recipe, probeIndex];
}

class ProbeOptionChanged extends RecipeEvent {
  final Recipe recipe;
  final int probeIndex;
  final int probeOptionIndex;
  final String probeOptionName;

  const ProbeOptionChanged(
      {required this.recipe,
      required this.probeIndex,
      required this.probeOptionIndex,
      required this.probeOptionName});

  @override
  List<Object> get props =>
      [recipe, probeIndex, probeOptionIndex, probeOptionName];
}

class ProbeOptionDeleted extends RecipeEvent {
  final Recipe recipe;
  final int probeIndex;
  final int probeOptionIndex;

  const ProbeOptionDeleted(
      {required this.recipe,
      required this.probeIndex,
      required this.probeOptionIndex});

  @override
  List<Object> get props => [recipe, probeIndex, probeOptionIndex];
}

class ProbeOptionSelected extends RecipeEvent {
  final Recipe recipe;
  final int probeIndex;
  final String answer;

  const ProbeOptionSelected(
      {required this.recipe, required this.probeIndex, required this.answer});

  @override
  List<Object> get props => [recipe, probeIndex, answer];
}

class RecipeProbesCleared extends RecipeEvent {
  final Recipe recipe;

  const RecipeProbesCleared({required this.recipe});

  @override
  List<Object> get props => [recipe];
}

class IngredientAdded extends RecipeEvent {
  final Recipe recipe;

  const IngredientAdded({required this.recipe});

  @override
  List<Object> get props => [recipe];
}

class IngredientDuplicated extends RecipeEvent {
  final Recipe recipe;
  final Ingredient ingredient;

  const IngredientDuplicated({required this.recipe, required this.ingredient});

  @override
  List<Object> get props => [recipe, ingredient];
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

class IngredientFCTFoodItemChanged extends RecipeEvent {
  final FCTFoodItem ingredientFCTFoodItem;
  final Ingredient ingredient;
  final Recipe recipe;

  const IngredientFCTFoodItemChanged(
      {required this.ingredientFCTFoodItem,
      required this.ingredient,
      required this.recipe});

  @override
  List<Object> get props => [ingredientFCTFoodItem, ingredient, recipe];
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

class IngredientCustomCookingStateChanged extends RecipeEvent {
  final String customCookingState;
  final Ingredient ingredient;
  final Recipe recipe;

  const IngredientCustomCookingStateChanged(
      {required this.customCookingState,
      required this.ingredient,
      required this.recipe});

  @override
  List<Object> get props => [customCookingState, ingredient, recipe];
}

class IngredientMeasurementAdded extends RecipeEvent {
  final Recipe recipe;
  final Ingredient ingredient;

  const IngredientMeasurementAdded(
      {required this.recipe, required this.ingredient});

  @override
  List<Object> get props => [recipe, ingredient];
}

class IngredientMeasurementDeleted extends RecipeEvent {
  final int measurementIndex;
  final Ingredient ingredient;
  final Recipe recipe;

  const IngredientMeasurementDeleted(
      {required this.measurementIndex,
      required this.ingredient,
      required this.recipe});

  @override
  List<Object> get props => [measurementIndex, ingredient, recipe];
}

/// Changes the measurement method and nulls unit and value.
class IngredientMeasurementMethodChangedOthersNulled extends RecipeEvent {
  final String measurementMethod;
  final int measurementIndex;
  final Ingredient ingredient;
  final Recipe recipe;

  const IngredientMeasurementMethodChangedOthersNulled(
      {required this.measurementMethod,
      required this.measurementIndex,
      required this.ingredient,
      required this.recipe});

  @override
  List<Object> get props =>
      [measurementMethod, measurementIndex, ingredient, recipe];
}

class IngredientMeasurementUnitChanged extends RecipeEvent {
  final String measurementUnit;
  final int measurementIndex;
  final Ingredient ingredient;
  final Recipe recipe;

  const IngredientMeasurementUnitChanged(
      {required this.measurementUnit,
      required this.measurementIndex,
      required this.ingredient,
      required this.recipe});

  @override
  List<Object> get props =>
      [measurementUnit, measurementIndex, ingredient, recipe];
}

class IngredientMeasurementValueChanged extends RecipeEvent {
  final String measurementValue;
  final int measurementIndex;
  final Ingredient ingredient;
  final Recipe recipe;

  const IngredientMeasurementValueChanged(
      {required this.measurementValue,
      required this.measurementIndex,
      required this.ingredient,
      required this.recipe});

  @override
  List<Object> get props =>
      [measurementValue, measurementIndex, ingredient, recipe];
}

// This is for recipes being saved to API, not their status changing to saved
// TODO: Find consistent naming for saving recipes
class RecipesSaved extends RecipeEvent {
  const RecipesSaved();

  @override
  List<Object> get props => [];
}

class RecipesLoaded extends RecipeEvent {
  const RecipesLoaded();

  @override
  List<Object> get props => [];
}

class RecipesImported extends RecipeEvent {
  const RecipesImported();

  @override
  List<Object> get props => [];
}
