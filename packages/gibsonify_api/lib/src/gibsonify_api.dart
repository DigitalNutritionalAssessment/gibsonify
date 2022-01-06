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
  static const recipesKey = 'gibsonify_recipes_key';

  // TODO: add documentation
  List<Recipe> loadRecipes() {
    List<Recipe> recipes = [];
    print('API: loading recipes from local storage'); // TODO: delete
    String? recipesRaw = _sharedPreferences.getString(recipesKey);
    if (recipesRaw == null || recipesRaw.isEmpty == true) {
      print('API: no recipes found'); // TODO: delete
      return [];
    } else {
      try {
        print('API: found something in storage, decoding'); // TODO: delete
        List<dynamic> partiallyDecodedRecipes = jsonDecode(recipesRaw);
        print(
            'API: partially decoded ${partiallyDecodedRecipes.length} recipes'); // TODO: delete
        print(partiallyDecodedRecipes);

        // print('API: type is:');
        // print(partiallyDecodedRecipes.first.runtimeType);

        // recipes = List<Recipe>.from(
        //     partiallyDecodedRecipes.map((x) => Recipe.fromJson(x)));

        // print('API: partially decoding first recipe'); // TODO: delete
        // Recipe hahaRecipe = Recipe.fromJson(partiallyDecodedRecipes.first);
        // print('API: first recipe partially decoded'); // TODO: delete
        // print(hahaRecipe);
        recipes =
            partiallyDecodedRecipes.map((e) => Recipe.fromJson(e)).toList();
        print('API: fully decoded ${recipes.length} recipes'); // TODO: delete
      } catch (e) {
        print(e);
        print('API: recipes could not be decoded'); // TODO: delete
        return [];
      }
      return recipes;
    }
  }

  Future<void> saveRecipes(List<Recipe> recipes) {
    print('API: encoding ${recipes.length} recipes'); // TODO: delete
    String recipesEncoded = jsonEncode(recipes);
    print(recipesEncoded);

    // TODO: delete
    /*
    print('first recipe encoding and decoding');

    String encoded = jsonEncode(recipes.first);

    try {
      var partiallyDecoded = jsonDecode(encoded);
      print(partiallyDecoded);
      print(partiallyDecoded.runtimeType);
      print('partially decoed,now going fully');
      Recipe rerere = Recipe.fromJson(partiallyDecoded);
      print('rec:');
      print(rerere);
    } catch (e) {
      print(e);
    }

    print('recipe');


    // print('LOLLL starting to partially decode it now');
    // List<dynamic> partiallyDecodedRecipes = jsonDecode(recipesEncoded);
    // print('LOLLL starting to fully decode it now');
    // try {
    //   List<Recipe> decodedRecipes =
    //       partiallyDecodedRecipes.map((e) => Recipe.fromJson(e)).toList();
    //   print('LOLLL decoded ${decodedRecipes.length} recipes');
    // } catch (e) {
    //   print(e);
    // }
    // delete up to here
    */
    print(
        'API: ${recipes.length} recipes encoded, saving them now'); // TODO: delete
    return _sharedPreferences.setString(recipesKey, recipesEncoded);
  }

  // TODO: investigate changing this to a list of non-nullable GibsonsForms
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
    // TODO: delete
    /*
    print('before');
    List<dynamic> partiallyDecodedGibsonsForms =
        jsonDecode(gibsonsFormsEncoded);
    List<GibsonsForm> gibsonsFormsHaha = partiallyDecodedGibsonsForms
        .map((e) => GibsonsForm.fromJson(e))
        .toList();
    print(gibsonsFormsHaha);
    print('after');
    */
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
