import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

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
    on<IngredientAdded>(_onIngredientAdded);
    on<IngredientNameChanged>(_onIngredientNameChanged);
    on<IngredientDescriptionChanged>(_onIngredientDescriptionChanged);
    on<CookingStateChanged>(_onCookingStateChanged);
    on<MeasurementMethodChanged>(_onMeasurementMethodChanged);
    on<MeasurementChanged>(_onMeasurementChanged);
    on<MeasurementUnitChanged>(_onMeasurementUnitChanged);
    on<SizeChanged>(_onSizeChanged);
    on<SizeNumberChanged>(_onSizeNumberChanged);
  }

  void _onRecipeAdded(RecipeAdded event, Emitter<RecipeState> emit) {
    final recipe = Recipe();
    List<Recipe> recipes = List.from(state.recipes);
    recipes.add(recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _recipeNameChanged(RecipeNameChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(recipeName: RecipeName.dirty(event.recipeName));

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _recipeNumberChanged(
      RecipeNumberChanged event, Emitter<RecipeState> emit) {
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

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(recipeVolume: RecipeVolume.dirty(event.recipeVolume));

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onIngredientAdded(IngredientAdded event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    final ingredient = Ingredient();
    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
    ingredients.add(ingredient);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(ingredients: ingredients);

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
        .copyWith(name: Name.dirty(event.ingredientName));

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(ingredients: ingredients);

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

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(description: Description.dirty(event.ingredientDescription));

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(ingredients: ingredients);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onCookingStateChanged(
      CookingStateChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);
    List<Ingredient> ingredients = recipes[changedRecipeIndex].ingredients;
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(cookingState: CookingState.dirty(event.cookingState));

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(ingredients: ingredients);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onMeasurementMethodChanged(
      MeasurementMethodChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);
    List<Ingredient> ingredients = recipes[changedRecipeIndex].ingredients;
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex].copyWith(
        measurementMethod: MeasurementMethod.dirty(event.measurementMethod));

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(ingredients: ingredients);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onMeasurementChanged(
      MeasurementChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);
    List<Ingredient> ingredients = recipes[changedRecipeIndex].ingredients;
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(measurement: Measurement.dirty(event.measurement));

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(ingredients: ingredients);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onMeasurementUnitChanged(
      MeasurementUnitChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);
    List<Ingredient> ingredients = recipes[changedRecipeIndex].ingredients;
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex].copyWith(
        measurementUnit: MeasurementUnit.dirty(event.measurementUnit));

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(ingredients: ingredients);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onSizeChanged(SizeChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);
    List<Ingredient> ingredients = recipes[changedRecipeIndex].ingredients;
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(size: Size.dirty(event.size));

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(ingredients: ingredients);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onSizeNumberChanged(
      SizeNumberChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);
    List<Ingredient> ingredients = recipes[changedRecipeIndex].ingredients;
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(sizeNumber: SizeNumber.dirty(event.sizeNumber));

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(ingredients: ingredients);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }
}
