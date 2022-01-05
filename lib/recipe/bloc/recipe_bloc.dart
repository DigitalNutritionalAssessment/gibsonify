import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final GibsonifyRepository _gibsonifyRepository;

  RecipeBloc({required GibsonifyRepository gibsonifyRepository})
      : _gibsonifyRepository = gibsonifyRepository,
        super(const RecipeState()) {
    on<RecipeAdded>(_onRecipeAdded);
    on<RecipeDeleted>(_onRecipeDeleted);
    on<RecipeNameChanged>(_recipeNameChanged);
    on<RecipeVolumeChanged>(_recipeVolumeChanged);
    on<RecipeStatusChanged>(_onRecipeStatusChanged);
    on<ProbeAdded>(_onProbeAdded);
    on<ProbeChanged>(_onProbeChanged);
    on<ProbeDeleted>(_onProbeDeleted);
    on<IngredientAdded>(_onIngredientAdded);
    on<IngredientDeleted>(_onIngredientDeleted);
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
    // on<RecipesSaved>(_onRecipesSaved); // TODO:
  }

  void _onRecipeAdded(RecipeAdded event, Emitter<RecipeState> emit) {
    final recipe = Recipe(recipeType: event.recipeType);

    List<Recipe> recipes = List.from(state.recipes);
    recipes.add(recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onRecipeDeleted(RecipeDeleted event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);

    recipes.removeAt(changedRecipeIndex);

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

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(saved: event.recipeSaved);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onProbeAdded(ProbeAdded event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    Map<String, dynamic> probe = {'probe': '', 'key': const Uuid().v4()};
    List<Map<String, dynamic>> probes =
        List.from(recipes[changedRecipeIndex].probes);
    probes.add(probe);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(probes: probes, saved: false);

    recipes.removeAt(changedRecipeIndex);

    recipes.insert(changedRecipeIndex, recipe);
    emit(state.copyWith(recipes: recipes));
  }

  void _onProbeChanged(ProbeChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Map<String, dynamic>> probes =
        List.from(recipes[changedRecipeIndex].probes);
    int changedProbeIndex = event.probeIndex;

    String probeName = event.probeName;
    Map<String, dynamic> probe = {
      'probe': probeName,
      'key': probes[changedProbeIndex]['key']
    };

    probes.removeAt(changedProbeIndex);
    probes.insert(changedProbeIndex, probe);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(probes: probes, saved: false);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onProbeDeleted(ProbeDeleted event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Map<String, dynamic>> probes =
        List.from(recipes[changedRecipeIndex].probes);
    int changedProbeIndex = probes.indexOf(event.probe);
    probes.removeAt(changedProbeIndex);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(probes: probes, saved: false);

    recipes.removeAt(changedRecipeIndex);

    recipes.insert(changedRecipeIndex, recipe);
    emit(state.copyWith(recipes: recipes));
  }

  void _onIngredientAdded(IngredientAdded event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    Recipe standardRecipe = event.recipe;
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    final ingredient = Ingredient();
    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
    ingredients.add(ingredient);

    Recipe recipe = (event.recipe.saved == true &&
            event.recipe.recipeType == "Standard Recipe")
        ? recipes[changedRecipeIndex].copyWith(
            ingredients: ingredients,
            saved: false,
            recipeType: "Modified Recipe",
            recipeNumber: const Uuid().v4())
        : recipes[changedRecipeIndex]
            .copyWith(ingredients: ingredients, saved: false);

    recipes.removeAt(changedRecipeIndex);

    if (event.recipe.saved == true &&
        event.recipe.recipeType == "Standard Recipe") {
      recipes.insert(changedRecipeIndex, standardRecipe);
    }
    recipes.insert(changedRecipeIndex, recipe);
    emit(state.copyWith(recipes: recipes));
  }

  void _onIngredientDeleted(
      IngredientDeleted event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    Recipe standardRecipe = event.recipe;
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);
    ingredients.removeAt(changedIngredientIndex);

    Recipe recipe = (event.recipe.saved == true &&
            event.recipe.recipeType == "Standard Recipe")
        ? recipes[changedRecipeIndex].copyWith(
            ingredients: ingredients,
            saved: false,
            recipeType: "Modified Recipe",
            recipeNumber: const Uuid().v4())
        : recipes[changedRecipeIndex]
            .copyWith(ingredients: ingredients, saved: false);

    recipes.removeAt(changedRecipeIndex);

    if (event.recipe.saved == true &&
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
    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
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
    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
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
    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
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
    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
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
    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
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
    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
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
    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
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
    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
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
    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
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

  // TODO:
  // void _onRecipesSaved(RecipesSaved event, Emitter<RecipeState> emit) {
  //   List<Recipe> recipes = List.from(state.recipes);
  // }
}
