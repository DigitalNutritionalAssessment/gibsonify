import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:gibsonify/recipe/models/models.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(const RecipeState()) {
    on<RecipeNameChanged>(_recipeNameChanged);
    on<RecipeNumberChanged>(_recipeNumberChanged);
    on<RecipeVolumeChanged>(_recipeVolumeChanged);
    on<RecipeNameUnfocused>(_onRecipeNameUnfocused);
    on<RecipeNumberUnfocused>(_onRecipeNumberUnfocused);
    on<RecipeVolumeUnfocused>(_onRecipeVolumeUnfocused);
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

  void _onRecipeNameUnfocused(
      RecipeNameUnfocused event, Emitter<RecipeState> emit) {
    final recipeName = RecipeName.dirty(state.recipeName.value);
    emit(state.copyWith(
        recipeName: recipeName,
        recipeStatus: Formz.validate([
          recipeName,
          state.recipeNumber,
          state.recipeVolume,
        ])));
  }

  void _onRecipeNumberUnfocused(
      RecipeNumberUnfocused event, Emitter<RecipeState> emit) {
    final recipeNumber = RecipeNumber.dirty(state.recipeNumber.value);
    emit(state.copyWith(
        recipeNumber: recipeNumber,
        recipeStatus: Formz.validate([
          state.recipeName,
          recipeNumber,
          state.recipeVolume,
        ])));
  }

  void _onRecipeVolumeUnfocused(
      RecipeVolumeUnfocused event, Emitter<RecipeState> emit) {
    final recipeVolume = RecipeVolume.dirty(state.recipeVolume.value);
    emit(state.copyWith(
        recipeVolume: recipeVolume,
        recipeStatus: Formz.validate([
          state.recipeName,
          state.recipeNumber,
          recipeVolume,
        ])));
  }
}
