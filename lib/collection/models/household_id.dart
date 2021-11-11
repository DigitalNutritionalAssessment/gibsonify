import 'package:formz/formz.dart';

enum HouseholdIdValidationError { invalid }

class HouseholdId extends FormzInput<String, HouseholdIdValidationError> {
  const HouseholdId.pure() : super.pure('');
  const HouseholdId.dirty([String value = '']) : super.dirty(value);

  @override
  HouseholdIdValidationError? validator(String value) {
    // TODO: Add validation based on ICRISAT's criteria, currently
    // only checks if at least 2 symbols
    return value.length > 1 ? null : HouseholdIdValidationError.invalid;
  }
}
