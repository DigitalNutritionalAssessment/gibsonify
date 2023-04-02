import 'package:gibsonify_api/gibsonify_api.dart';

/// Returns a `String` representation of a combination of measurements in the
/// current format specified by the import/export Gibsonify templates.
/// Measurement fields are separated by `_` (underscore) and measurements are
/// separated by `+` (plus).
String combineMeasurements(List<Measurement> measurements) {
  // TODO: think of a different measurement format than this _ + one
  return measurements
      .map((measurement) =>
          '${measurement.method}_${measurement.value}_${measurement.unit}')
      .join(' + ');
}

/// Converts a `List` of `Household` elements into the legacy CSV format
/// for Gibsons forms export. See dev_tools/gibsons_form_example.csv.
String householdsToLegacyCsvExport(List<Household> households) {
  String csv = 'Collection ID,Employee Number,Household ID,Respondent Name,'
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

  for (Household household in households) {
    for (Respondent respondent in household.respondents.values) {
      for (GibsonsForm gibsonsForm in respondent.collections) {
        if (gibsonsForm.finished) {
          csv += gibsonsForm.toCsv(
              household.householdId,
              respondent.name,
              "",
              "",
              respondent.phoneNumber,
              household.sensitizationDate.toString(),
              household.geoLocation);
        }
      }
    }
  }

  return csv;
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
