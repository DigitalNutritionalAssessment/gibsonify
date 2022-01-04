import 'dart:convert';

import 'package:gibsonify_api/gibsonify_api.dart';

/// API that handles requests for Gibsons Forms and Recipes. Provides
/// functionality for loading and saving Forms and Recipes to local storage by
/// using the SharedPreferences plugin.
class GibsonifyApi {
  final SharedPreferences _sharedPreferences;
  GibsonifyApi({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  static const gibsonFormsKey = 'gibsonify_gibsons_forms_key';

  /// Attempts to load a list Forms from shared preferences local storage.
  /// Returns an empty list if no data is found or data cannot be decoded.
  List<GibsonsForm?> loadForms() {
    List<GibsonsForm?> gibsonsForms = [];
    String? gibsonsFormsRaw = _sharedPreferences.getString(gibsonFormsKey);
    if (gibsonsFormsRaw == null || gibsonsFormsRaw.isEmpty == true) {
      return [];
    } else {
      try {
        List<dynamic> partiallyDecodedGibsonsForms =
            jsonDecode(gibsonsFormsRaw);
        gibsonsForms = partiallyDecodedGibsonsForms
            .map((e) => GibsonsForm.fromJson(e))
            .toList();
      } catch (e) {
        return [];
      }
      return gibsonsForms;
    }
  }

  /// Saves the provided GibsonsForm by loading Forms from local storage,
  /// checking for a match and rewriting and saving if a match is found, or if
  /// no match is found, by adding a new Form and saving the updated list of
  /// GibsonsForms to shared preferences.
  Future<void> saveForm(GibsonsForm gibsonsForm) {
    List<GibsonsForm?> gibsonsForms = loadForms();

    if (gibsonsForms.isEmpty) {
      gibsonsForms = [gibsonsForm];
    } else {
      // Null assertion operator is used here since if gibsonsForms is not empty
      // then all its elements come from GibsonsForm.fromJson, so are not null.
      int gibsonsFormIndex =
          gibsonsForms.indexWhere((form) => form!.id == gibsonsForm.id);
      if (gibsonsFormIndex >= 0) {
        gibsonsForms[gibsonsFormIndex] = gibsonsForm;
      } else {
        gibsonsForms.add(gibsonsForm);
      }
    }
    String gibsonsFormsEncoded = jsonEncode(gibsonsForms);
    return _sharedPreferences.setString(gibsonFormsKey, gibsonsFormsEncoded);
  }

  /// Attempts to delete the form with the given id by loading Forms from
  /// local storage, checking for a match, deleting the given Form if there is a
  /// match, and saving the updated list of GibsonsForms to shared preferences.
  void deleteForm(String id) {
    List<GibsonsForm?> gibsonsForms = loadForms();
    if (gibsonsForms.isEmpty) {
    } else {
      // Null assertion operator is used here just as in saveForm()
      int gibsonsFormIndex = gibsonsForms.indexWhere((form) => form!.id == id);
      if (gibsonsFormIndex >= 0) {
        gibsonsForms.removeAt(gibsonsFormIndex);
      } else {}
      String gibsonsFormsEncoded = jsonEncode(gibsonsForms);
      _sharedPreferences.setString(gibsonFormsKey, gibsonsFormsEncoded);
    }
  }
}
