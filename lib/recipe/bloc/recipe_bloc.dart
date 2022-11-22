import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:csv/csv_settings_autodetection.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';

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
    on<RecipeDuplicated>(_onRecipeDuplicated);
    on<ModifiedRecipeCreated>(_onModifiedRecipeCreated);
    on<RecipeDeleted>(_onRecipeDeleted);
    on<RecipeNameChanged>(_recipeNameChanged);
    on<RecipeMeasurementAdded>(_onRecipeMeasurementAdded);
    on<RecipeMeasurementDeleted>(_onRecipeMeasurementDeleted);
    on<RecipeMeasurementMethodChangedOthersNulled>(
        _onRecipeMeasurementMethodChangedOthersNulled);
    on<RecipeMeasurementUnitChanged>(_onRecipeMeasurementUnitChanged);
    on<RecipeMeasurementValueChanged>(_onRecipeMeasurementValueChanged);
    on<RecipeStatusChanged>(_onRecipeStatusChanged);
    on<RecipeShowMeasurementsChanged>(_onRecipeShowMeasurementsChanged);
    on<RecipeShowIngredientsChanged>(_onRecipeShowIngredientsChanged);
    on<ProbeAdded>(_onProbeAdded);
    on<ProbeDuplicated>(_onProbeDuplicated);
    on<ProbeChanged>(_onProbeChanged);
    on<ProbeChecked>(_onProbeChecked);
    on<ProbeDeleted>(_onProbeDeleted);
    on<ProbeOptionAdded>(_onProbeOptionAdded);
    on<ProbeOptionChanged>(_onProbeOptionChanged);
    on<ProbeOptionDeleted>(_onProbeOptionDeleted);
    on<ProbeOptionSelected>(_onProbeOptionSelected);
    on<RecipeProbesCleared>(_onRecipeProbesCleared);
    on<IngredientAdded>(_onIngredientAdded);
    on<IngredientDuplicated>(_onIngredientDuplicated);
    on<IngredientDeleted>(_onIngredientDeleted);
    on<IngredientStatusChanged>(_onIngredientStatusChanged);
    on<IngredientNameChanged>(_onIngredientNameChanged);
    on<IngredientCustomNameChanged>(_onIngredientCustomNameChanged);
    on<IngredientDescriptionChanged>(_onIngredientDescriptionChanged);
    on<IngredientCookingStateChanged>(_onIngredientCookingStateChanged);
    on<IngredientCustomCookingStateChanged>(
        _onIngredientCustomCookingStateChanged);
    on<IngredientMeasurementAdded>(_onIngredientMeasurementAdded);
    on<IngredientMeasurementDeleted>(_onIngredientMeasurementDeleted);
    on<IngredientMeasurementMethodChangedOthersNulled>(
        _onIngredientMeasurementMethodChangedOthersNulled);
    on<IngredientMeasurementUnitChanged>(_onIngredientMeasurementUnitChanged);
    on<IngredientMeasurementValueChanged>(_onIngredientMeasurementValueChanged);
    on<RecipesSaved>(_onRecipesSaved);
    on<RecipesLoaded>(_onRecipesLoaded);
    on<IngredientsLoaded>(_onIngredientsLoaded);
    on<RecipesImported>(_onRecipesImported);
  }

  String _getCurrentDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  void _onRecipeAdded(RecipeAdded event, Emitter<RecipeState> emit) {
    final recipe =
        Recipe(employeeNumber: event.employeeNumber, type: event.type);

    List<Recipe> recipes = List.from(state.recipes);
    recipes.add(recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onRecipeDuplicated(RecipeDuplicated event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);

    Recipe duplicatedRecipe = recipes[changedRecipeIndex].copyWith(
        employeeNumber: event.employeeNumber,
        number: const Uuid().v4(),
        saved: false,
        date: _getCurrentDate());

    recipes.insert(changedRecipeIndex + 1, duplicatedRecipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onModifiedRecipeCreated(
      ModifiedRecipeCreated event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);

    Recipe modifiedRecipe = recipes[changedRecipeIndex].copyWith(
        employeeNumber: event.employeeNumber,
        type: "Modified Recipe",
        number: const Uuid().v4(),
        saved: false,
        date: _getCurrentDate());

    recipes.insert(changedRecipeIndex + 1, modifiedRecipe);

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
        .copyWith(name: event.name, date: _getCurrentDate(), saved: false);

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

    final measurement = Measurement(id: const Uuid().v4());
    measurements.add(measurement);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(measurements: measurements, date: _getCurrentDate());

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

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(measurements: measurements, date: _getCurrentDate());

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onRecipeMeasurementMethodChangedOthersNulled(
      RecipeMeasurementMethodChangedOthersNulled event,
      Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Measurement> measurements =
        List.from(recipes[changedRecipeIndex].measurements);
    int changedmeasurementIndex = event.measurementIndex;

    // since copyWith does not allow to null attributes, create new instance and
    // copy the original id and changed method (thus nulling value and unit)
    Measurement measurement = Measurement();

    measurement = measurement.copyWith(
        id: measurements[changedmeasurementIndex].id,
        measurementMethod: event.measurementMethod);

    measurements.removeAt(changedmeasurementIndex);
    measurements.insert(changedmeasurementIndex, measurement);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(measurements: measurements, date: _getCurrentDate());

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

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(measurements: measurements, date: _getCurrentDate());

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

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(measurements: measurements, date: _getCurrentDate());

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onRecipeStatusChanged(
      RecipeStatusChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(saved: event.recipeSaved, date: _getCurrentDate());

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onRecipeShowMeasurementsChanged(
      RecipeShowMeasurementsChanged event, Emitter<RecipeState> emit) {
    emit(state.copyWith(showMeasurements: event.showMeasurements));
  }

  void _onRecipeShowIngredientsChanged(
      RecipeShowIngredientsChanged event, Emitter<RecipeState> emit) {
    emit(state.copyWith(showIngredients: event.showIngredients));
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

    Recipe recipe = recipes[changedRecipeIndex].copyWith(
        probes: probes,
        allProbesChecked: allProbesChecked,
        date: _getCurrentDate());

    recipes.removeAt(changedRecipeIndex);

    recipes.insert(changedRecipeIndex, recipe);
    emit(state.copyWith(recipes: recipes));
  }

  void _onProbeDuplicated(ProbeDuplicated event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Probe> probes = List.from(recipes[changedRecipeIndex].probes);
    int changedProbeIndex = probes.indexOf(event.probe);

    Probe probe = probes[changedProbeIndex].copyWith(id: const Uuid().v4());

    probes.insert(changedProbeIndex + 1, probe);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(probes: probes, date: _getCurrentDate());

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onProbeChanged(ProbeChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Probe> probes = List.from(recipes[changedRecipeIndex].probes);
    int changedProbeIndex = event.probeIndex;

    Probe probe = probes[changedProbeIndex].copyWith(name: event.probeName);

    probes.removeAt(changedProbeIndex);
    probes.insert(changedProbeIndex, probe);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(probes: probes, date: _getCurrentDate());

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

    Recipe recipe = recipes[changedRecipeIndex].copyWith(
        probes: probes,
        allProbesChecked: allProbesChecked,
        date: _getCurrentDate());

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

    Recipe recipe = recipes[changedRecipeIndex].copyWith(
        probes: probes,
        allProbesChecked: allProbesChecked,
        date: _getCurrentDate());

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
    List<ProbeOption> probeOptions =
        List.from(probes[changedProbeIndex].probeOptions);

    probeOptions.add(ProbeOption(option: null, id: const Uuid().v4()));
    Probe probe =
        probes[changedProbeIndex].copyWith(probeOptions: probeOptions);

    probes.removeAt(changedProbeIndex);
    probes.insert(changedProbeIndex, probe);

    bool allProbeAnswersStandard = _areAllProbeAnswersStandard(probes);

    Recipe recipe = recipes[changedRecipeIndex].copyWith(
        probes: probes,
        allProbeAnswersStandard: allProbeAnswersStandard,
        date: _getCurrentDate());

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
    List<ProbeOption> probeOptions =
        List.from(probes[changedProbeIndex].probeOptions);
    int changedProbeOptionIndex = event.probeOptionIndex;

    String probeOptionName = event.probeOptionName;
    ProbeOption probeOption = ProbeOption(
        option: probeOptionName, id: probeOptions[changedProbeOptionIndex].id);
    probeOptions.removeAt(changedProbeOptionIndex);
    probeOptions.insert(changedProbeOptionIndex, probeOption);

    Probe probe =
        probes[changedProbeIndex].copyWith(probeOptions: probeOptions);

    probes.removeAt(changedProbeIndex);
    probes.insert(changedProbeIndex, probe);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(probes: probes, date: _getCurrentDate());

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
    List<ProbeOption> probeOptions =
        List.from(probes[changedProbeIndex].probeOptions);

    probeOptions.removeAt(event.probeOptionIndex);

    Probe probe =
        probes[changedProbeIndex].copyWith(probeOptions: probeOptions);

    probes.removeAt(changedProbeIndex);
    probes.insert(changedProbeIndex, probe);

    bool allProbeAnswersStandard = _areAllProbeAnswersStandard(probes);

    Recipe recipe = recipes[changedRecipeIndex].copyWith(
        probes: probes,
        allProbeAnswersStandard: allProbeAnswersStandard,
        date: _getCurrentDate());

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
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    final ingredient = Ingredient(id: const Uuid().v4());
    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
    ingredients.add(ingredient);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(ingredients: ingredients, date: _getCurrentDate());

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onIngredientDuplicated(
      IngredientDuplicated event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);
    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(id: const Uuid().v4(), saved: false);

    ingredients.insert(changedIngredientIndex + 1, ingredient);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(ingredients: ingredients, date: _getCurrentDate());

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onIngredientDeleted(
      IngredientDeleted event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);
    ingredients.removeAt(changedIngredientIndex);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(ingredients: ingredients, date: _getCurrentDate());

    recipes.removeAt(changedRecipeIndex);
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
        .copyWith(ingredients: ingredients, date: _getCurrentDate());

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

    String ingredientName = event.ingredientName;
    Map<String, dynamic> ingredientMap = json.decode(state.ingredientsJson!);

    Ingredient ingredient = ingredients[changedIngredientIndex].copyWith(
        name: ingredientName,
        foodComposition: ingredientMap[ingredientName],
        saved: false);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(ingredients: ingredients, date: _getCurrentDate());

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
        .copyWith(ingredients: ingredients, date: _getCurrentDate());

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
        .copyWith(ingredients: ingredients, date: _getCurrentDate());

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
        .copyWith(ingredients: ingredients, date: _getCurrentDate());

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onIngredientCustomCookingStateChanged(
      IngredientCustomCookingStateChanged event, Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);

    int changedRecipeIndex = recipes.indexOf(event.recipe);
    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(customCookingState: event.customCookingState, saved: false);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(ingredients: ingredients, date: _getCurrentDate());

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

    final measurement = Measurement(id: const Uuid().v4());
    measurements.add(measurement);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(measurements: measurements, saved: false);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(ingredients: ingredients, date: _getCurrentDate());

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
        .copyWith(measurements: measurements, saved: false);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(ingredients: ingredients, date: _getCurrentDate());

    recipes.removeAt(changedRecipeIndex);
    recipes.insert(changedRecipeIndex, recipe);

    emit(state.copyWith(recipes: recipes));
  }

  void _onIngredientMeasurementMethodChangedOthersNulled(
      IngredientMeasurementMethodChangedOthersNulled event,
      Emitter<RecipeState> emit) {
    List<Recipe> recipes = List.from(state.recipes);
    int changedRecipeIndex = recipes.indexOf(event.recipe);

    List<Ingredient> ingredients =
        List.from(recipes[changedRecipeIndex].ingredients);
    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    List<Measurement> measurements = List.from(recipes[changedRecipeIndex]
        .ingredients[changedIngredientIndex]
        .measurements);
    int changedmeasurementIndex = event.measurementIndex;

    // since copyWith does not allow to null attributes, create new instance and
    // copy the original id and changed method (thus nulling value and unit)
    Measurement measurement = Measurement();

    measurement = measurement.copyWith(
        id: measurements[changedmeasurementIndex].id,
        measurementMethod: event.measurementMethod);

    measurements.removeAt(changedmeasurementIndex);
    measurements.insert(changedmeasurementIndex, measurement);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(measurements: measurements, saved: false);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(ingredients: ingredients, date: _getCurrentDate());

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
        .copyWith(measurements: measurements, saved: false);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(ingredients: ingredients, date: _getCurrentDate());

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
        .copyWith(measurements: measurements, saved: false);

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    Recipe recipe = recipes[changedRecipeIndex]
        .copyWith(ingredients: ingredients, date: _getCurrentDate());

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

  Recipe? _getRecipeIfAlreadyExists(recipeNumber) {
    List<Recipe> deviceRecipes = List<Recipe>.from(state.recipes);
    for (Recipe recipe in deviceRecipes) {
      if (recipe.number == recipeNumber) {
        return recipe;
      }
    }
    return null;
  }

  Future<void> _onRecipesImported(
      RecipesImported event, Emitter<RecipeState> emit) async {
    // TODO: Breakdown function into sub-functions for readability
    emit(state.copyWith(recipeImportStatus: '')); // Clear status for snackbar
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        // TODO: Implement extension restriction once csv is supported by package
        // type: FileType.custom,
        // allowedExtensions: ['csv'],
        );

    if (result == null) {
      emit(state.copyWith(recipeImportStatus: 'File not selected'));
      return;
    }
    final input = File(result.files.single.path!).openRead();
    var lineEndSetting =
        const FirstOccurrenceSettingsDetector(eols: ['\r\n', '\n']);

    List data = await input
        .transform(utf8.decoder)
        .transform(CsvToListConverter(csvSettingsDetector: lineEndSetting))
        .toList();

    int headingLinePosition = 0;
    data.removeAt(headingLinePosition);

    List<Recipe> newRecipes = [];
    List<String> newerRecipesRecipeIds = [];
    List<Recipe> existingRecipes = List<Recipe>.from(state.recipes);

    int recipeInfoColumnNumber = 13;
    for (List row in data) {
      if (row.length < recipeInfoColumnNumber) {
        emit(state.copyWith(
            recipeImportStatus: 'Import file has too few columns'));
        return;
      }
      String employeeNumber = row[0].toString(); // toString prevents type bugs
      String recipeNumber = row[1];
      String date = row[2];
      String recipeName = row[3];
      String recipeType = row[4];
      String recipeAttribute = row[5];
      String recipeMeasurement = row[6];
      String recipeProbeName = row[7];
      String recipeProbeAnswers = row[8];
      String ingredientName = row[9];
      String ingredientDescription = row[10];
      String ingredientCookingState = row[11];
      String ingredientMeasurement = row[12];

      Recipe? recipeOnDevice = _getRecipeIfAlreadyExists(recipeNumber);

      if (newerRecipesRecipeIds.contains(recipeNumber)) {
        continue;
      } else if (recipeOnDevice != null) {
        if (DateTime.parse(recipeOnDevice.date).isAfter(DateTime.parse(date))) {
          newerRecipesRecipeIds.add(recipeNumber);
          continue;
        } else {
          existingRecipes.remove(recipeOnDevice);
        }
      }

      Recipe recipe = Recipe(
          employeeNumber: employeeNumber,
          number: recipeNumber,
          date: date,
          name: recipeName,
          type: '$recipeType Recipe',
          measurements: const [],
          saved: true);

      for (Recipe existingRecipe in newRecipes) {
        if (existingRecipe.number == recipeNumber) {
          recipe = existingRecipe;
          newRecipes.remove(existingRecipe);
          break;
        }
      }

      if (recipeAttribute == 'Measurement') {
        List<Measurement> measurements = List.from(recipe.measurements);

        List<String> newMeasurements = recipeMeasurement.split('+');
        for (String newMeasurement in newMeasurements) {
          List<String> fields = newMeasurement.trim().split('_');
          final measurement = Measurement(
              id: const Uuid().v4(),
              method: fields[0],
              value: fields[1],
              unit: fields[2]);
          measurements.add(measurement);
        }

        recipe = recipe.copyWith(measurements: measurements);
      } else if (recipeAttribute == 'Probe') {
        List<Probe> probes = List.from(recipe.probes);

        List<String> probeAnswers = recipeProbeAnswers.split('+');
        List<ProbeOption> probeOptions = [];
        for (String answer in probeAnswers) {
          probeOptions
              .add(ProbeOption(option: answer.trim(), id: const Uuid().v4()));
        }
        final probe = Probe(name: recipeProbeName, probeOptions: probeOptions);
        probes.add(probe);

        recipe = recipe.copyWith(probes: probes);
      } else if (recipeAttribute == 'Ingredient') {
        List<Ingredient> ingredients = List.from(recipe.ingredients);

        List<Measurement> measurements = [];
        List<String> newMeasurements = ingredientMeasurement.split('+');
        for (String newMeasurement in newMeasurements) {
          List<String> fields = newMeasurement.trim().split('_');
          final measurement = Measurement(
              id: const Uuid().v4(),
              method: fields[0],
              value: fields[1],
              unit: fields[2]);
          measurements.add(measurement);
        }
        final ingredient = Ingredient(
            id: const Uuid().v4(),
            name: ingredientName,
            description: ingredientDescription,
            cookingState: ingredientCookingState,
            measurements: measurements,
            saved: true); // TODO: Figure out food composition implementation
        ingredients.add(ingredient);

        recipe = recipe.copyWith(ingredients: ingredients);
      } else {
        continue; // Skip line with bad recipe attribute
      }

      newRecipes.add(recipe);
    }

    for (Recipe recipe in newRecipes) {
      if (recipe.measurements.isEmpty) {
        // Protect against recipes without Measurements
        Recipe recipeWithMeasurement =
            recipe.copyWith(measurements: [Measurement(id: const Uuid().v4())]);
        newRecipes.remove(recipe);
        newRecipes.add(recipeWithMeasurement);
      }
    }

    List<Recipe> recipes = existingRecipes + newRecipes;
    // TODO: Approach currently overwrites older recipes with newer ones.
    // Inform user of number of recipes overwritten.
    // TODO: Give user option to not overwrite older recipes with new recipes.
    emit(state.copyWith(
        recipes: recipes,
        recipeImportStatus:
            'Imported ${newRecipes.length} recipe(s) successfully'));
  }
}
