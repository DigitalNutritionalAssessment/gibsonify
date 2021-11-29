import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:gibsonify/recipe/models/recipe_ingredient.dart';
import 'package:uuid/uuid.dart';

class Recipe extends Equatable {
  Recipe(
      {this.recipeName = const RecipeName.pure(),
      this.recipeNumber = const RecipeNumber.pure(),
      this.recipeType = "",
      this.recipeVolume = const RecipeVolume.pure(),
      this.ingredients = const <Ingredient>[],
      this.saved = false,
      String? id})
      : id = id ?? const Uuid().v4();

  final RecipeName recipeName;
  final RecipeNumber recipeNumber;
  final String recipeType;
  final RecipeVolume recipeVolume;
  final List<Ingredient> ingredients;
  final bool saved;
  final String id;

  Recipe copyWith(
      {RecipeName? recipeName,
      RecipeNumber? recipeNumber,
      String? recipeType,
      RecipeVolume? recipeVolume,
      List<Ingredient>? ingredients,
      bool? saved,
      String? id}) {
    return Recipe(
        recipeName: recipeName ?? this.recipeName,
        recipeNumber: recipeNumber ?? this.recipeNumber,
        recipeType: recipeType ?? this.recipeType,
        recipeVolume: recipeVolume ?? this.recipeVolume,
        ingredients: ingredients ?? this.ingredients,
        saved: saved ?? this.saved,
        id: id ?? this.id);
  }

  @override
  List<Object> get props => [
        recipeName,
        recipeNumber,
        recipeType,
        recipeVolume,
        ingredients,
        saved,
        id
      ];
}

enum RecipeNameValidationError { invalid }

class RecipeName extends FormzInput<String, RecipeNameValidationError> {
  const RecipeName.pure() : super.pure('');
  const RecipeName.dirty([String value = '']) : super.dirty(value);

  @override
  RecipeNameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : RecipeNameValidationError.invalid;
  }
}

enum RecipeNumberValidationError { invalid }

class RecipeNumber extends FormzInput<String, RecipeNumberValidationError> {
  const RecipeNumber.pure() : super.pure('');
  const RecipeNumber.dirty([String value = '']) : super.dirty(value);

  @override
  RecipeNumberValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : RecipeNumberValidationError.invalid;
  }
}

enum RecipeVolumeValidationError { invalid }

class RecipeVolume extends FormzInput<String, RecipeVolumeValidationError> {
  const RecipeVolume.pure() : super.pure('');
  const RecipeVolume.dirty([String value = '']) : super.dirty(value);

  @override
  RecipeVolumeValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : RecipeVolumeValidationError.invalid;
  }
}
