import 'package:formz/formz.dart';

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
