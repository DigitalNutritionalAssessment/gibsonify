import 'dart:convert';

import 'package:gibsonify_api/gibsonify_api.dart';

/// API that handles requests for Gibsons Forms and Recipes.
class GibsonifyApi {
  final SharedPreferences _sharedPreferences;
  GibsonifyApi({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  static const gibsonFormsKey = 'gibsonify_gibsons_forms_key';

  /// Attempts to load a list Forms from shared preferences local storage.
  /// Returns an empty list if no data is found or data cannot be decoded.
  List<GibsonsForm?> loadForms() {
    List<GibsonsForm?> gibsonsForms = [];
    print('API: loading Forms from local storage!'); // TODO: delete
    String? gibsonsFormsRaw = _sharedPreferences.getString(gibsonFormsKey);
    if (gibsonsFormsRaw == null || gibsonsFormsRaw.isEmpty == true) {
      print(
          'API: no data found in storage, returning an empty list'); // TODO: delete
      return [];
    } else {
      print('API: found some data in storage, decoding'); // TODO: delete
      print(gibsonsFormsRaw); // TODO: delete
      try {
        List<dynamic> partiallyDecodedGibsonsForms =
            jsonDecode(gibsonsFormsRaw);
        print(
            'API: Raw input decoded, proceeding to decode Forms'); // TODO: delete
        gibsonsForms = partiallyDecodedGibsonsForms
            .map((e) => GibsonsForm.fromJson(e))
            .toList();
        print('API: decoded ${gibsonsForms.length} forms'); // TODO: delete
      } catch (e) {
        print(
            'API: Error decoding data from storage, returning an empty list'); // TODO: delete
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
      print(
          'API: no valid Forms found in storage, saving the first Form'); // TODO: delete
      gibsonsForms = [gibsonsForm];
    } else {
      print(
          'API: Looking for match in ${gibsonsForms.length} forms'); // TODO: delete
      // Null assertion operator is used here since if gibsonsForms is not empty
      // then all its elements come from GibsonsForm.fromJson, so are not null.
      int gibsonsFormIndex =
          gibsonsForms.indexWhere((form) => form!.id == gibsonsForm.id);
      if (gibsonsFormIndex >= 0) {
        print(
            'API: match found at index $gibsonsFormIndex, rewriting with new Form'); // TODO: delete
        gibsonsForms[gibsonsFormIndex] = gibsonsForm;
      } else {
        print('API: match not found, adding new Form'); // TODO: delete
        gibsonsForms.add(gibsonsForm);
      }
    }
    String gibsonsFormsEncoded = jsonEncode(gibsonsForms);
    print(
        'API: Form successfuly jsonified, now saving to local storage!'); // TOOD: delete
    return _sharedPreferences.setString(gibsonFormsKey, gibsonsFormsEncoded);
  }

  // TODO: Delete this method
  GibsonsForm loadForm() {
    List<GibsonsForm?> gibsonsForms = loadForms();
    if (gibsonsForms.isEmpty) {
      print(
          'API: no valid Forms found in storage, returning an empty Form'); // TODO: delete
      GibsonsForm gibsonsForm = GibsonsForm();
      return gibsonsForm;
    } else {
      print(
          'API: returning the last of ${gibsonsForms.length} forms'); // TODO: delete
      GibsonsForm? gibsonsForm = gibsonsForms.last;
      return gibsonsForm!;
    }
  }
}
