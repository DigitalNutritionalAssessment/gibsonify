import 'package:gibsonify_api/gibsonify_api.dart';

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

/// Returns a `String` representation of a combination of measurements in the
/// current format specified by the import/export Gibsonify templates.
/// Measurement fields are separated by `_` (underscore) and measurements are
/// separated by `+` (plus).
String combineMeasurements(List<Measurement> measurements) {
  // TODO: think of a different measurement format than this _ + one
  String measurementsCombined = '';
  for (Measurement measurement in measurements) {
    measurementsCombined = measurementsCombined +
        '${measurement.measurementMethod}_'
            '${measurement.measurementValue}_${measurement.measurementUnit} + ';
  }

  measurementsCombined = measurementsCombined.substring(
      0, measurementsCombined.length - ' + '.length);
  return measurementsCombined;
}

/// Converts a `List` of nullable `GibsonsForm` elements into a csv-formatted
/// `String`.
String convertFinishedGibsonsFormsToCsv(List<GibsonsForm?> gibsonsForms) {
  String finishedGibsonsFormsCsvHeader =
      'Collection ID,Employee Number,Household ID,Respondent Name,'
      'Respondent Country Code,Respondent Tel Number Prefix,'
      'Respondent Tel Number,Sensitization Date,Recall Day,'
      'Interview Date,Interview Start Time,GPS Location,'
      'Picture Chart Collected,Picture Chart Not Collected Reason,'
      'Interview End Time,Interview Finished In One Visit,'
      'Second Interview Visit Date,Second Visit Reason,Interview Outcome,'
      'Interview Not Completed Reason,Comments,Is Finished,Food Item ID,'
      'Food Item Name,Food Item Time Period,Food Item Source,'
      'Ingredients Description,Preparation Method,Confirmed,'
      'Recipe Number,Recipe Date,Recipe Name,Measurements\n';

  String finishedGibsonsFormsCsv = finishedGibsonsFormsCsvHeader;

  for (GibsonsForm? gibsonsForm in gibsonsForms) {
    if (gibsonsForm != null && gibsonsForm.finished) {
      finishedGibsonsFormsCsv += gibsonsForm.toCsv();
    }
  }
  return finishedGibsonsFormsCsv;
}

/// Converts a `List` of nullable `Recipe` elements into a csv-formatted
/// `String`.
String convertRecipesToCsv(List<Recipe> recipes) {
  String recipesCsvHeader =
      'Employee Number,Recipe Number,Date,Recipe Name,Recipe Type,'
      'Recipe attribute,Recipe Measurement,Recipe Probe Name,'
      'Recipe Probe Answers,Ingredient Name,Ingredient Description,'
      'Cooking State,Ingredient Measurement\n';

  String recipesCsv = recipesCsvHeader;

  for (Recipe recipe in recipes) {
    recipesCsv += recipe.toCsv();
  }

  return recipesCsv;
}
