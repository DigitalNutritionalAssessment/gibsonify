import 'package:formz/formz.dart';

enum HouseholdIdValidationError { invalid }

class HouseholdId extends FormzInput<String, HouseholdIdValidationError> {
  const HouseholdId.pure() : super.pure('');
  const HouseholdId.dirty([String value = '']) : super.dirty(value);

  @override
  HouseholdIdValidationError? validator(String? value) {
    // TODO: Add validation based on ICRISAT's criteria, currently
    // only checks if at least 10 symbols

    // TODO: refactor with a better null check
    return (value ?? '').length > 9 ? null : HouseholdIdValidationError.invalid;
  }
}
