import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:gibsonify/recipe/models/models.dart';
import 'package:gibsonify/recipe/recipe.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(const RecipeState()) {
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

  void _recipeNameChanged(RecipeNameChanged event, Emitter<RecipeState> emit) {
    final recipeName = RecipeName.dirty(event.recipeName);
    emit(state.copyWith(
        recipeName: recipeName,
        recipeStatus: Formz.validate([
          recipeName,
          state.recipeNumber,
          state.recipeVolume,
        ])));
  }

  void _recipeNumberChanged(
      RecipeNumberChanged event, Emitter<RecipeState> emit) {
    final recipeNumber = RecipeNumber.dirty(event.recipeNumber);
    emit(state.copyWith(
        recipeNumber: recipeNumber,
        recipeStatus: Formz.validate([
          state.recipeName,
          recipeNumber,
          state.recipeVolume,
        ])));
  }

  void _recipeVolumeChanged(
      RecipeVolumeChanged event, Emitter<RecipeState> emit) {
    final recipeVolume = RecipeVolume.dirty(event.recipeVolume);
    emit(state.copyWith(
        recipeVolume: recipeVolume,
        recipeStatus: Formz.validate([
          state.recipeName,
          state.recipeNumber,
          recipeVolume,
        ])));
  }

  void _onIngredientAdded(IngredientAdded event, Emitter<RecipeState> emit) {
    final ingredient = Ingredient();
    List<Ingredient> ingredients = List.from(state.ingredients);
    ingredients.add(ingredient);

    emit(state.copyWith(ingredients: ingredients));
  }

  void _onIngredientNameChanged(
      IngredientNameChanged event, Emitter<RecipeState> emit) {
    List<Ingredient> ingredients = List.from(state.ingredients);

    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(name: Name.dirty(event.ingredientName));

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    emit(state.copyWith(ingredients: ingredients));
  }

  void _onIngredientDescriptionChanged(
      IngredientDescriptionChanged event, Emitter<RecipeState> emit) {
    List<Ingredient> ingredients = List.from(state.ingredients);

    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(description: Description.dirty(event.ingredientDescription));

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    emit(state.copyWith(ingredients: ingredients));
  }

  void _onCookingStateChanged(
      CookingStateChanged event, Emitter<RecipeState> emit) {
    List<Ingredient> ingredients = List.from(state.ingredients);

    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(cookingState: CookingState.dirty(event.cookingState));

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    emit(state.copyWith(ingredients: ingredients));
  }

  void _onMeasurementMethodChanged(
      MeasurementMethodChanged event, Emitter<RecipeState> emit) {
    List<Ingredient> ingredients = List.from(state.ingredients);

    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex].copyWith(
        measurementMethod: MeasurementMethod.dirty(event.measurementMethod));

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    emit(state.copyWith(ingredients: ingredients));
  }

  void _onMeasurementChanged(
      MeasurementChanged event, Emitter<RecipeState> emit) {
    List<Ingredient> ingredients = List.from(state.ingredients);

    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(measurement: Measurement.dirty(event.measurement));

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    emit(state.copyWith(ingredients: ingredients));
  }

  void _onMeasurementUnitChanged(
      MeasurementUnitChanged event, Emitter<RecipeState> emit) {
    List<Ingredient> ingredients = List.from(state.ingredients);

    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex].copyWith(
        measurementUnit: MeasurementUnit.dirty(event.measurementUnit));

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    emit(state.copyWith(ingredients: ingredients));
  }

  void _onSizeChanged(SizeChanged event, Emitter<RecipeState> emit) {
    List<Ingredient> ingredients = List.from(state.ingredients);

    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(size: Size.dirty(event.size));

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    emit(state.copyWith(ingredients: ingredients));
  }

  void _onSizeNumberChanged(
      SizeNumberChanged event, Emitter<RecipeState> emit) {
    List<Ingredient> ingredients = List.from(state.ingredients);

    int changedIngredientIndex = ingredients.indexOf(event.ingredient);

    Ingredient ingredient = ingredients[changedIngredientIndex]
        .copyWith(sizeNumber: SizeNumber.dirty(event.sizeNumber));

    ingredients.removeAt(changedIngredientIndex);
    ingredients.insert(changedIngredientIndex, ingredient);

    emit(state.copyWith(ingredients: ingredients));
  }
}
//   void _saveRecipeButtonPressed(
//       SaveRecipeButtonPressed event, Emitter<RecipeState> emit) {
//     final List recipeInfo = [
//       state.recipeName.value,
//       state.recipeNumber.value,
//       state.recipeVolume.value
//     ];
//     emit(state.copyWith(recipeInfo: recipeInfo));
//   }
// }
