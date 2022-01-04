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

  GibsonsForm loadForm() => _gibsonifyApi.loadForm(); // TODO: delete

  void deleteForm(String id) => _gibsonifyApi.deleteForm(id);
}
