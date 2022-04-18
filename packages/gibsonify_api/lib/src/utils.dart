/// Checks whether the `String` field is not null and not an empty string, which,
/// in a user input form field case, indicates that the user has modified the
/// input and left it empty. In many cases this is used as a validator to check
/// if to display an error text in a form field when the user input should not
/// be empty after being modified by the user.
bool isFieldModifiedAndEmpty(String? field) {
  if (field != null && field.isEmpty) {
    return true;
  } else {
    return false;
  }
}

/// Checks whether the String field is null or an empty string, which, in a user
/// input form field case, indicates that the user has not modified the input or
/// has left it empty. In many cases this is used to check whether to display
/// a replacement for an empty object name that is yet to be user supplied.
bool isFieldUnmodifiedOrEmpty(String? field) {
  if (field == null || field.isEmpty) {
    return true;
  } else {
    return false;
  }
}

/// Checks whether the String field is not `null` and not an empty string, which
/// usually corresponds to a string attribute being valid.
bool isFieldNotNullAndNotEmpty(String? field) {
  if (field != null && field.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

/// Checks whether the String field is not `null` and not valid, which, in a user
/// input form field case, usually corresponds to the condition for displaying
/// and error text in the case where the user has modified the field and the
/// value does not satisfy the validator of the field.
bool isFieldModifiedAndInvalid(String? field, bool Function() fieldValidator) {
  if (field != null && !fieldValidator()) {
    return true;
  }
  return false;
}
