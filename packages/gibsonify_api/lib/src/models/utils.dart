/// Checks whether the String field is not null and not an empty string, which,
/// in an user input form field case, indicates that the user has modified the
/// input and left it easy. In many cases this is used as a validator to check
/// if to display an error text in a form field when the user input should not
/// be empty after being modified by the user.
bool isFieldModifiedAndEmpty(String? field) {
  if (field != null && field.isEmpty) {
    return true;
  } else {
    return false;
  }
}
