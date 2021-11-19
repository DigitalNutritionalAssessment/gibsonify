import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:gibsonify/recipe/models/models.dart';
import 'package:gibsonify/recipe/recipe.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(const RecipeState()) {
    on<RecipeAdded>(_onRecipeAdded);
    on<RecipeNameChanged>(_recipeNameChanged);
    on<RecipeNumberChanged>(_recipeNumberChanged);
    on<RecipeVolumeChanged>(_recipeVolumeChanged);
    on<RecipeStatusChanged>(_onRecipeStatusChanged);
    on<IngredientAdded>(_onIngredientAdded);
    on<IngredientStatusChanged>(_onIngredientStatusChanged);
    on<IngredientNameChanged>(_onIngredientNameChanged);
    on<IngredientDescriptionChanged>(_onIngredientDescriptionChanged);
    on<IngredientCookingStateChanged>(_onIngredientCookingStateChanged);
    on<IngredientMeasurementMethodChanged>(
        _onIngredientMeasurementMethodChanged);
    on<IngredientMeasurementChanged>(_onIngredientMeasurementChanged);
    on<IngredientMeasurementUnitChanged>(_onIngredientMeasurementUnitChanged);
    on<IngredientSizeChanged>(_onIngredientSizeChanged);
    on<IngredientSizeNumberChanged>(_onIngredientSizeNumberChanged);
  }

  void _onRecipeAdded(RecipeAdded event, Emitter<RecipeState> emit) {
    final newRecipe = Recipe();
    final recipeType = event.recipeType;
    bool standard = event.standard;
    Recipe recipe = newRecipe.copyWith(
        recipeNumber: RecipeNumber.dirty(event.recipeNumber),
        recipeType: recipeType,
        standard: standard);

    List<Recipe> recipes = List.from(state.recipes);
    recipes.add(recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _recipeNameChanged(RecipeNameChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(recipeName: RecipeName.dirty(event.recipeName), saved: false);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _recipeNumberChanged(
      // TODO: Remove?
      RecipeNumberChanged event,
      Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(recipeNumber: RecipeNumber.dirty(event.recipeNumber));

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _recipeVolumeChanged(
      RecipeVolumeChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);

    Recipe recipe = recipes[changedRecipeIndex].copyWith(
        recipeVolume: RecipeVolume.dirty(event.recipeVolume), saved: false);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onRecipeStatusChanged(
      RecipeStatusChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(saved: event.recipeSaved, standard: false);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onIngredientAdded(IngredientAdded event, Emitter<RecipeState> emit) {
    // if standard is false:
    // make a copy of the current recipe and add it to the list
    // then continue to edit this current recipe, getting a new recipe number
    // and making recipeType = Modified Recipe

    List<Recipe> recipes = List.from(state.recipes);
    Recipe standardRecipe = event.recipe;
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    final ingredient = Ingredient();
    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
    ingredients.add(ingredient);

    Recipe recipe = (event.recipe.standard == false &&
            event.recipe.recipeType == "Standard Recipe")
        ? recipes[changedRecipeIndex].copyWith(
            ingredients: ingredients,
            saved: false,
            recipeType: "Modified Recipe",
            recipeNumber: RecipeNumber.dirty((state.recipes.length + 1)
                .toString())) // TODO: Handle recipeNumber better
        : recipes[changedRecipeIndex]
            .copyWith(ingredients: ingredients, saved: false);

    recipes.removeAt(changedRecipeIndex);

    if (event.recipe.standard == false &&
        event.recipe.recipeType == "Standard Recipe") {
      recipes.insert(changedRecipeIndex, standardRecipe);
    }
    recipes.insert(changedRecipeIndex, recipe);
    emit(state.copyWith(recipes: recipes));
  }

  void _onIngredientStatusChanged(
      IngredientStatusChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);
    List<Ingredient> ingredients = recipes[changedRecipeIndex].ingredients;
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(saved: event.ingredientSaved);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(ingredients: ingredients, saved: false);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onIngredientNameChanged(
      IngredientNameChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);
    List<Ingredient> ingredients = recipes[changedRecipeIndex].ingredients;
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(name: Name.dirty(event.ingredientName), saved: false);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(ingredients: ingredients, saved: false);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onIngredientDescriptionChanged(
      IngredientDescriptionChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);
    List<Ingredient> ingredients = recipes[changedRecipeIndex].ingredients;
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex].copyWith(
        description: Description.dirty(event.ingredientDescription),
        saved: false);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(ingredients: ingredients, saved: false);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onIngredientCookingStateChanged(
      IngredientCookingStateChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);
    List<Ingredient> ingredients = recipes[changedRecipeIndex].ingredients;
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex].copyWith(
        cookingState: CookingState.dirty(event.cookingState), saved: false);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(ingredients: ingredients, saved: false);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onIngredientMeasurementMethodChanged(
      IngredientMeasurementMethodChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);
    List<Ingredient> ingredients = recipes[changedRecipeIndex].ingredients;
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex].copyWith(
        measurementMethod: MeasurementMethod.dirty(event.measurementMethod),
        saved: false);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(ingredients: ingredients, saved: false);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onIngredientMeasurementChanged(
      IngredientMeasurementChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);
    List<Ingredient> ingredients = recipes[changedRecipeIndex].ingredients;
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex].copyWith(
        measurement: Measurement.dirty(event.measurement), saved: false);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(ingredients: ingredients, saved: false);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onIngredientMeasurementUnitChanged(
      IngredientMeasurementUnitChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);
    List<Ingredient> ingredients = recipes[changedRecipeIndex].ingredients;
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex].copyWith(
        measurementUnit: MeasurementUnit.dirty(event.measurementUnit),
        saved: false);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(ingredients: ingredients, saved: false);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onIngredientSizeChanged(
      IngredientSizeChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);
    List<Ingredient> ingredients = recipes[changedRecipeIndex].ingredients;
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(size: Size.dirty(event.size), saved: false);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(ingredients: ingredients, saved: false);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onIngredientSizeNumberChanged(
      IngredientSizeNumberChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);
    List<Ingredient> ingredients = recipes[changedRecipeIndex].ingredients;
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(sizeNumber: SizeNumber.dirty(event.sizeNumber), saved: false);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(ingredients: ingredients, saved: false);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }
}
