import 'package:gibsonify_repository/gibsonify_repository.dart';

import 'package:gibsonify_api/gibsonify_api.dart';

/// Repository that handles requests for GibsonsForms and Recipes
class GibsonifyRepository {
  final GibsonifyApi _gibsonifyApi;

  const GibsonifyRepository({required GibsonifyApi gibsonifyApi})
      : _gibsonifyApi = gibsonifyApi;

  Future<void> saveForm(GibsonsForm gibsonsForm) =>
      _gibsonifyApi.saveForm(gibsonsForm);

  // TODO: investigate providing a Stream of forms instead
  List<GibsonsForm?> loadForms() => _gibsonifyApi.loadForms();

  void deleteForm(String id) => _gibsonifyApi.deleteForm(id);

  // TODO: We should think about how this will scale with lots of recipes
  List<Recipe> loadRecipes() => _gibsonifyApi.loadRecipes();

  Future<void> saveRecipes(List<Recipe> recipes) =>
      _gibsonifyApi.saveRecipes(recipes);
}
