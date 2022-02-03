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
    on<ProbeChecked>(_onProbeChecked);
    on<ProbeDeleted>(_onProbeDeleted);
    on<ProbeOptionAdded>(_onProbeOptionAdded);
    on<ProbeOptionChanged>(_onProbeOptionChanged);
    on<ProbeOptionDeleted>(_onProbeOptionDeleted);
    on<ProbeOptionSelected>(_onProbeOptionSelected);
    on<ProbeCleared>(_onProbeCleared);
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
    on<RecipesSaved>(_onRecipesSaved);
    on<RecipesLoaded>(_onRecipesLoaded);
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

    final probe = Probe();

    List<Probe> probes = List.from(recipes[changedRecipeIndex].probes);
    probes.add(probe);

    bool probesChecked = true;

    for (Probe probe in probes) {
      if (probe.checked == false) {
        probesChecked = false;
        break;
      }
    }

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(probes: probes, probesChecked: probesChecked);

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

    bool probesChecked = true;

    for (Probe probe in probes) {
      if (probe.checked == false) {
        probesChecked = false;
        break;
      }
    }

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(probes: probes, probesChecked: probesChecked);

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

    bool probesChecked = probes.isEmpty ? false : true;

    for (Probe probe in probes) {
      if (probe.checked == false) {
        probesChecked = false;
        break;
      }
    }

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(probes: probes, probesChecked: probesChecked);

    recipes.removeAt(changedRecipeIndex);

    recipes.insert(changedRecipeIndex, recipe);
    emit(state.copyWith(recipes: recipes));
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

    bool probesStandard = true;
    for (Probe probe in probes) {
      if (probe.standardAnswer() == false) {
        probesStandard = false;
        break;
      }
    }

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(probes: probes, probesStandard: probesStandard);

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

    bool probesStandard = true;
    for (Probe probe in probes) {
      if (probe.standardAnswer() == false) {
        probesStandard = false;
        break;
      }
    }

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(probes: probes, probesStandard: probesStandard);

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

    bool probesStandard = true;
    for (Probe probe in probes) {
      if (probe.standardAnswer() == false) {
        probesStandard = false;
        break;
      }
    }

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(probes: probes, probesStandard: probesStandard);

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onProbeCleared(ProbeCleared event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Probe> probes = List.from(recipes[changedRecipeIndex].probes);
    List<Probe> clearedProbes = [];

    for (Probe probe in probes) {
      clearedProbes.add(probe.copyWith(checked: false, answer: ''));
    }

    Recipe recipe = recipes[changedRecipeIndex].copyWith(
        probes: clearedProbes, probesChecked: false, probesStandard: true);

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
}
