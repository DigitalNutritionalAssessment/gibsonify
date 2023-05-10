/// API, models, and helper functions that handle Gibsonify data structures.
library gibsonify_api;

import 'package:hive/hive.dart';

import 'gibsonify_api.dart';

export 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

export 'src/gibsonify_api.dart';
export 'src/utils.dart';
export 'src/csv_export_utils.dart';
export 'src/models/models.dart';

void registerAdapters() {
  Hive.registerAdapter(HouseholdAdapter());
  Hive.registerAdapter(RespondentAdapter());
  Hive.registerAdapter(SexAdapter());
  Hive.registerAdapter(LiteracyLevelAdapter());
  Hive.registerAdapter(OccupationAdapter());
  Hive.registerAdapter(GibsonsFormAdapter());
  Hive.registerAdapter(PhysioStatusAdapter());
  Hive.registerAdapter(FoodItemAdapter());
  Hive.registerAdapter(MeasurementAdapter());
  Hive.registerAdapter(RecipeAdapter());
  Hive.registerAdapter(IngredientAdapter());
  Hive.registerAdapter(ProbeAdapter());
  Hive.registerAdapter(ProbeOptionAdapter());
  Hive.registerAdapter(AnthropometricsAdapter());
  Hive.registerAdapter(SurveyAdapter());
}
