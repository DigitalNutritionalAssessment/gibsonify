import 'package:formz/formz.dart';

enum RespondentNameValidationError { invalid }

class RespondentName extends FormzInput<String, RespondentNameValidationError> {
  const RespondentName.pure() : super.pure('');
  const RespondentName.dirty([String value = '']) : super.dirty(value);

  @override
  RespondentNameValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : RespondentNameValidationError.invalid;
  }
}
