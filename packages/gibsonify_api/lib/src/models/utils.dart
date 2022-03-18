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
