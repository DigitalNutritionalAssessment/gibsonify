import 'package:gibsonify_api/gibsonify_api.dart';

/// Returns a `String` representation of a combination of measurements in the
/// current format specified by the import/export Gibsonify templates.
/// Measurement fields are separated by `_` (underscore) and measurements are
/// separated by `+` (plus).
String combineMeasurements(List<Measurement> measurements) {
  // TODO: think of a different measurement format than this _ + one
  String measurementsCombined = '';
  for (Measurement measurement in measurements) {
    measurementsCombined = measurementsCombined +
        '${measurement.method}_'
            '${measurement.value}_${measurement.unit} + ';
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
