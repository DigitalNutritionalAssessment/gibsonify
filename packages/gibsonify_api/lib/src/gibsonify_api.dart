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

    // TODO: delete old code
    // List<GibsonsForm> gibsonsForms = [gibsonsForm];
    // String? gibsonsFormsRaw = _sharedPreferences.getString(gibsonFormsKey);

    // if (gibsonsFormsRaw == null || gibsonsFormsRaw.isEmpty == true) {
    //   print(
    //       'API: no Forms found in storage, saving the first Form'); // TODO: delete
    // } else {
    //   print(
    //       'API: found at least one Form in storage, decoding'); // TODO: delete
    //   print(gibsonsFormsRaw); // TODO: delete
    //   // TODO: implement checks on the unsanitized input because if it is in
    //   // incorrect format then json decoding throws an error
    //   List<dynamic> partiallyDecodedGibsonsForms = jsonDecode(gibsonsFormsRaw);
    //   print('LOL PARTIALLY DECODED');
    //   // Map<String, dynamic> partiallyDecodedGibsonsForms = Map<String, dynamic>.from();
    //   gibsonsForms = partiallyDecodedGibsonsForms
    //       .map((e) => GibsonsForm.fromJson(e))
    //       .toList();
    //   print('LOL FULLY DECODED');
    //   int formsNum = gibsonsForms.length; // TODO: delete
    //   print('API: decoded $formsNum forms, checking for match'); // TODO: delete
    //   int gibsonsFormIndex =
    //       gibsonsForms.indexWhere((form) => form.id == gibsonsForm.id);
    //   if (gibsonsFormIndex >= 0) {
    //     print(
    //         'API: match found at index $gibsonsFormIndex, rewriting with new Form'); // TODO: delete
    //     gibsonsForms[gibsonsFormIndex] = gibsonsForm;
    //   } else {
    //     print('API: match not found, adding new Form'); // TODO: delete
    //     gibsonsForms.add(gibsonsForm);
    //   }
    // }

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

    // TODO: delete old code
    // String? gibsonsFormsRaw = _sharedPreferences.getString(gibsonFormsKey);

    // if (gibsonsFormsRaw == null || gibsonsFormsRaw.isEmpty == true) {
    //   print('API: no forms found, returning empty Form'); // TODO: delete
    //   GibsonsForm gibsonsForm = GibsonsForm();
    //   return gibsonsForm;
    // } else {
    //   print(
    //       'API: found at least one Form in storage, decoding, HAHA'); // TODO: delete
    //   print(gibsonsFormsRaw);
    //   List<dynamic> partiallyDecodedGibsonsForms = jsonDecode(gibsonsFormsRaw);
    //   print('LOL PARTIALLY DECODED');
    //   List<GibsonsForm> gibsonsForms = partiallyDecodedGibsonsForms
    //       .map((e) => GibsonsForm.fromJson(e))
    //       .toList();
    //   print('LOL FULLY DECODED');
    //   int formsNum = gibsonsForms.length; // TODO: delete
    //   print(
    //       'API: decoded $formsNum forms, returning the last one'); // TODO: delete
    //   return gibsonsForms.last;
    // }
  }
}
