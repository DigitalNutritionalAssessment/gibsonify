import 'package:formz/formz.dart';

enum InterviewDateValidationError { invalid }

class InterviewDate extends FormzInput<String, InterviewDateValidationError> {
  const InterviewDate.pure() : super.pure('');
  const InterviewDate.dirty([String value = '']) : super.dirty(value);

  @override
  InterviewDateValidationError? validator(String? value) {
    // TODO: Add validation, currently only checks if not empty
    return value?.isNotEmpty == true
        ? null
        : InterviewDateValidationError.invalid;
  }
}
