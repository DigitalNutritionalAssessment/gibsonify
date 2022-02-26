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
    on<RecipeMeasurementAdded>(_onRecipeMeasurementAdded);
    on<RecipeMeasurementDeleted>(_onRecipeMeasurementDeleted);
    on<RecipeMeasurementMethodChanged>(_onRecipeMeasurementMethodChanged);
    on<RecipeMeasurementUnitChanged>(_onRecipeMeasurementUnitChanged);
    on<RecipeMeasurementValueChanged>(_onRecipeMeasurementValueChanged);
    on<RecipeStatusChanged>(_onRecipeStatusChanged);
    on<ProbeAdded>(_onProbeAdded);
    on<ProbeChanged>(_onProbeChanged);
    on<ProbeChecked>(_onProbeChecked);
    on<ProbeDeleted>(_onProbeDeleted);
    on<ProbeOptionAdded>(_onProbeOptionAdded);
    on<ProbeOptionChanged>(_onProbeOptionChanged);
    on<ProbeOptionDeleted>(_onProbeOptionDeleted);
    on<ProbeOptionSelected>(_onProbeOptionSelected);
    on<RecipeProbesCleared>(_onRecipeProbesCleared);
    on<IngredientAdded>(_onIngredientAdded);
    on<IngredientDeleted>(_onIngredientDeleted);
    on<IngredientStatusChanged>(_onIngredientStatusChanged);
    on<IngredientNameChanged>(_onIngredientNameChanged);
    on<IngredientCustomNameChanged>(_onIngredientCustomNameChanged);
    on<IngredientDescriptionChanged>(_onIngredientDescriptionChanged);
    on<IngredientCookingStateChanged>(_onIngredientCookingStateChanged);
    on<IngredientMeasurementAdded>(_onIngredientMeasurementAdded);
    on<IngredientMeasurementDeleted>(_onIngredientMeasurementDeleted);
    on<IngredientMeasurementMethodChanged>(
        _onIngredientMeasurementMethodChanged);
    on<IngredientMeasurementUnitChanged>(_onIngredientMeasurementUnitChanged);
    on<IngredientMeasurementValueChanged>(_onIngredientMeasurementValueChanged);
    on<RecipesSaved>(_onRecipesSaved);
    on<RecipesLoaded>(_onRecipesLoaded);
    on<IngredientsLoaded>(_onIngredientsLoaded);
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
        .copyWith(recipeName: event.recipeName, saved: false);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onRecipeMeasurementAdded(
      RecipeMeasurementAdded event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Measurement> measurements =
        List.from(recipes[changedRecipeIndex].measurements);

    final measurement = Measurement();
    measurements.add(measurement);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(measurements: measurements);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onRecipeMeasurementDeleted(
      RecipeMeasurementDeleted event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Measurement> measurements =
        List.from(recipes[changedRecipeIndex].measurements);
    int changedmeasurementIndex = event.measurementIndex;

    measurements.removeAt(changedmeasurementIndex);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(measurements: measurements);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onRecipeMeasurementMethodChanged(
      RecipeMeasurementMethodChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Measurement> measurements =
        List.from(recipes[changedRecipeIndex].measurements);
    int changedmeasurementIndex = event.measurementIndex;

    Measurement measurement = measurements[changedmeasurementIndex]
        .copyWith(measurementMethod: event.measurementMethod);

    measurements.removeAt(changedmeasurementIndex);
    measurements.insert(changedmeasurementIndex, measurement);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(measurements: measurements);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onRecipeMeasurementUnitChanged(
      RecipeMeasurementUnitChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Measurement> measurements =
        List.from(recipes[changedRecipeIndex].measurements);
    int changedmeasurementIndex = event.measurementIndex;

    Measurement measurement = measurements[changedmeasurementIndex]
        .copyWith(measurementUnit: event.measurementUnit);

    measurements.removeAt(changedmeasurementIndex);
    measurements.insert(changedmeasurementIndex, measurement);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(measurements: measurements);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onRecipeMeasurementValueChanged(
      RecipeMeasurementValueChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Measurement> measurements =
        List.from(recipes[changedRecipeIndex].measurements);
    int changedmeasurementIndex = event.measurementIndex;

    Measurement measurement = measurements[changedmeasurementIndex]
        .copyWith(measurementValue: event.measurementValue);

    measurements.removeAt(changedmeasurementIndex);
    measurements.insert(changedmeasurementIndex, measurement);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(measurements: measurements);

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

  bool _areAllProbesChecked(List<Probe> probes) {
    bool allProbesChecked = true;
    for (Probe probe in probes) {
      if (probe.checked == false) {
        allProbesChecked = false;
        break;
      }
    }
    return allProbesChecked;
  }

  void _onProbeAdded(ProbeAdded event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    final probe = Probe();

    List<Probe> probes = List.from(recipes[changedRecipeIndex].probes);
    probes.add(probe);

    bool allProbesChecked = _areAllProbesChecked(probes);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(probes: probes, allProbesChecked: allProbesChecked);

    recipes.removeAt(changedRecipeIndex);

    recipes.insert(changedRecipeIndex, recipe);
    emit(state.copyWith(recipes: recipes));
  }

  void _onProbeChanged(ProbeChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Probe> probes = List.from(recipes[changedRecipeIndex].probes);
    int changedProbeIndex = event.probeIndex;

    Probe probe =
        probes[changedProbeIndex].copyWith(probeName: event.probeName);

    probes.removeAt(changedProbeIndex);
    probes.insert(changedProbeIndex, probe);

    Recipe recipe = recipes[changedRecipeIndex].copyWith(probes: probes);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onProbeChecked(ProbeChecked event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Probe> probes = List.from(recipes[changedRecipeIndex].probes);
    int changedProbeIndex = event.probeIndex;

    Probe probe = probes[changedProbeIndex].copyWith(checked: event.probeCheck);

    probes.removeAt(changedProbeIndex);
    probes.insert(changedProbeIndex, probe);

    bool allProbesChecked = _areAllProbesChecked(probes);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(probes: probes, allProbesChecked: allProbesChecked);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onProbeDeleted(ProbeDeleted event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Probe> probes = List.from(recipes[changedRecipeIndex].probes);
    int changedProbeIndex = probes.indexOf(event.probe);
    probes.removeAt(changedProbeIndex);

    bool allProbesChecked = _areAllProbesChecked(probes);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(probes: probes, allProbesChecked: allProbesChecked);

    recipes.removeAt(changedRecipeIndex);

    recipes.insert(changedRecipeIndex, recipe);
    emit(state.copyWith(recipes: recipes));
  }

  bool _areAllProbeAnswersStandard(List<Probe> probes) {
    bool allProbeAnswersStandard = true;
    for (Probe probe in probes) {
      if (probe.standardAnswer() == false) {
        allProbeAnswersStandard = false;
        break;
      }
    }
    return allProbeAnswersStandard;
  }

  void _onProbeOptionAdded(ProbeOptionAdded event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Probe> probes = List.from(recipes[changedRecipeIndex].probes);
    int changedProbeIndex = event.probeIndex;
    List<Map<String, dynamic>> probeOptions =
        List.from(probes[changedProbeIndex].probeOptions);

    probeOptions.add({'option': null, 'id': const Uuid().v4()});
    Probe probe =
        probes[changedProbeIndex].copyWith(probeOptions: probeOptions);

    probes.removeAt(changedProbeIndex);
    probes.insert(changedProbeIndex, probe);

    bool allProbeAnswersStandard = _areAllProbeAnswersStandard(probes);

    Recipe recipe = recipes[changedRecipeIndex].copyWith(
        probes: probes, allProbeAnswersStandard: allProbeAnswersStandard);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onProbeOptionChanged(
      ProbeOptionChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Probe> probes = List.from(recipes[changedRecipeIndex].probes);
    int changedProbeIndex = event.probeIndex;
    List<Map<String, dynamic>> probeOptions =
        List.from(probes[changedProbeIndex].probeOptions);
    int changedProbeOptionIndex = event.probeOptionIndex;

    String probeOptionName = event.probeOptionName;
    Map<String, String?> probeOption = {
      'option': probeOptionName,
      'id': probeOptions[changedProbeOptionIndex]['id']
    };
    probeOptions.removeAt(changedProbeOptionIndex);
    probeOptions.insert(changedProbeOptionIndex, probeOption);

    Probe probe =
        probes[changedProbeIndex].copyWith(probeOptions: probeOptions);

    probes.removeAt(changedProbeIndex);
    probes.insert(changedProbeIndex, probe);

    Recipe recipe = recipes[changedRecipeIndex].copyWith(probes: probes);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onProbeOptionDeleted(
      ProbeOptionDeleted event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Probe> probes = List.from(recipes[changedRecipeIndex].probes);
    int changedProbeIndex = event.probeIndex;
    List<Map<String, dynamic>> probeOptions =
        List.from(probes[changedProbeIndex].probeOptions);

    probeOptions.removeAt(event.probeOptionIndex);

    Probe probe =
        probes[changedProbeIndex].copyWith(probeOptions: probeOptions);

    probes.removeAt(changedProbeIndex);
    probes.insert(changedProbeIndex, probe);

    bool allProbeAnswersStandard = _areAllProbeAnswersStandard(probes);

    Recipe recipe = recipes[changedRecipeIndex].copyWith(
        probes: probes, allProbeAnswersStandard: allProbeAnswersStandard);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onProbeOptionSelected(
      ProbeOptionSelected event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Probe> probes = List.from(recipes[changedRecipeIndex].probes);
    int changedProbeIndex = event.probeIndex;

    Probe probe = probes[changedProbeIndex].copyWith(answer: event.answer);

    probes.removeAt(changedProbeIndex);
    probes.insert(changedProbeIndex, probe);

    bool allProbeAnswersStandard = _areAllProbeAnswersStandard(probes);

    Recipe recipe = recipes[changedRecipeIndex].copyWith(
        probes: probes, allProbeAnswersStandard: allProbeAnswersStandard);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onRecipeProbesCleared(
      RecipeProbesCleared event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Probe> probes = List.from(recipes[changedRecipeIndex].probes);
    List<Probe> clearedProbes = [];

    for (Probe probe in probes) {
      clearedProbes.add(probe.copyWith(checked: false, answer: ''));
    }

    Recipe recipe = recipes[changedRecipeIndex].copyWith(
        probes: clearedProbes,
        allProbesChecked: false,
        allProbeAnswersStandard: true);

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
        .copyWith(name: event.ingredientName, saved: false);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(ingredients: ingredients, saved: false);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onIngredientCustomNameChanged(
      IngredientCustomNameChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);
    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(customName: event.ingredientCustomName, saved: false);

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

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(description: event.ingredientDescription, saved: false);

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

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(cookingState: event.cookingState, saved: false);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(ingredients: ingredients, saved: false);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onIngredientMeasurementAdded(
      IngredientMeasurementAdded event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    List<Measurement> measurements = List.from(recipes[changedRecipeIndex]
        .ingredients[changedIngredientIndex]
        .measurements);

    final measurement = Measurement();
    measurements.add(measurement);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(measurements: measurements);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(ingredients: ingredients);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onIngredientMeasurementDeleted(
      IngredientMeasurementDeleted event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    List<Measurement> measurements = List.from(recipes[changedRecipeIndex]
        .ingredients[changedIngredientIndex]
        .measurements);
    int changedmeasurementIndex = event.measurementIndex;

    measurements.removeAt(changedmeasurementIndex);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(measurements: measurements);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(ingredients: ingredients);

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

    List<Measurement> measurements = List.from(recipes[changedRecipeIndex]
        .ingredients[changedIngredientIndex]
        .measurements);
    int changedmeasurementIndex = event.measurementIndex;

    Measurement measurement = measurements[changedmeasurementIndex]
        .copyWith(measurementMethod: event.measurementMethod);

    measurements.removeAt(changedmeasurementIndex);
    measurements.insert(changedmeasurementIndex, measurement);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(measurements: measurements);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(ingredients: ingredients);

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

    List<Measurement> measurements = List.from(recipes[changedRecipeIndex]
        .ingredients[changedIngredientIndex]
        .measurements);
    int changedmeasurementIndex = event.measurementIndex;

    Measurement measurement = measurements[changedmeasurementIndex]
        .copyWith(measurementUnit: event.measurementUnit);

    measurements.removeAt(changedmeasurementIndex);
    measurements.insert(changedmeasurementIndex, measurement);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(measurements: measurements);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(ingredients: ingredients);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onIngredientMeasurementValueChanged(
      IngredientMeasurementValueChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    List<Measurement> measurements = List.from(recipes[changedRecipeIndex]
        .ingredients[changedIngredientIndex]
        .measurements);
    int changedmeasurementIndex = event.measurementIndex;

    Measurement measurement = measurements[changedmeasurementIndex]
        .copyWith(measurementValue: event.measurementValue);

    measurements.removeAt(changedmeasurementIndex);
    measurements.insert(changedmeasurementIndex, measurement);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(measurements: measurements);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe =
        recipes[changedRecipeIndex].copyWith(ingredients: ingredients);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  // TODO: investigate not using async and await here
  // but on the other hand, maybe communication with repository/api should be
  // asynchronous to preserve generality for the future
  void _onRecipesSaved(RecipesSaved event, Emitter<RecipeState> emit) async {
    List<Recipe> recipes = List.from(state.recipes);
    await _gibsonifyRepository.saveRecipes(recipes);
    emit(state);
  }

  void _onRecipesLoaded(RecipesLoaded event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = _gibsonifyRepository.loadRecipes();
    emit(state.copyWith(recipes: recipes));
  }

  Future<void> _onIngredientsLoaded(
      IngredientsLoaded event, Emitter<RecipeState> emit) async {
    if (state.ingredientsJson == null) {
      try {
        String ingredientsJson = await Ingredient.getIngredients();
        emit(state.copyWith(ingredientsJson: ingredientsJson));
      } catch (e) {
        return;
      }
    }
  }
}
