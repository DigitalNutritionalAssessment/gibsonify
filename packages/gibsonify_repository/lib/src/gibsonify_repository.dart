import 'package:gibsonify_repository/gibsonify_repository.dart';

import 'package:gibsonify_api/gibsonify_api.dart';

/// Repository that handles requests for GibsonsForms and Recipes and LoginInfo
class GibsonifyRepository {
  final GibsonifyApi _gibsonifyApi;

  const GibsonifyRepository({required GibsonifyApi gibsonifyApi})
      : _gibsonifyApi = gibsonifyApi;

  Future<void> saveLoginInfo(LoginInfo loginInfo) =>
      _gibsonifyApi.saveLoginInfo(loginInfo);

  LoginInfo loadLoginInfo() => _gibsonifyApi.loadLoginInfo();

  // TODO: We should think about how this will scale with lots of recipes
  List<Recipe> loadRecipes() => _gibsonifyApi.loadRecipes();

  Future<void> saveRecipes(List<Recipe> recipes) =>
      _gibsonifyApi.saveRecipes(recipes);
}
