import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:gibsonify/recipe/models/recipe_ingredient.dart';
import 'package:uuid/uuid.dart';

class Recipe extends Equatable {
  Recipe({
    this.recipeName = const RecipeName.pure(),
    String? recipeNumber,
    this.recipeType = "",
    this.recipeVolume = const RecipeVolume.pure(),
    this.ingredients = const <Ingredient>[],
    this.probes = const <Map<String, dynamic>>[],
    this.saved = false,
  }) : recipeNumber = recipeNumber ?? const Uuid().v4();

  final RecipeName recipeName;
  final String recipeNumber;
  final String recipeType;
  final RecipeVolume recipeVolume;
  final List<Ingredient> ingredients;
  final List<Map<String, dynamic>> probes;
  final bool saved;

  Recipe copyWith({
    RecipeName? recipeName,
    String? recipeNumber,
    String? recipeType,
    RecipeVolume? recipeVolume,
    List<Ingredient>? ingredients,
    List<Map<String, dynamic>>? probes,
    bool? saved,
  }) {
    return Recipe(
      recipeName: recipeName ?? this.recipeName,
      recipeNumber: recipeNumber ?? this.recipeNumber,
      recipeType: recipeType ?? this.recipeType,
      recipeVolume: recipeVolume ?? this.recipeVolume,
      ingredients: ingredients ?? this.ingredients,
      probes: probes ?? this.probes,
      saved: saved ?? this.saved,
    );
  }

  @override
  List<Object> get props => [
        recipeName,
        recipeNumber,
        recipeType,
        recipeVolume,
        ingredients,
        probes,
        saved,
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
