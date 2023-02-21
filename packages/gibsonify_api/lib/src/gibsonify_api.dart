import 'dart:convert';

import 'package:gibsonify_api/gibsonify_api.dart';

/// API that handles requests for Gibsons Forms and Recipes. Provides
/// functionality for loading and saving Forms and Recipes to local storage by
/// using the SharedPreferences plugin.
class GibsonifyApi {
  final SharedPreferences _sharedPreferences;
  GibsonifyApi({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  static const recipesKey = 'gibsonify_recipes_key';
  static const loginInfoKey = 'gibsonify_login_info_key';

  LoginInfo loadLoginInfo() {
    String? loginInfoRaw = _sharedPreferences.getString(loginInfoKey);
    if (loginInfoRaw != null && loginInfoRaw.isEmpty != true) {
      try {
        dynamic partiallyDecodedLoginInfo = jsonDecode(loginInfoRaw);
        return LoginInfo.fromJson(partiallyDecodedLoginInfo);
      } catch (e) {
        return LoginInfo();
      }
    }
    return LoginInfo();
  }

  Future<void> saveLoginInfo(LoginInfo loginInfo) {
    String loginInfoEncoded = jsonEncode(loginInfo);
    return _sharedPreferences.setString(loginInfoKey, loginInfoEncoded);
  }

  /// Attempts to load a list of Recipes from shared preferences local storage.
  /// Returns an empty list if no data is found or data cannot be decoded.
  List<Recipe> loadRecipes() {
    List<Recipe> recipes = [];
    String? recipesRaw = _sharedPreferences.getString(recipesKey);
    if (recipesRaw == null || recipesRaw.isEmpty == true) {
      return [];
    } else {
      try {
        List<dynamic> partiallyDecodedRecipes = jsonDecode(recipesRaw);
        recipes =
            partiallyDecodedRecipes.map((e) => Recipe.fromJson(e)).toList();
      } catch (e) {
        return [];
      }
      return recipes;
    }
  }

  Future<void> saveRecipes(List<Recipe> recipes) {
    String recipesEncoded = jsonEncode(recipes);
    return _sharedPreferences.setString(recipesKey, recipesEncoded);
  }
}
