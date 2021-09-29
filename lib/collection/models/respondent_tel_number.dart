import 'package:formz/formz.dart';

enum RespondentTelNumberValidationError { invalid }

class RespondentTelNumber
    extends FormzInput<String, RespondentTelNumberValidationError> {
  const RespondentTelNumber.pure() : super.pure('');
  const RespondentTelNumber.dirty([String value = '']) : super.dirty(value);

  @override
  RespondentTelNumberValidationError? validator(String? value) {
    // TODO: Add (Regex?) number validation, currently only checks if not empty
    // also probably could be empty? So check if either empty or valid number
    return value?.isNotEmpty == true
        ? null
        : RespondentTelNumberValidationError.invalid;
  }
}
